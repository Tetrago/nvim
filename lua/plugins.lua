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
	use { 'nvim-telescope/telescope.nvim', requires = 'nvim-lua/plenary.nvim', config = function()
		require('telescope').setup{ defaults = { file_ignore_patterns = { ".cache", "build", ".git", ".vs", "external" } } }
	end}
	use { 'nvim-telescope/telescope-fzf-native.nvim', after = 'telescope.nvim', run = 'cmake -S . -B build -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build', config = function() require('telescope').load_extension('fzf') end }
	use { 'nvim-telescope/telescope-file-browser.nvim', after = 'telescope.nvim', config = function() require('telescope').load_extension('file_browser') end }
	use { 'nvim-telescope/telescope-vimspector.nvim', after = { 'telescope.nvim', 'vimspector' }, config = function() require('telescope').load_extension('vimspector') end }
	use { 'nvim-telescope/telescope-packer.nvim', after = 'telescope.nvim', config = function() require('telescope').load_extension('packer') end }
	use { 'sudormrfbin/cheatsheet.nvim', after = 'telescope.nvim', requires = { 'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim' } }
	use { 'goolord/alpha-nvim', requires = 'kyazdani42/nvim-web-devicons', config = function() require('alpha').setup(require('dashboard').config) end }
	use { 'folke/which-key.nvim', config = function()
		require('which-key').setup{
			triggers = { '<Leader>', 'g', '<C-w>' }
		}
		require('keys')
	end}
	use { 'folke/trouble.nvim', config = function() require('trouble').setup{} end }
	use { 'declancm/cinnamon.nvim', config = function() require('cinnamon').setup() end }
	use { 'ms-jpq/chadtree', branch = 'chad', run = 'python -m chadtree deps', setup = function()
		vim.g.chadtree_settings = { ["theme.text_colour_set"] = 'nerdtree_syntax_dark' }
	end}
	use 'kevinhwang91/nvim-hlslens'
	use { 'nacro90/numb.nvim', config = function() require('numb').setup() end }
	use 'RRethy/vim-illuminate'
	use 'ggandor/lightspeed.nvim'

	-- Quality of life
	use { 'windwp/nvim-autopairs', config = function() require('nvim-autopairs').setup{} end }
	use { 'stevearc/dressing.nvim', after = 'telescope.nvim' }
	use { 'godlygeek/tabular', opt = true, cmd = { 'Tabularize', 'Tab' } }
	use 'tpope/vim-surround'
	use { 'lukas-reineke/indent-blankline.nvim', after = 'nvim-treesitter', config = function()
		require('indent_blankline').setup{
			show_current_context = true,
			show_current_context_start = true
		}
	end}
	use { 'norcalli/nvim-colorizer.lua', config = function() require('colorizer').setup() end }
	use { 'mcauley-penney/tidy.nvim', config = function() require('tidy').setup() end }
	use { 'gbprod/cutlass.nvim', config = function()
		require('cutlass').setup({
			cut_key = 'd'
		})
	end}
	use { 'sQVe/sort.nvim', config = function() require('sort').setup({}) end }
	use { 'booperlv/nvim-gomove', config = function()
		require('gomove').setup{
			map_defaults = true,
			reindent = true,
			undojoin = true
		}
	end}

	-- Workflow
	use { 'ahmedkhalf/project.nvim', after = 'telescope.nvim', config = function()
		require('project_nvim').setup{}
		require('telescope').load_extension('projects')
	end}
	use 'tpope/vim-projectionist'
	use 'tpope/vim-dispatch'
	use 'igemnace/vim-makery'
	use { 'numToStr/Comment.nvim', config = function() require('Comment').setup() end }

	-- LSP
	use {'williamboman/nvim-lsp-installer', requires = 'neovim/nvim-lspconfig', after = { 'coq_nvim', 'vim-illuminate' }, config = function()
		require('nvim-lsp-installer').setup{
			ensure_installed = { 'clangd', 'cmake' },
			ui = { border = 'rounded' }
		}

		for _, server in ipairs(require('nvim-lsp-installer').get_installed_servers()) do
			require('lspconfig')[server.name].setup(require('coq').lsp_ensure_capabilities({ on_attach = function(client) require('illuminate').on_attach(client) end }))
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
	use { 'ms-jpq/coq_nvim', branch = 'coq', requires = 'kyazdani42/nvim-web-devicons', config = function()
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
