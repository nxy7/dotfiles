# GitHub Actions runners for WCEEN/cogni.
#
# Isolation model:
#   - All runners run as one unprivileged system user, `runner`, which is in
#     neither `docker` nor `wheel`. Jobs can't get root on the host.
#   - That user has one rootless Docker daemon (a systemd user service).
#     Containers run in its user namespace, so Docker isn't a way to root.
#   - One user means concurrent jobs can see each other: files, processes,
#     environment (including GITHUB_TOKEN) and containers. That includes
#     cogni's release jobs, whose environment holds prod deploy credentials
#     and Android signing keys. Accepted for a private repo where only the
#     team pushes; revisit if outside contributors' pull requests ever run
#     here (moving releases to GitHub-hosted runners is a `runs-on` change).
#   - In exchange, all runners share one Docker image store and one set of
#     download caches (Nix, NuGet, Bun, npm, Playwright), so every job starts
#     warm. Nix's caches are per user (SQLite files only their creator can
#     write), so separate users couldn't share them.
#   - Ephemeral: a runner takes one job, deregisters, and restarts with a
#     wiped state and work directory (which is also its HOME). Caches live
#     outside it.
#   - The GitHub token is only read by root at startup and is hidden from
#     the runner process (the NixOS module does this).
{
  config,
  lib,
  options,
  pkgs,
  ...
}:
let
  # Job steps run directly on this machine, so anything a job listens on (the
  # Postgres service's published port, a dev server for browser tests) is
  # shared by all runners. Concurrent jobs need random host ports
  # (`ports: - 5432` plus `job.services.<name>.ports['5432']`), not fixed ones.
  # 16 threads and 31 GiB RAM; zram and a 34 GiB swap partition absorb peaks.
  runnerCount = 5;

  ids = lib.genList (i: i + 1) runnerCount;
  forEachRunner = f: lib.listToAttrs (map f ids);

  tokenFile = "/var/lib/github-runner-token";
  dockerPackage = config.virtualisation.docker.rootless.package;

  user = "runner";
  # Fixed UID so the Docker socket path (/run/user/<uid>) is known here.
  uid = 900;
  runtimeDir = "/run/user/${toString uid}";
  cacheDir = "/var/cache/github-runner";

  runnerName = id: "cogni-${toString id}";
  # On disk: the module's default work dir is under /run (RAM), which
  # node_modules and build outputs would fill.
  workDir = id: "/var/lib/github-runner-work/${runnerName id}";
