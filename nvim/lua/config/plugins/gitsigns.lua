return {
	"lewis6991/gitsigns.nvim",
	lazy = false,
	config = function()
		require('gitsigns').setup()
	end,
	keys = {
		{ "<leader>gb", "<cmd>Gitsigns blame_line<cr>", desc = "Blame Line" },
		-- {"<leader>gb", "<cmd>Gitsigns blameline<cr>", "Blame Line"},
		-- {"<leader>gb", "<cmd>Gitsigns blameline<cr>", "Blame Line"}
	},
}
