vim.lsp.enable({ "gopls", "clangd", "pyright", "ruff", "bashls", "nixd" })

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    local opts = { buffer = event.buf }

    if client and client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = true })
    end
    vim.keymap.set("n", "ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "gf", function() vim.lsp.buf.format({ async = true }) end, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "gR", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "gh", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "gs", vim.lsp.buf.document_symbol, opts)
    vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts)
  end,
})
