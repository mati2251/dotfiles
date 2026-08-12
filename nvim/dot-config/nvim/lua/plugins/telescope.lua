return {
  'nvim-telescope/telescope.nvim',
  version = '*',
  dependencies = { 
      'nvim-lua/plenary.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  },

  config = function()
    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>sf', builtin.find_files, {})
    vim.keymap.set('n', '<leader>sg', builtin.live_grep, {})
    vim.keymap.set('n', '<leader>sr', builtin.git_files, {})
    vim.keymap.set('n', '<leader>sb', builtin.buffers, {})
    vim.keymap.set('n', '<leader>sh', builtin.help_tags, {})
    local actions = require('telescope.actions')
  end
}
