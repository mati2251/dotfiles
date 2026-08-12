return {
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require('lualine').setup({
                options = {
                    theme = 'dracula-nvim'
                }
            })
        end
    },
    {
        "Mofiqul/dracula.nvim",
        name = "dracula",
        priority = 1000,
        config = function()
            require('dracula').setup({
                italic_comment = true,
            })
            vim.cmd.colorscheme "dracula"
        end
    }
}
