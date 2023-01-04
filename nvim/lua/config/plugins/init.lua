return {
	{
		"ahmedkhalf/project.nvim",
		config = function()
			require("project_nvim").setup {}
		end,
	},
	{
		"prettier/vim-prettier",
	},
	-- "tpope/vim-fugitive",
	-- "jesseduffield/lazygit",
	-- "b0o/SchemaStore.nvim",
	"nvim-lua/plenary.nvim",
	{
		"ThePrimeagen/refactoring.nvim",
		keys = {
			{
				"<leader>r",
				function()
					require("refactoring").select_refactor()
				end,
				mode = "v",
				noremap = true,
				silent = true,
				expr = false,
			},
		},
		config = {},
	},

	{
		"m-demare/hlargs.nvim",
		event = "VeryLazy",
		enabled = false,
		config = {
			excluded_argnames = {
				usages = {
					lua = { "self", "use" },
				},
			},
		},
	},


	{
		"dstein64/vim-startuptime",
		cmd = "StartupTime",
		config = function()
			vim.g.startuptime_tries = 10
		end,
	},
}
