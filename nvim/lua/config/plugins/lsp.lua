-- necesarry as neodev needs to be configured before LSP

return {
	-- LSP Support
	{
		'williamboman/mason.nvim',
		lazy = false,
		config = function()
			require("mason").setup()
		end,
	},
	{
		'williamboman/mason-lspconfig.nvim',
		lazy = false,
		dependencies = { 'folke/neodev.nvim', 'L3MON4D3/LuaSnip' },
		config = function()
			require("mason-lspconfig").setup(
				{
					automatic_installation = true,
				}

			)
			require("mason-lspconfig").setup_handlers {
				function(server_name)
					require("lspconfig")[server_name].setup {}
				end,
				require("lspconfig").sumneko_lua.setup {},
				require("lspconfig").rust_analyzer.setup {},

			}
		end,
		keys = {
			{ "gl", "<cmd>lua vim.diagnostic.open_float()<cr>", desc = "Open line diagnostics" },
			{ "<Ctrl-k>", "<cmd>lua vim.lsp.buf.signature_help()<cr>", desc = "Signature informations" },
			{ "K", "<cmd>lua vim.lsp.buf.hover()<cr>", desc = "Open line diagnostics" },
			{ "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>", desc = "Go to previous diagnostic" },
			{ "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>", desc = "Go to next diagnostic" },
			{ "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", desc = "Rename symbol" }
		}
	},
	{ 'neovim/nvim-lspconfig', lazy = false },

}
