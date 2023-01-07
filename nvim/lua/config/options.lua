vim.opt.autowrite = true
vim.opt.clipboard = "unnamedplus"
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.shiftround = true

vim.opt.shiftwidth = 2
vim.opt.tabstop = 2

vim.diagnostic.config({
	virtual_text = true,
})

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.api.nvim_create_autocmd({ "BufWrite" }, {
	pattern = { "*.gql", "*.graphql", "*.tsx", "*.ts", "*.css", "*.js", "*.jsx" },
	callback = function(ev)
		vim.cmd("PrettierAsync")
	end,
})

vim.api.nvim_create_autocmd({ "BufWrite" }, {
	pattern = "*",
	callback = function(ev)
		vim.cmd("lua vim.lsp.buf.format()")
	end,
})
