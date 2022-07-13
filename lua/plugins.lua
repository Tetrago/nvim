local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	packer_bootstrap = vim.fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
	vim.cmd [[packadd packer.nvim]]
end

return require('packer').startup({function(use)
	use 'wbthomason/packer.nvim'
	use { 'lewis6991/impatient.nvim', config = function() require('impatient') end }

	-- Interface
	require('user').theme(use)
	use { 'nvim-lualine/lualine.nvim', requires = 'kyazdani42/nvim-web-devicons', after = 'gruvbox-material', config = function()
		require('lualine').setup{
			options = {
				theme = 'gruvbox-material'
			}
		}
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
	use { 'ms-jpq/chadtree', branch = 'chad', run = 'python -m chadtree deps', setup = function()
		vim.g.chadtree_settings = { ["theme.text_colour_set"] = 'nerdtree_syntax_dark' }
	end}
	use 'kevinhwang91/nvim-hlslens'
	use { 'nacro90/numb.nvim', config = function() require('numb').setup() end }
	use 'ggandor/lightspeed.nvim'
	use 'RRethy/vim-illuminate'
	use 'folke/lsp-colors.nvim'
	use 'tpope/vim-fugitive'
	use { 'gelguy/wilder.nvim', requires = { 'romgrk/fzy-lua-native', 'kyazdani42/nvim-web-devicons' }, config = function()
		local wilder = require('wilder')

		wilder.setup({ modes = { ':', '/', '?' } })
		wilder.set_option('renderer', wilder.popupmenu_renderer({
			highlighter = { wilder.lua_fzy_highlighter() },
			left = { ' ', wilder.popupmenu_devicons() },
			highlights = {
				accent = wilder.make_hl('WilderAccent', 'Pmenu', { { a = 1 }, { a = 1 }, { foreground = '#844643' } })
			}
		}))
	end}

	-- Quality of life
	use { 'windwp/nvim-autopairs', config = function()
		local npairs = require('nvim-autopairs')

		npairs.setup({ map_bs = false, map_cr = false })

		_G.MUtils = {}

		MUtils.CR = function()
			if vim.fn.pumvisible() ~= 0 then
				if vim.fn.complete_info({ 'selected' }).selected ~= -1 then
					return npairs.esc('<C-y>')
				else
					return npairs.esc('<C-e>') .. npairs.autopairs_cr()
				end
			else
				return npairs.autopairs_cr()
			end
		end
		vim.api.nvim_set_keymap('i', '<Cr>', 'v:lua.MUtils.CR()', { expr = true, noremap = true })

		MUtils.BS = function()
			if vim.fn.pumvisible() ~= 0 and vim.fn.complete_info({ 'mode' }).mode == 'eval' then
				return npairs.esc('<C-e>') .. npairs.autopairs_bs()
			else
				return npairs.autopairs_bs()
			end
		end
		vim.api.nvim_set_keymap('i', '<BS>', 'v:lua.MUtils.BS()', { expr = true, noremap = true })
	end}
	use { 'windwp/nvim-ts-autotag', after = 'nvim-treesitter', config = function() require('nvim-ts-autotag').setup() end }
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
			cut_key = 'd',
			exclude = { 'ns', 'nS' }
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

	-- treesitter
	use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', config = function()
		require('nvim-treesitter.configs').setup{
			ensure_installed = { 'c', 'cpp', 'cmake', 'lua', 'toml', 'yaml', 'json', 'jsdoc' },
			highlight = { enable = true },
			incremental_selection = { enable = true },
			indent = { enable = false },
			refactor = {
				smart_rename = {
					enable = true,
					keymaps = {
						smart_rename = 'grr'
					}
				}
			}
		}
	end}
	use 'nvim-treesitter/nvim-treesitter-refactor'
	use { 'm-demare/hlargs.nvim', after = 'nvim-treesitter', config = function() require('hlargs').setup() end }

	-- coq
	use { 'ms-jpq/coq_nvim', branch = 'coq', requires = 'kyazdani42/nvim-web-devicons', setup = function()
		vim.g.coq_settings = { auto_start = 'shut-up', ['keymap.jump_to_mark'] = '<C-\\>', ['keymap.recommended'] = false }
	end, config = function()
		require('coq')

		vim.api.nvim_set_keymap('i', '<ESC>', [[pumvisible() ? '<C-e><ESC>' : '<ESC>']], { expr = true, noremap = true })
		vim.api.nvim_set_keymap('i', '<C-c>', [[pumvisible() ? '<C-e><C-c>' : '<C-c>']], { expr = true, noremap = true })
		vim.api.nvim_set_keymap('i', '<TAB>', [[pumvisible() ? '<C-n>' : '<TAB>']], { expr = true, noremap = true })
		vim.api.nvim_set_keymap('i', '<S-TAB>', [[pumvisible() ? '<C-p>' : '<BS>']], { expr = true, noremap = true })
	end}
	use { 'ms-jpq/coq.artifacts', branch = 'artifacts', after = 'coq_nvim' }

	-- vimspector
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
