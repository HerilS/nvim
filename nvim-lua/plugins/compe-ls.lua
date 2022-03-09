local null_ls = require("null-ls")

require("lspconfig").pyright.setup({})
require("lspconfig").tsserver.setup({
	on_attach = function(client, bufnr)
		client.resolved_capabilities.document_formatting = false
		vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>fm", "<cmd>lua vim.lsp.buf.formatting()<CR>", {})
	end,
})
require("lspconfig").jsonls.setup({})
require("lspconfig").cssls.setup({})
require("lspconfig").html.setup({})