in
{
  # ------------------------------------------------------------
  # The runner user and its rootless Docker
  # ------------------------------------------------------------

  users.groups.runners = { };

  users.users.${user} = {
    isSystemUser = true;
    inherit uid;
    group = "runners";
    # Rootless Docker keeps images under ~/.local/share/docker.
    home = "/var/lib/${user}";
    createHome = true;
    # Start this user's systemd manager (and its Docker daemon) at boot,
    # without anyone logging in.
    linger = true;
    # Rootless Docker maps container UIDs into these ranges. NixOS only
    # allocates them automatically for normal users.
    subUidRanges = [
      {
        startUid = 1000000;
        count = 65536;
      }
    ];
    subGidRanges = [
      {
        startGid = 1000000;
        count = 65536;
      }
    ];
  };

  virtualisation.docker.rootless.enable = true;
  # Only the runner user gets a daemon; admin logging in over SSH doesn't.
  systemd.user.services.docker.unitConfig.ConditionGroup = "runners";

  # Rootless Docker isn't covered by virtualisation.docker.autoPrune.
  # Anonymous volumes are pruned too: the Postgres service image declares
  # one, and the runner leaves it behind after each job. Images and volumes
  # that a running job uses are kept.
  systemd.user.services.docker-prune = {
    description = "Prune the runners' rootless Docker";
    unitConfig.ConditionGroup = "runners";
    environment.DOCKER_HOST = "unix://%t/docker.sock";
    serviceConfig.Type = "oneshot";
    script = ''
      ${dockerPackage}/bin/docker system prune --all --force --filter until=168h
      ${dockerPackage}/bin/docker volume prune --all --force
    '';
  };
  systemd.user.timers.docker-prune = {
    wantedBy = [ "timers.target" ];
    unitConfig.ConditionGroup = "runners";
    timerConfig = {
      OnCalendar = "weekly";
      Persistent = true;
    };
  };

  # ------------------------------------------------------------
  # Prebuilt Linux binaries in jobs
  # ------------------------------------------------------------

  # Binaries downloaded by jobs (Playwright's Chromium, NuGet native assets)
  # expect /lib64/ld-linux-x86-64.so.2 and FHS libraries. nix-ld provides
  # both. On top of nix-ld's defaults (libstdc++, zlib, openssl, …) this adds
  # what headless Chromium loads. A job failing with "error while loading
  # shared libraries: libfoo.so" means the package providing libfoo goes here.
  programs.nix-ld = {
    enable = true;
    libraries =
      options.programs.nix-ld.libraries.default
      ++ (with pkgs; [
        alsa-lib
        at-spi2-core # also provides atk and atk-bridge
        cairo
        cups
        dbus
        expat
        fontconfig
        freetype
        glib
        libdrm
        libgbm
        libxkbcommon
        nspr
        nss
        pango
        libX11
        libxcb
        libXcomposite
        libXdamage
        libXext
        libXfixes
        libXrandr
        libxshmfence
      ]);
  };

  # ------------------------------------------------------------
  # Runners
  # ------------------------------------------------------------

  services.github-runners = forEachRunner (
    id:
    lib.nameValuePair (runnerName id) {
      enable = true;
      url = "https://github.com/WCEEN/cogni";
      inherit tokenFile user;
      name = "g5-runner-${toString id}";
      replace = true;
      ephemeral = true;

      # Default labels (self-hosted, Linux, X64) plus these.
      extraLabels = [
        "nixos"
        "g5"
      ];

      group = "runners";
      workDir = workDir id;

      # On top of the module's bash, coreutils, git, tar, gzip and NixOS's
      # findutils, grep and sed: tools GitHub's Ubuntu runners have and
      # actions assume (android-actions/setup-android needs unzip).
      extraPackages = with pkgs; [
        dockerPackage
        bzip2
        curl
        diffutils
        file
        gawk
        gnumake
        gnupatch
        hostname
        jq
        procps
        unzip
        wget
        which
        xz
        zip
        zstd
      ];
      extraEnvironment = {
        DOCKER_HOST = "unix://${runtimeDir}/docker.sock";
        # Services don't get the login-shell variables nix-ld relies on.
        inherit (config.environment.variables) NIX_LD NIX_LD_LIBRARY_PATH;

        # Download caches shared by all runners and kept between jobs (HOME
        # is the work dir, which is wiped before every job). XDG_CACHE_HOME
        # covers Nix's input and evaluation caches.
        XDG_CACHE_HOME = cacheDir;
        NUGET_PACKAGES = "${cacheDir}/nuget/packages";
        NUGET_HTTP_CACHE_PATH = "${cacheDir}/nuget/http-cache";
        # NuGet's cross-process locks; each runner's /tmp is private, so
        # they have to live somewhere all runners see.
        NUGET_SCRATCH = "${cacheDir}/nuget/scratch";
        BUN_INSTALL_CACHE_DIR = "${cacheDir}/bun";
        npm_config_cache = "${cacheDir}/npm";
        PLAYWRIGHT_BROWSERS_PATH = "${cacheDir}/ms-playwright";
        # Tools installed by setup-* actions (setup-java's JDK). The runner
        # reads this from its own environment instead of using _work/_tool.
        RUNNER_TOOL_CACHE = "${cacheDir}/tool-cache";
        AGENT_TOOLSDIRECTORY = "${cacheDir}/tool-cache";
        # android-actions/setup-android installs into ANDROID_SDK_ROOT when
        # it's set; sdkmanager packages then stay installed between jobs.
        ANDROID_HOME = "${cacheDir}/android-sdk";
        ANDROID_SDK_ROOT = "${cacheDir}/android-sdk";
        # Gradle's dependency cache and wrapper downloads. Its gradle.properties
        # (below) turns the daemon off.
        GRADLE_USER_HOME = "${cacheDir}/gradle";
      };

      serviceOverrides = {
        # The module's ProtectHome=true hides all of /run/user, including the
        # Docker socket. tmpfs keeps other users' runtime dirs hidden and
        # exposes only the runner's.
        ProtectHome = "tmpfs";
        BindPaths = [ runtimeDir ];
        # ProtectSystem=strict makes everything else read-only. The runner
        # user's own home stays writable too: Java takes user.home from the
        # account, not from $HOME, so tools like sdkmanager write there
        # (~/.android). Like the caches, it persists between jobs and is
        # shared by all runners.
        ReadWritePaths = [
          cacheDir
          config.users.users.${user}.home
        ];
        # The module defaults to 0066, which checks files out as 0600. Docker
        # COPY keeps those modes, so images built here had files their
        # non-root users couldn't read (staging's schema migrator failed with
        # "Permission denied"). 0022 matches GitHub-hosted runners.
        UMask = "0022";
        # The runner reads /proc/1/cgroup before creating a job's container
        # network ("Could not find a part of the path '/proc/1/cgroup'").
        ProtectProc = "default";
        # Playwright's Chromium crashes ("Target crashed") inside the module's
        # syscall filter and namespace/user/device sandbox. The runner is
        # still an unprivileged user with rootless Docker; this only drops
        # systemd's extra layer around the runner process.
        SystemCallFilter = lib.mkForce [ ];
        RestrictNamespaces = false;
        PrivateUsers = false;
        PrivateDevices = false;
      };
    }
  );

  systemd.services =
    forEachRunner (
      id:
      lib.nameValuePair "github-runner-${runnerName id}" {
        # Don't fail-loop before the token has been installed.
        unitConfig.ConditionPathExists = tokenFile;
        # The Docker daemon runs in the runner user's systemd manager.
        # GitHub rejects a runner whose clock is off ("The runner
        # registration has been deleted"), so wait for NTP too.
        wants = [
          "user@${toString uid}.service"
          "time-sync.target"
        ];
        after = [
          "user@${toString uid}.service"
          "time-sync.target"
        ];
      }
    )
    // {
      # Without this unit, time-sync.target is reached before the clock is
      # actually synced.
      systemd-time-wait-sync.wantedBy = [ "sysinit.target" ];
    };
  systemd.additionalUpstreamSystemUnits = [ "systemd-time-wait-sync.service" ];

  systemd.tmpfiles.rules = [
    "d ${cacheDir} 0750 ${user} runners -"
    "d ${cacheDir}/gradle 0755 ${user} runners -"
    # With a shared GRADLE_USER_HOME, one job's build could attach to another
    # job's idle daemon, which the runner kills when that other job ends.
    # This file overrides the project's gradle.properties.
    "f+ ${cacheDir}/gradle/gradle.properties 0644 ${user} runners - org.gradle.daemon=false"
  ]
  ++ map (id: "d ${workDir id} 0700 ${user} runners -") ids;
}
