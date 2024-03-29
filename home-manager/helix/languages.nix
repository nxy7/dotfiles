{ pkgs, inputs, ... }: {
  language = [
    {
      name = "tsx";
      auto-format = true;
    }
    {
      name = "nix";
      auto-format = true;
      formatter = { command = "nixfmt"; };
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
      name = "typescript";
      auto-format = true;
      language-servers = [ "typescript" ];
      formatter = {
        command = "${pkgs.nodePackages_latest.prettier}/bin/prettier";
        args = [ "--parser" "typescript" ];
      };
    }
    {
      name = "javascript";
      auto-format = true;
    }
    {
      name = "markdown";
      auto-format = true;
      language-servers = [ "marksman" "ltex-ls" ];
    }
    {
      name = "svelte";
      # roots = [ "package.json" ];
      auto-format = true;
      language-servers = [ "svelteserver" "tailwind" "eslint" ];
    }
  ];

  language-server.typescript = {
    command =
      "${pkgs.nodePackages_latest.typescript-language-server}/bin/typescript-language-server";
    args = [ "--stdio" ];
  };
  language-server.svelteserver = {
    command =
      "${pkgs.nodePackages_latest.svelte-language-server}/bin/svelteserver";
    args = [ "--stdio" ];
  };
  language-server.volar = {
    args = [ "--stdio" ];
    command = "${
      # pkgs.nodePackages_latest."@vue/language-server"
      pkgs.nodePackages_latest.volar}/bin/vue-language-server";
    config.typescript = {
      tsdk = "${pkgs.nodePackages.typescript}/lib/node_modules/typescript/lib";
    };
  };
  language-server.eslint = {
    args = [ "--stdin" ];
    command = "${pkgs.nodePackages_latest.eslint}/bin/eslint";
    # command =
    #   "${pkgs.nodePackages_latest.vscode-langservers-extracted}/bin/vscode-eslint-language-server";
  };
  language-server.tailwind = {
    args = [ "--stdio" ];
    command = "${
        pkgs.nodePackages."@tailwindcss/language-server"
      }/bin/tailwindcss-language-server";
    config = { };
  };
}
