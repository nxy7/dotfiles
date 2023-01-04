return {
	"folke/tokyonight.nvim",
	lazy = false,
	config = function()
		require("tokyonight").setup({
			style = "night",
			dark_float = true,
		})
		vim.cmd("colorscheme tokyonight")
	end
}
