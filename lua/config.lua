M = {}

M.init = function()
	vim.opt.guifont = 'FiraCode NF:h10'
end

M.plugins = function(use)
	use { 'sainnhe/gruvbox-material', after = { 'lsp-colors.nvim', 'lualine.nvim' }, config = function()
		vim.opt.background = 'dark'

		vim.g.gruvbox_material_enable_bold = 1

		vim.cmd [[colorscheme gruvbox-material]]
	end}
end

M.keys = function(register)
end

M.statusline = function()
	return {
		theme = 'auto',
	}
end

return M
