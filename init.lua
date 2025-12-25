-- The variable names are self-explanatory here
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.linebreak = true

vim.opt.cursorline = true

vim.opt.backup = true

vim.opt.scrolloff = 10

vim.keymap.set('i', 'jj', '<Esc>')

vim.opt.mouse = 'a'

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.inccommand = 'split'

-- Undo even after :wq
vim.opt.undofile = true

vim.cmd [[
	iabbrev @@ hasnatsafdar.work@gmail.com
]]

-- Fancy stuff to know diff btw tab and space
vim.opt.list = true
vim.opt.listchars = {tab = '» ', trail = '·', nbsp= '␣' }

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Nvim clipboard registers
vim.keymap.set('n', '<leader>d', '"_d')
vim.keymap.set('v', '<leader>d', '"_d')

-- Sync with system clipboard
vim.opt.clipboard = 'unnamedplus'

-- Open terminal inside nvim
vim.keymap.set('n', '<leader>a', ':split | terminal<CR>')

-- Drag line of code up or down
vim.keymap.set('n', '<C-j>', ':m .+1<CR>>==')
vim.keymap.set('n', '<C-k>', ':m .-2<CR>>==')

-- Execute python code inside nvim
vim.keymap.set('n', '<leader>ep', ':w<CR>:!python3 %<CR>')

-- Pressing Esc hides the annoying highlight
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Just read the code
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- quote text in v mode
vim.keymap.set('v', "<leader>'", "c''<Esc>P")
vim.keymap.set('v', '<leader>"', 'c""<Esc>P')

-- For linking in .md
vim.keymap.set('n', '<leader>li', 'i[]()<Left><Left><Left><Esc>a')
vim.keymap.set('v', '<leader>li', '"ac[<C-r>"]()<Esc><Left>a')

-- Please don't sue me
vim.keymap.set('n', '<leader>w', ':w<CR>')
vim.keymap.set('n', '<leader>q', ':q<CR>')
vim.keymap.set('n', '<leader>Q', ':q!<CR>')
