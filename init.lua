-- ________             ______
-- ___  __/___  ___________  /_______
-- __  /  _  / / /_  ___/_  __ \  __ \
-- _  /   / /_/ /_  /   _  /_/ / /_/ /
-- /_/    \__,_/ /_/    /_.___/\____/

require('plugins')

vim.g.mapleader = ' '
vim.wo.fillchars = 'eob: '

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = false
vim.opt.mouse = 'a'
vim.opt.autoread = true
vim.opt.encoding = 'utf8'
vim.opt.wrap = false
vim.opt.autoindent = true
vim.opt.timeoutlen = 0
vim.opt.list = true
vim.opt.showmode = false
vim.opt.foldlevel = 99
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
vim.opt.signcolumn = 'yes:1'

if vim.fn.has('termguicolors') then
	vim.opt.termguicolors = true
end

vim.fn.sign_define('DiagnosticSignError', { text = ' ', texthl = 'DiagnosticSignError', numhl = 'DiagnosticSignError' })
vim.fn.sign_define('DiagnosticSignWarn', { text = ' ', texthl = 'DiagnosticSignWarn', numhl = 'DiagnosticSignWarn' })
vim.fn.sign_define('DiagnosticSignHint', { text = ' ', texthl = 'DiagnosticSignHint', numhl = 'DiagnosticSignHint' })
vim.fn.sign_define('DiagnosticSignInfo', { text = ' ', texthl = 'DiagnosticSignInfo', numhl = 'DiagnosticSignInfo' })

require('user')
