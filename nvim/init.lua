vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- disable netrw so nvmitree can be launched at startup
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("config.lazy")
require("config.options")

vim.api.nvim_create_autocmd("User", {
	pattern = "VeryLazy",
	callback = function()
		-- require("util").version()
		require("config.commands")
		require("config.keymappings")
	end,
})
