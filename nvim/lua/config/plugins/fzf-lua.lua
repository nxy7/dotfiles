return {
	"ibhagwan/fzf-lua",
	dependencies = { "junegunn/fzf", },
	lazy = false,
	keys = {
		{ "<leader>sf", "<cmd>:FzfLua files<cr>", desc = "Search Files" },
		{ "<leader>sg", "<cmd>:FzfLua git_files<cr>", desc = "Search Git Files" },
		{ "<leader>st", "<cmd>:FzfLua grep<cr><Enter>", desc = "Grep" },
		{ "gd", "<cmd>:FzfLua lsp_definitions<cr>", desc = "Go to definition" },
		{ "gr", "<cmd>:FzfLua lsp_references<cr>", desc = "Go to reference" },
		{ "gt", "<cmd>:FzfLua lsp_typedefs<cr>", desc = "Go to reference" },
		{ "gi", "<cmd>:FzfLua lsp_implementations<cr>", desc = "Go to implementations" },
		{ "<c-p>", "<cmd>:FzfLua files<cr>", desc = "Search Files" },
		{ "<leader>lw", "<cmd>:FzfLua lsp_workspace_diagnostics<cr>", desc = "Workspace Diagnostics" },
		{ "<leader>ld", "<cmd>:FzfLua lsp_document_diagnostics<cr>", desc = "Document Diagnostics" },
		{ "<leader>la", "<cmd>:FzfLua lsp_code_actions<cr>", desc = "Code Actions" },
	}
}
