return {
	"folke/which-key.nvim",
	config = function()
		require("which-key").setup()

		local wk = require("which-key")
		wk.register({
			s = "Search",
			g = "Git",
			G = "ChatGPT",
			l = "LSP",
			b = "Buffer",
			c = "Neogen"
		}, { prefix = "<leader>" })
	end
}
