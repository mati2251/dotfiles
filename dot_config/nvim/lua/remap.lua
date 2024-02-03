vim.g.mapleader = " "

-- open directory
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- autoindent all file 
vim.keymap.set("n", "=", "gg=G<C-o>")

-- visual all file
vim.keymap.set("n", "va", "ggVG")

-- move lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '>-2<CR>gv=gv")

-- move screen with center
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- next/prev search with center
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- duplicate line
vim.keymap.set("n", "yp", "yyp")

-- delete without yank
vim.keymap.set("n", "d", "\"_d")
vim.keymap.set("x", "d", "\"_d")
vim.keymap.set("x", "p", "\"_dP")
vim.keymap.set("n", "x", "\"_x")

-- hl search
vim.api.nvim_set_keymap('n', '<Leader>h', ':set hlsearch!<CR>', {noremap = true, silent = true})

-- buffer navigation
-- previous buffer
vim.keymap.set("n", "<Leader>h", ":bp<CR>")
vim.keymap.set("n", "<Leader>l", ":bn<CR>")
