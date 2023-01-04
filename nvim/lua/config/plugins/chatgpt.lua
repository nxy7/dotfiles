return {
	"jackMort/ChatGPT.nvim",
	config = function()
		require("chatgpt").setup({
			-- optional configuration
		})
	end,
	keys = {
		{ "<leader>Gs", "<cmd>ChatGPT<cr>", desc = "Launch ChatGPT" },
		{ "<leader>Ga", "<cmd>ChatGPTActAs<cr>", desc = "Launch ChatGPT and Act As" },
		{ "<leader>Ge", "<cmd>ChatGPTEditWithInstructions<cr>", desc = "Chat GPT edit with instructions" },
		-- { "<leader>Ge", "<cmd>ChatGPTEditWithInstructions<cr>", desc = "Chat GPT edit with instructions" },
	},
	dependencies = {
		"MunifTanjim/nui.nvim",
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim"
	}
}
