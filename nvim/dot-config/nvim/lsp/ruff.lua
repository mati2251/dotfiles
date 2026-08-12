return {
  cmd = { "ruff", "server" },
  filetypes = { "python" },
  root_markers = { "ruff.toml", ".ruff.toml", "pyproject.toml", ".git" },
  on_attach = function(client)
    client.server_capabilities.hoverProvider = false
  end,
}
