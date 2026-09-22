vim.lsp.enable({ "gopls", "clangd", "pyright", "ruff", "bashls" })

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    local opts = { buffer = event.buf }

    if client and client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = true })
    end
    vim.keymap.set("n", "<leader>c", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format({ async = true }) end, opts)
    vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<leader>d", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "<leader>D", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "<leader>i", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "<leader>t", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "<leader>h", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "<leader>s", vim.lsp.buf.document_symbol, opts)
    vim.keymap.set("n", "<leader>l", vim.diagnostic.open_float, opts)
  end,
})
