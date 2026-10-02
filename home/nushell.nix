{ pkgs, ... }:
let
  extraConfig = # nu
    ''
      alias z = zoxide

      alias j = just
      alias l = ls
      alias la = ls -a
      alias kctl = sudo k3s kubectl
      alias just = just --unstable
      alias pnpm = corepack pnpm

      $env.config.abbreviations = {
          d: "dotnet"
          j: "just"
          ll: "ls -l"
          lg: "lazygit"
          gs: "git status"
          ds: "npx @deepseek-ai/dsh web"
          dsp: "pnpm --prefix ~/deepseek-harness exec node --expose-internals --import tsx/esm apps/cli/src/bin.ts web --no-open"
          nsp: "node --expose-internals /Users/dawiddanieluk/.bun/install/global/node_modules/@deepseek-ai/dsh/lib/bin.js web --no-open"
          nspu: "bun add -g @deepseek-ai/dsh@next"
          nfu: "nix flake update"
          ccd: "claude --dangerously-skip-permissions"
          nhs: "home-manager switch --flake .#dawiddanieluk"
          nfix: "sudo nix-store --repair --verify --check-contents"
      }

      def flake-update [] {
        gotoDotfiles
        nix flake update
      }

      def testSuccess [command: closure, --count (-n): int = 30] {
        let final = 1..$count | reduce --fold { successes: 0, failures: 0 } { |i, acc|
          # Clear screen and move cursor to top
          print -n $"(ansi cls)(ansi home)"

          # Header with success rate on right
          let prev_total = $acc.successes + $acc.failures
          let prev_pct = if $prev_total > 0 { (($acc.successes / $prev_total) * 100 | math round) } else { 0 }
          print $"(ansi cyan)━━━ Test Run ($i)/($count) ━━━(ansi reset)    (ansi green)✓ ($acc.successes)(ansi reset) | (ansi red)✗ ($acc.failures)(ansi reset) | ($prev_pct)%\n"

          let outcome = try {
            do $command
            "success"
          } catch { |e|
            print $"(ansi red)Error: ($e.msg)(ansi reset)"
            "failure"
          }

          let new_acc = if $outcome == "success" {
            { successes: ($acc.successes + 1), failures: $acc.failures }
          } else {
            { successes: $acc.successes, failures: ($acc.failures + 1) }
          }

          let total = $new_acc.successes + $new_acc.failures
          let percentage = (($new_acc.successes / $total) * 100 | math round)

          # Status bar at bottom
          print $"\n(ansi attr_reverse)━━━ Success: ($new_acc.successes)/($total) \(($percentage)%\) | Failures: ($new_acc.failures) ━━━(ansi reset)"

          if $i < $count { sleep 100ms }

          $new_acc
        }

        # Final summary
        let total = $final.successes + $final.failures
        let percentage = (($final.successes / $total) * 100 | math round)
        print $"\n(ansi green_bold)✓ Completed: ($percentage)% success \(($final.successes)/($total)\)(ansi reset)"
      }

      # home manager update
      def nix-home-manager-update [
        ...rest
      ] {
        gotoDotfiles
        home-manager switch --flake . --impure ...$rest;
        spd-say 'Home configuration updated';
      }

      # system update
      def nix-system-update [
        ...rest: string
      ] {
        gotoDotfiles
        sudo nixos-rebuild switch --flake . --impure;
        spd-say 'System updated';
      }

      def "from env" []: string -> record {
        lines
          | split column '#'
          | get column1
          | where {($in | str length) > 0}
          | parse "{key}={value}"
          | update value {str trim -c '"'}
          | transpose -r -d
      }


      # darwin system update. nss/nixos-rebuild is Linux-only, so on the Mac
      # the system generation (launchd daemons, system.defaults, ...) is
      # switched by darwin-rebuild instead. home-manager alone does not apply
      # anything under darwinConfigurations.
      def darwin-system-update [
        ...rest: string
      ] {
        gotoDotfiles
        # `#dawiddanieluk` is required: darwin-rebuild otherwise looks up
        # darwinConfigurations.<hostname>, and the host is MacBook-Pro-Dawid.
        sudo darwin-rebuild switch --flake .#dawiddanieluk --impure ...$rest
      }
      alias dss = darwin-system-update


      # full system update (system + home manager)
      def nfs [
        --update (-u)
      ] {
        gotoDotfiles;
        sudo echo "Starting system update";
        if $update {
          nix flake update
        }
        nss;
        nhs;
      }
      alias flake-rebuild = nix-full-system-update

      $env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense'
      $env.EDITOR = 'hx'

      mkdir $nu.cache-dir
      carapace _carapace nushell | save --force $"($nu.cache-dir)/carapace.nu"

      source $"($nu.cache-dir)/carapace.nu"

      # Reclaim disk space from the caches that grow without bound.
      #
      #   cleanup                 only removes what re-downloads or rebuilds on
      #                           demand: unreferenced store paths, dangling
      #                           Docker images/build cache, package manager
      #                           download caches.
      #   cleanup --deep          also drops every old nix generation (not just
      #                           >14d) and the big Library caches: Playwright
      #                           browsers, Bumblebee models, Yarn, Zed's node.
      #                           All re-fetch, but the next run of whatever
      #                           needed them is slow.
      #   cleanup --docker-volumes  additionally removes Docker volumes. This
      #                           DESTROYS local dev databases (cogni_db and
      #                           friends). Off by default, even under --deep.
      def cleanup [--deep, --docker-volumes] {
        let before = (sys disks | where mount == "/" | get free | first)
        print $"(ansi cyan)free before: ($before)(ansi reset)\n"

        print $"(ansi yellow)── nix ──(ansi reset)"
        if $deep {
          try { ^sudo nix-collect-garbage -d }
          try { ^nix-collect-garbage -d }
        } else {
          try { ^sudo nix-collect-garbage --delete-older-than 14d }
          try { ^nix-collect-garbage --delete-older-than 14d }
        }
        try { ^nix store optimise }

        print $"\n(ansi yellow)── docker ──(ansi reset)"
        if ((^docker info | complete).exit_code == 0) {
          if $docker_volumes {
            print $"(ansi red)  removing volumes — dev databases will be lost(ansi reset)"
            try { ^docker system prune -af --volumes }
          } else {
            try { ^docker system prune -af }
          }
          # Pruning frees space inside the VM; it does not shrink Docker.raw on
          # the host until Docker Desktop trims. Nudge it, and say so if absent.
          print $"(ansi grey)  note: run Docker Desktop → Settings → Resources → Disk image → Clean up if the host file has not shrunk(ansi reset)"
        } else {
          print "  daemon not running — skipped"
        }

        print $"\n(ansi yellow)── package manager caches ──(ansi reset)"
        if (which bun | is-not-empty) { try { ^bun pm cache rm } }
        if (which npm | is-not-empty) { try { ^npm cache clean --force } }
        if (which pnpm | is-not-empty) { try { ^pnpm store prune } }
        if (which yarn | is-not-empty) { try { ^yarn cache clean } }

        if $deep {
          print $"\n(ansi yellow)── library caches (deep) ──(ansi reset)"
          let targets = ([
            "Library/Caches/ms-playwright"
            "Library/Caches/bumblebee"
            "Library/Caches/Yarn"
            "Library/Caches/mix"
            "Library/Application Support/Zed/node"
          ] | each { |p| $nu.home-path | path join $p })

          for t in $targets {
            if ($t | path exists) {
              ^rm -rf $t
              print $"  removed ($t)"
            }
          }
          print $"(ansi grey)  re-install Playwright browsers with: bunx playwright install chromium(ansi reset)"
        }

        let after = (sys disks | where mount == "/" | get free | first)
        print $"\n(ansi green_bold)reclaimed ($after - $before) — free now: ($after)(ansi reset)"
      }

      def kill-wlcopy-wrappers [] {
        ps | where name =~ wl-copy-wrap | each {kill $in.pid}
      }


      def argo-get-pw [] {
         kubectl get secret -n argocd argocd-initial-admin-secret -o yaml | from yaml | get data.password | base64 -d | wl-copy
        print "fsh password copied to clipboard"
      }
    '';

  extraEnv = # nu
    ''
      $env.config.show_banner = false;

      $env.PATH = ($env.PATH |
       split row ":" |
       prepend $"($env.HOME)/.nix-profile/bin" |
       prepend "/nix/var/nix/profiles/default/bin" |
       prepend $"($env.HOME)/.local/bin" |
       prepend $"($env.HOME)/.cargo/bin" |
       prepend $"($env.HOME)/.mix/escripts" |
       prepend $"($env.HOME)/.npm-global/bin" |
       prepend $"($env.HOME)/.bun/bin" |
       prepend $"($env.HOME)/.dotnet/tools");

      ${pkgs.zoxide}/bin/zoxide init nushell | save -f ~/.zoxide.nu;

      # Trigger direnv on shell startup (fixes VSCode terminal not loading env)
      ${pkgs.direnv}/bin/direnv export json | from json | default {} | load-env
    '';
in
{
  home.packages = with pkgs; [
    carapace
  ];
  programs.nushell = {
    enable = true;
    inherit extraConfig extraEnv;
  };
}
