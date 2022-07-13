M = {}

M.init = function()
	vim.opt.guifont = 'Hasklug NF:h10'
	vim.g.neovide_refresh_rate = 144
end

M.theme = function(use)
	use { 'sainnhe/gruvbox-material', after = 'lsp-colors.nvim', config = function()
		vim.opt.background = 'dark'

		vim.g.gruvbox_material_enable_italic = 1
		vim.g.gruvbox_material_enable_bold = 1

		vim.cmd [[colorscheme gruvbox-material]]
	end}
end

return M
