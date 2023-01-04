return {
	"danymat/neogen",
	keys = {
		{
			"<leader>cc",
			function()
				require("neogen").generate({})
			end,
			desc = "Neogen Comment",
		},
	},
	config = { snippet_engine = "luasnip" },
}
