-- ________             ______
-- ___  __/___  ___________  /_______
-- __  /  _  / / /_  ___/_  __ \  __ \
-- _  /   / /_/ /_  /   _  /_/ / /_/ /
-- /_/    \__,_/ /_/    /_.___/\____/

if vim.fn.has('termguicolors') then
	vim.opt.termguicolors = true
end

vim.g.coq_settings = { auto_start = 'shut-up' }

require('plugins')

vim.g.mapleader = ' '
vim.opt.background = 'dark'
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.mouse = 'a'
vim.opt.autoread = true
vim.opt.encoding = 'utf8'
vim.opt.wrap = false
vim.opt.spell = true
vim.opt.autoindent = true
vim.opt.timeoutlen = 0
vim.opt.sessionoptions = { 'blank', 'curdir', 'winsize' }
vim.opt.list = true
