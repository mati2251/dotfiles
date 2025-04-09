
-- numbers of line 
vim.opt.nu = true
vim.opt.relativenumber = true

-- tab settings
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")

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
