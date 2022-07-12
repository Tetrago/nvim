-- ________             ______
-- ___  __/___  ___________  /_______
-- __  /  _  / / /_  ___/_  __ \  __ \
-- _  /   / /_/ /_  /   _  /_/ / /_/ /
-- /_/    \__,_/ /_/    /_.___/\____/

local g = vim.g
local wo = vim.wo
local opt = vim.opt

require('plugins')

g.mapleader = ' '
wo.fillchars = 'eob: '

opt.number = true
opt.relativenumber = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = false
opt.mouse = 'a'
opt.autoread = true
opt.encoding = 'utf8'
opt.wrap = false
opt.autoindent = true
opt.timeoutlen = 0
opt.list = true
opt.showmode = false
opt.foldlevel = 99
opt.foldmethod = 'expr'
opt.foldexpr = 'nvim_treesitter#foldexpr()'
opt.signcolumn = 'yes:1'

if vim.fn.has('termguicolors') then
	opt.termguicolors = true
end

vim.fn.sign_define('DiagnosticSignError', { text = ' ', texthl = 'DiagnosticSignError', numhl = 'DiagnosticSignError' })
vim.fn.sign_define('DiagnosticSignWarn', { text = ' ', texthl = 'DiagnosticSignWarn', numhl = 'DiagnosticSignWarn' })
vim.fn.sign_define('DiagnosticSignHint', { text = ' ', texthl = 'DiagnosticSignHint', numhl = 'DiagnosticSignHint' })
vim.fn.sign_define('DiagnosticSignInfo', { text = ' ', texthl = 'DiagnosticSignInfo', numhl = 'DiagnosticSignInfo' })

vim.cmd [[set guifont=JetBrainsMono\ NF:h10]]
