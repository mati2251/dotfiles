return {
  'nvim-telescope/telescope.nvim',
  version = '*',
  dependencies = { 
      'nvim-lua/plenary.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  },

  config = function()
    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>sf', function()
        builtin.find_files({
          find_command = {
            'rg',
            '--files',
            '--hidden',
            '--no-ignore-vcs',
            '--no-ignore-global',
            '--no-ignore-exclude',
            '--glob', '!.git',
            '--color', 'never',
          },
        })
    end, {})
    vim.keymap.set('n', '<leader>sg', builtin.live_grep, {})
    vim.keymap.set('n', '<leader>sr', builtin.git_files, {})
    vim.keymap.set('n', '<leader>sb', builtin.buffers, {})
    vim.keymap.set('n', '<leader>sh', builtin.help_tags, {})
    local actions = require('telescope.actions')
  end
}
