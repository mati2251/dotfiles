return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup({
        options = {
          theme = 'dracula'
        }
      })
    end
  },
  {
    "dracula/vim",
    name = "dracula",
    priority = 1000,
    config = function()
      vim.g.dracula_colorterm = 0
      vim.cmd.colorscheme "dracula"
    end
  }
}

