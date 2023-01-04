return {
	-- Snippets
	{ 'rafamadriz/friendly-snippets' },
	{ 'L3MON4D3/LuaSnip',
		dependencies = { 'rafamadriz/friendly-snippets' },
		config = function()
			local ls = require("luasnip")
			ls.config.set_config({
				history = true,
				updateevents = "TextChanged,TextChangedI",
				enable_autosnippets = true,
			})
			-- ls.loaders.from_vscode.lazy_load()

			vim.o.runtimepath = vim.o.runtimepath .. '~/.config/nvim/lua/snippets'
			require("luasnip.loaders.from_vscode").lazy_load()
			require("luasnip.loaders.from_vscode").lazy_load({ paths = { "~/.config/nvim/lua/snippets" } })

			-- require("luasnip").filetype_extend("javascriptreact", { "html" })
			require("luasnip").filetype_extend("typescriptreact", { "qwik" })
		end
	},
}
