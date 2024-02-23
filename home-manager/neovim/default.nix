{ inputs, pkgs, lib, ... }: {

  # imports = [ inputs.nixvim.homeManagerModules.nixvim ];
  programs.nixvim = {
    enable = true;
    clipboard.providers.wl-copy.enable = true;
    colorschemes.vscode.enable = true;
    globals.mapleader = " ";
    globals.maplocalleader = " ";

    options = {
      number = true;
      clipboard = "unnamedplus";
      relativenumber = true;
      ignorecase = true;
      smartcase = true;
    };

    extraConfigLua = ''
      -- Print a little welcome message when nvim is opened!
      print("Hello world!")
      -- auto format

    '';
    autoCmd = [{
      event = "BufWritePre";
      command = "lua vim.lsp.buf.format()";
    }];

    keymaps = [
      {
        action = "+yg_";
        key = "<leader>Y";
      }
      {
        action = "<cmd>BufferLineCycleNext<CR>";
        key = "<C-Right>";
      }
      {
        action = "<cmd>BufferLineCyclePrev<CR>";
        key = "<C-Left>";
      }
      {
        action = "<cmd>Neotree toggle<CR>";
        key = "<leader>e";
      }
      {
        action = "<cmd>lua vim.lsp.buf.code_action()<CR>";
        key = "<leader>a";
      }
      {
        action = "<cmd>lua vim.diagnostic.goto_prev()<CR>";
        key = "[d";
      }
      {
        action = "<cmd>lua vim.diagnostic.goto_next()<CR>";
        key = "]d";
      }
      {
        action = "<cmd>FzfLua diagnostics_document<CR>";
        key = "<leader>d";
      }
      {
        action = "<cmd>FzfLua live_grep<CR>";
        key = "<leader>/";
      }
      {
        action = "<cmd>FzfLua diagnostics_workspace<CR>";
        key = "<leader>D";
      }
    ];
    plugins = {

      lsp = {
        enable = true;
        servers = {
          csharp-ls.enable = true;
          tsserver.enable = true;
          nil_ls.enable = true;
          lua-ls.enable = true;
          nushell.enable = true;
          svelte.enable = true;
          gopls.enable = true;
          tailwindcss.enable = true;
          taplo.enable = true;
          typos-lsp.enable = true;
          rust-analyzer.enable = true;
          rust-analyzer.installCargo = true;
          rust-analyzer.installRustc = true;
        };
        keymaps.lspBuf = {
          "<leader>k" = "hover";
          gr = "references";
          gd = "definition";
          gi = "implementation";
          gt = "type_definition";
          # gy = "type_definition";
        };
      };
      lspkind.enable = true;

      comment-nvim = { enable = true; };
      neotest = {
        enable = true;
        adapters = {
          go.enable = true;
          rust.enable = true;
          jest.enable = true;
        };
      };
      dap = { enable = true; };
      neo-tree.enable = true;
      neo-tree.filesystem.followCurrentFile.enabled = true;
      # neorg.enable = true;
      bufferline.enable = true;
      lsp-format = { enable = true; };
      none-ls = {
        enable = true;
        enableLspFormat = true;
        # debug = true;
        sources = {
          formatting = {
            prettier.enable = true;
            prettier.disableTsServerFormatter = true;
            nixfmt.enable = true;
          };
          diagnostics = {
            statix.enable = true;
            deadnix.enable = true;
          };
        };
      };
      fzf-lua = {
        enable = true;
        keymaps = {
          "<leader>s" = {
            action = "lsp_document_symbols";
            options = { silent = true; };
            settings = {
              previewers = {
                cat = {
                  cmd =
                    "/nix/store/mb488rr560vq1xnl10hinnyfflcrd51n-coreutils-9.4/bin/cat";
                };
              };
              winopts = { height = 0.5; };
            };
          };
          "<leader>S" = {
            action = "lsp_workspace_symbols";
            options = { silent = true; };
            settings = {
              previewers = {
                cat = {
                  cmd =
                    "/nix/store/mb488rr560vq1xnl10hinnyfflcrd51n-coreutils-9.4/bin/cat";
                };
              };
              winopts = { height = 0.5; };
            };
          };
          "<leader>f" = {
            action = "git_files";
            options = {
              desc = "Fzf-Lua Git Files";
              silent = true;
            };
            settings = {
              previewers = {
                cat = {
                  cmd =
                    "/nix/store/mb488rr560vq1xnl10hinnyfflcrd51n-coreutils-9.4/bin/cat";
                };
              };
              winopts = { height = 0.5; };
            };
          };
        };
      };
      cursorline.enable = true;
      gitblame = {
        enable = true;
        delay = 3500;
      };
      gitgutter.enable = true;
      gitlinker.enable = true;

      luasnip.enable = true;
      # lint.enable = true;
      # airline.enable = true;
      lualine.enable = true;
      cmp = {
        enable = true;
        cmdline = {
          "/" = {
            mapping = { __raw = "cmp.mapping.preset.cmdline()"; };
            sources = [{ name = "buffer"; }];
          };
          ":" = {
            mapping = { __raw = "cmp.mapping.preset.cmdline()"; };
            sources = [
              { name = "path"; }
              {
                name = "cmdline";
                option = { ignore_cmds = [ "Man" "!" ]; };
              }
            ];
          };
        };
        filetype = {
          python = { sources = [{ name = "nvim_lsp"; }]; };
          ts = { sources = [{ name = "nvim_lsp"; }]; };
        };
      };
      cmp-nvim-lsp.enable = true;
      cmp-nvim-lsp-document-symbol.enable = true;
      cmp-tabnine.enable = true;

      surround.enable = true;
      treesitter.enable = true;
      which-key = { enable = true; };

      nvim-autopairs.enable = true;
      auto-session = {
        enable = true;
        autoSession.enabled = true;
        autoSave.enabled = true;
        autoRestore.enabled = true;
      };
      # auto-save.enable = true;
      # auto-save.triggerEvents = [ "BufWritePre" ];

    };

  };
}
