return {
	"JoosepAlviste/nvim-ts-context-commentstring",
	config = function()
		require 'nvim-treesitter.configs'.setup {
			context_commentstring = {
				enable = true
			}
		}
	end
}
