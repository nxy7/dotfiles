# GitHub Actions runners for WCEEN/cogni.
#
# Isolation model:
#   - Each runner is its own system user, not in `docker` or `wheel`.
#   - Each runner user has its own rootless Docker daemon (a systemd user
#     service). Containers run in that user's namespace, so a job can't
#     become root on the host through Docker, and can't touch other runners.
#   - Ephemeral: a runner takes one job, deregisters, and restarts with a
#     wiped state and work directory. The Nix store and each runner's Docker
#     images persist between jobs, so caching still works.
#   - The GitHub token is only read by root at startup and is hidden from
#     the runner process (the NixOS module does this).
{
  config,
  lib,
  pkgs,
  ...
}:
let
  # One runner: cogni's CI publishes its Postgres service container on the
  # fixed host port 5432 (`ports: - 5432:5432`), so two jobs on this machine
  # at once would collide. Raise this after the workflows switch to a random
  # host port (`ports: - 5432` plus `job.services.<name>.ports['5432']`).
  runnerCount = 1;

  ids = lib.genList (i: i + 1) runnerCount;
  forEachRunner = f: lib.listToAttrs (map f ids);

  tokenFile = "/var/lib/github-runner-token";
  dockerPackage = config.virtualisation.docker.rootless.package;

  runnerName = id: "cogni-${toString id}";
  userName = id: "runner-${toString id}";
  # Fixed UIDs so the Docker socket path (/run/user/<uid>) is known here.
  uid = id: 900 + id;
  runtimeDir = id: "/run/user/${toString (uid id)}";
  # On disk: the module's default work dir is under /run (RAM), which
  # node_modules and build outputs would fill.
  workDir = id: "/var/lib/github-runner-work/${runnerName id}";
in
{
  # ------------------------------------------------------------
  # Runner users, each with its own rootless Docker
  # ------------------------------------------------------------

  users.groups.runners = { };

  users.users = forEachRunner (
    id:
    lib.nameValuePair (userName id) {
      isSystemUser = true;
      uid = uid id;
      group = "runners";
      # Rootless Docker keeps images under ~/.local/share/docker.
      home = "/var/lib/${userName id}";
      createHome = true;
      # Start this user's systemd manager (and its Docker daemon) at boot,
      # without anyone logging in.
      linger = true;
      # Rootless Docker maps container UIDs into these ranges. NixOS only
      # allocates them automatically for normal users.
      subUidRanges = [
        {
          startUid = 1000000 + (id - 1) * 65536;
          count = 65536;
        }
      ];
      subGidRanges = [
        {
          startGid = 1000000 + (id - 1) * 65536;
          count = 65536;
        }
      ];
    }
  );

  virtualisation.docker.rootless.enable = true;
  # Only runner users get a daemon; admin logging in over SSH doesn't.
  systemd.user.services.docker.unitConfig.ConditionGroup = "runners";

  # Rootless Docker isn't covered by virtualisation.docker.autoPrune.
  # Anonymous volumes are pruned too: the Postgres service image declares
  # one, and the runner leaves it behind after each job.
  systemd.user.services.docker-prune = {
    description = "Prune this runner's rootless Docker";
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
  # Runners
  # ------------------------------------------------------------

  services.github-runners = forEachRunner (
    id:
    lib.nameValuePair (runnerName id) {
      enable = true;
      url = "https://github.com/WCEEN/cogni";
      inherit tokenFile;
      name = "g5-runner-${toString id}";
      replace = true;
      ephemeral = true;

      # Default labels (self-hosted, Linux, X64) plus these.
      extraLabels = [
        "nixos"
        "g5"
      ];

      user = userName id;
      group = "runners";
      workDir = workDir id;

      extraPackages = with pkgs; [
        dockerPackage
        curl
        jq
        xz
        zstd
      ];
      extraEnvironment.DOCKER_HOST = "unix://${runtimeDir id}/docker.sock";

      serviceOverrides = {
        # The module's ProtectHome=true hides all of /run/user, including
        # this runner's Docker socket. tmpfs keeps other users' runtime dirs
        # hidden and exposes only this one.
        ProtectHome = "tmpfs";
        BindPaths = [ (runtimeDir id) ];
      };
    }
  );

  systemd.services = forEachRunner (
    id:
    lib.nameValuePair "github-runner-${runnerName id}" {
      # Don't fail-loop before the token has been installed.
      unitConfig.ConditionPathExists = tokenFile;
      # The Docker daemon runs in this user's systemd manager.
      wants = [ "user@${toString (uid id)}.service" ];
      after = [ "user@${toString (uid id)}.service" ];
    }
  );

  systemd.tmpfiles.rules = map (id: "d ${workDir id} 0700 ${userName id} runners -") ids;
}
