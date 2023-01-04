local lsp_symbols = {
	Text = "   (Text) ",
	Method = "   (Method)",
	Function = "   (Function)",
	Constructor = "   (Constructor)",
	Field = " ﴲ  (Field)",
	Variable = "[] (Variable)",
	Class = "   (Class)",
	Interface = " ﰮ  (Interface)",
	Module = "   (Module)",
	Property = " 襁 (Property)",
	Unit = "   (Unit)",
	Value = "   (Value)",
	Enum = " 練 (Enum)",
	Keyword = "   (Keyword)",
	Snippet = "   (Snippet)",
	Color = "   (Color)",
	File = "   (File)",
	Reference = "   (Reference)",
	Folder = "   (Folder)",
	EnumMember = "   (EnumMember)",
	Constant = " ﲀ  (Constant)",
	Struct = " ﳤ  (Struct)",
	Event = "   (Event)",
	Operator = "   (Operator)",
	TypeParameter = "   (TypeParameter)",
}

return {
	-- Autocompletion
	{
		'hrsh7th/nvim-cmp',

		dependencies = {
			{ 'hrsh7th/cmp-path' },
			{ 'saadparwaiz1/cmp_luasnip' },
			{ 'hrsh7th/cmp-nvim-lsp' },
			{ 'hrsh7th/cmp-nvim-lua' },
		},

		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			cmp.setup(

				{
					experimental = {
						ghost_text = true
					},
					duplicates = {
						nvim_lsp = 1,
						luasnip = 1,
						-- cmp_tabnine = 1,
						-- buffer = 1,
						path = 1,
					},
					completion = {
						keyword_length = 1,
						autocomplete = { "TextChanged", "InsertEnter" },
					},
					sources = {
						{ name = "buffer", priority = 1 },
						{ name = "nvim_lsp", priority = 10 },
						{ name = "luasnip", priority = 9 },
						{ name = "cmp-path", priority = 8 },
					},
					mapping = {
						["<C-k>"] = cmp.mapping.select_prev_item(),
						["<C-j>"] = cmp.mapping.select_next_item(),
						["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
						["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
						["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
						["<C-y>"] = cmp.config.disable,
						["<C-e>"] = cmp.mapping {
							i = cmp.mapping.abort(),
							c = cmp.mapping.close(),
						},
						["<CR>"] = cmp.mapping.confirm { select = true },
						["<Tab>"] = cmp.mapping(function(fallback)
							if cmp.visible() then
								cmp.select_next_item()
							elseif luasnip.expandable() then
								luasnip.expand()
							elseif luasnip.expand_or_jumpable() then
								luasnip.expand_or_jump()
							else
								fallback()
							end
						end, {
							"i",
							"s",
						}),
						["<S-Tab>"] = cmp.mapping(function(fallback)
							if cmp.visible() then
								cmp.select_prev_item()
							elseif luasnip.jumpable(-1) then
								luasnip.jump(-1)
							else
								fallback()
							end
						end, {
							"i",
							"s",
						}),
					},
					formatting = {
						format = function(entry, item)
							item.kind = lsp_symbols[item.kind]
							item.menu = ({
								buffer = "[Buffer]",
								nvim_lsp = "[LSP]",
								luasnip = "[Snippet]",
								neorg = "[Neorg]",
							})[entry.source.name]

							return item
						end,
					},
					snippet = {
						expand = function(args)
							luasnip.lsp_expand(args.body)
						end,
					},
				}
			)
		end
	},
	-- { 'hrsh7th/cmp-buffer' },
}
