return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.5',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>sf', builtin.find_files, {})
    vim.keymap.set('n', '<leader>sg', builtin.live_grep, {})
    vim.keymap.set('n', '<leader>sb', builtin.buffers, {})
    vim.keymap.set('n', '<leader>sh', builtin.help_tags, {})
    local actions = require('telescope.actions')
    require('telescope').setup {
      defaults = {
        mappings = {
          n = {
            ['<C-d>'] = actions.delete_buffer
          },
          i = {
            ['<C-d>'] = actions.delete_buffer
          },
        },
      },
    }
  end
}
