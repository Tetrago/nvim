local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	packer_bootstrap = vim.fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
	vim.cmd [[packadd packer.nvim]]
end

return require('packer').startup({function(use)
	use 'wbthomason/packer.nvim'
	use { 'lewis6991/impatient.nvim', config = function() require('impatient') end }

	-- Interface
	use { 'sainnhe/gruvbox-material', config = function()
		vim.g.gruvbox_material_enable_italic = 1
		vim.cmd [[colorscheme gruvbox-material]]
	end}
	use { 'windwp/windline.nvim', config = function()
		require('wlsample.airline')
	end}
	use 'mhinz/vim-signify'
	use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' }, config = function()
		require('telescope').setup{ defaults = { file_ignore_patterns = { ".cache", "build", ".git", ".vs", "external" } } }
	end}
	use { 'nvim-telescope/telescope-file-browser.nvim', after = 'telescope.nvim', config = function() require('telescope').load_extension('file_browser') end }
	use { 'goolord/alpha-nvim', requires = { 'kyazdani42/nvim-web-devicons' }, config = function() require('alpha').setup(require('dashboard').config) end }
	use { 'folke/which-key.nvim', config = function()
		require('which-key').setup{
			triggers = { '<Leader>', 'g', '<C-w>' }
		}
		require('keys')
	end}
	use { 'folke/trouble.nvim', config = function() require('trouble').setup{} end }
	use { 'declancm/cinnamon.nvim', config = function() require('cinnamon').setup() end }

	-- Quality of life
	use 'ggandor/lightspeed.nvim'
	use { 'windwp/nvim-autopairs', config = function() require('nvim-autopairs').setup{} end }
	use { 'stevearc/dressing.nvim', after = 'telescope.nvim' }
	use { 'godlygeek/tabular', opt = true, cmd = { 'Tabularize', 'Tab' } }
	use { 'lewis6991/spellsitter.nvim', config = function() require('spellsitter').setup() end }
	use { 'ntpeters/vim-better-whitespace', config = function()
		vim.g.better_whitespace_filetypes_blacklist = { 'alpha' }
	end}
	use 'tpope/vim-surround'
	use { 'lukas-reineke/indent-blankline.nvim', after = 'nvim-treesitter', config = function()
		require('indent_blankline').setup{
			show_current_context = true,
			show_current_context_start = true
		}
	end}
	use { 'norcalli/nvim-colorizer.lua', config = function() require('colorizer').setup() end }

	-- Workflow
	use { 'ahmedkhalf/project.nvim', after = 'telescope.nvim', config = function()
		require('project_nvim').setup{}
		require('telescope').load_extension('projects')
	end}
	use 'tpope/vim-projectionist'
	use 'tpope/vim-dispatch'
	use 'igemnace/vim-makery'
	use 'tpope/vim-commentary'

	-- LSP
	use {'williamboman/nvim-lsp-installer', requires = 'neovim/nvim-lspconfig', after = 'coq_nvim', config = function()
		require('nvim-lsp-installer').setup{
			ensure_installed = { 'clangd', 'cmake' },
			ui = { border = 'rounded' }
		}

		local lsp = require('lspconfig')
		local coq = require('coq')

		for _, server in ipairs(require('nvim-lsp-installer').get_installed_servers()) do
			lsp[server.name].setup(coq.lsp_ensure_capabilities())
		end
	end}
	use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', config = function()
		require('nvim-treesitter.configs').setup{
			ensure_installed = { 'c', 'cpp', 'cmake', 'lua', 'toml', 'yaml', 'json', 'jsdoc' },
			highlight = { enable = true },
			incremental_selection = { enable = true },
			indent = { enable = false }
		}
	end}
	use { 'm-demare/hlargs.nvim', after = 'nvim-treesitter', config = function() require('hlargs').setup() end }

	-- Completion
	use { 'ms-jpq/coq_nvim', branch = 'coq', requires = { 'kyazdani42/nvim-web-devicons' }, config = function()
		vim.g.coq_settings = { auto_start = 'shut-up', ['keymap.jump_to_mark'] = '\\' }

		require('coq')
	end}
	use { 'ms-jpq/coq.artifacts', branch = 'artifacts', after = 'coq_nvim' }

	-- Debug
	use 'puremourning/vimspector'

	if packer_bootstrap then
		require('packer').sync()
	end
end,
config = {
	display = {
		open_fn = function()
			return require('packer.util').float({ border = 'rounded' })
		end
	}
}})
