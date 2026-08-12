-- numbers of line 
vim.opt.nu = true
vim.opt.relativenumber = true

-- tab settings
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4

-- undo settings
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- search setting
vim.opt.incsearch = true

-- colors settings
vim.opt.termguicolors = true

-- scroll
vim.opt.scrolloff = 8

vim.opt.updatetime = 50

vim.o.clipboard = 'unnamedplus'

vim.opt.completeopt = { "menu", "menuone", "noselect", "popup" }

vim.o.winborder = "rounded"
vim.o.pumborder = "rounded"
