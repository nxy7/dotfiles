{
  pkgs,
  inputs,
  lib,
  config,
  ...
}:
let
  languages = {
    language = [
      {
        name = "tsx";
        auto-format = true;
      }
      {
        name = "lua";
        auto-format = true;
      }
      {
        name = "nix";
        auto-format = true;
        formatter = {
          command = "nixfmt";
        };
      }
      {
        name = "yaml";
        auto-format = true;
      }
      {
        name = "toml";
        auto-format = true;
      }
      {
        name = "vue";
        auto-format = true;
        language-servers = [
          {
            name = "volar";
            except-features = [ "inlay-hints" ];
          }
          "tailwind"
          # "eslint"
        ];
      }
      {
        name = "nu";
        auto-format = true;
        formatter = {
          command = "${pkgs.nufmt}/bin/nufmt";
        };
      }
      {
        name = "typescript";
        auto-format = true;
        language-servers = [
          "eslint"
          "typescript"
        ];
        formatter = {
          command = "${pkgs.prettier}/bin/prettier";
          args = [
            "--parser"
            "typescript"
          ];
        };
      }
      {
        name = "markdown";
        auto-format = true;
        language-servers = [
          "marksman"
          "ltex-ls"
        ];
      }
      {
        name = "svelte";
        # roots = [ "package.json" ];
        auto-format = true;
        language-servers = [
          "svelteserver"
          "tailwind"
          "eslint"
        ];
      }
    ];

    language-server.eslint = {
      command = "vscode-eslint-language-server";
      args = [ "--stdio" ];
      config = {
        validate = "on";
        format = true;
        quiet = false;
        onIgnoredFiles = "off";
        rulesCustomizations = [ ];
        run = "onType";
        # nodePath configures the directory in which the eslint server should start its node_modules resolution.
        # This path is relative to the workspace folder (root dir) of the server instance.
        nodePath = "";
        # use the workspace folder location or the file location (if no workspace folder is open) as the working directory

        workingDirectory.mode = "auto";
        experimental = { };
        problems.shortenToSingleLine = false;
        codeAction = {
          disableRuleComment = {
            enable = true;
            location = "separateLine";
          };
          showDocumentation.enable = true;
        };
      };
    };
  };
in
{
  programs.helix = {
    enable = true;
    defaultEditor = true;
    themes = {
      nxyt =
        let
          transparent = "none";
        in
        {
          inherits = "github_dark_dimmed";
          "ui.background" = {
            bg = transparent;
          };
        };
    };
    settings = {
      theme = lib.mkForce "nxyt";
      editor.line-number = "relative";
    };
    inherit languages;
  };

  home.file.".config/helix/ignore".text = ''
    !.env*
    !.dockerignore
    !.github/
    !.gitignore
    !.gitattributes
    !.eslintrc*
    !.prettierc*
    !.cargo/
  '';

  home.file.".local/state/nix/profile/bin/helix" = {
    source = "${config.programs.helix.package}/bin/hx";
  };
}
