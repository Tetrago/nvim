local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    packer_bootstrap = vim.fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
end

return require('packer').startup({function(use)
    use 'wbthomason/packer.nvim'
    use { 'lewis6991/impatient.nvim', config = function() require('impatient') end }

    -- Interface
    use { 'morhetz/gruvbox', config = function()
	vim.g.gruvbox_italics = 1
	vim.cmd [[colorscheme gruvbox]]
    end}
    use { 'windwp/windline.nvim', config = function()
	require('wlsample.airline')
    end}
    use 'mhinz/vim-signify'
    use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' }, config = function()
	require('telescope').setup{ defaults = { file_ignore_patterns = { ".cache", "build", ".git", ".vs", "external" } } }
	require('telescope').load_extension('file_browser')
    end}
    use { 'nvim-telescope/telescope-file-browser.nvim' }
    use { 'goolord/alpha-nvim', requires = { 'kyazdani42/nvim-web-devicons' }, config = function() require('alpha').setup(require('dashboard').config) end }
    use { 'folke/which-key.nvim', config = function()
	require('which-key').setup{
	    triggers = { '<Leader>', 'g', '<C-w>' }
	}
	require('keys')
    end}

    -- Quality of life
    use 'ggandor/lightspeed.nvim'
    use 'milkypostman/vim-togglelist'
    use { 'windwp/nvim-autopairs', config = function() require('nvim-autopairs').setup{} end }
    use { 'stevearc/dressing.nvim', after = 'telescope.nvim' }
    use { 'godlygeek/tabular', opt = true, cmd = { 'Tabularize', 'Tab' } }
    use { 'SirVer/ultisnips', opts = true, keys = { '<C-e>' }, setup = function()
	vim.g.UltiSnipsExpandTrigger = '<C-e>'
	vim.g.UltiSnipsSnippetDirectories = { vim.fn.stdpath('config') .. '/UltiSnips' }
    end}
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

    -- Workflow
    use { 'Shatur/neovim-session-manager', config = function()
	require('session_manager').setup({
	    autoload_mode = require('session_manager.config').AutoloadMode.Disabled,
	    autosave_only_in_session = true
	})
    end}
    use { 'tpope/vim-projectionist', opt = true, cmd = { 'SessionManager' } }
    use { 'tpope/vim-dispatch', opt = true, cmd = { 'Make' } }
    use 'igemnace/vim-makery'
    use 'tpope/vim-sleuth'

    -- LSP
    use { 'williamboman/nvim-lsp-installer', config = function()
	require('nvim-lsp-installer').setup{
	    automatic_installation = true,
	    ui = { border = 'rounded' }
	}
    end}
    use { 'neovim/nvim-lspconfig', config = function()
	require('lspconfig').clangd.setup(require('coq').lsp_ensure_capabilities())
	require('lspconfig').cmake.setup(require('coq').lsp_ensure_capabilities())
	require('lspconfig').jsonls.setup(require('coq').lsp_ensure_capabilities())
	require('lspconfig').yamlls.setup(require('coq').lsp_ensure_capabilities())
	require('lspconfig').sumneko_lua.setup(require('coq').lsp_ensure_capabilities())
    end}
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', config = function()
	require('nvim-treesitter.configs').setup{
	    ensure_installed = { 'c', 'cpp', 'cmake', 'lua', 'toml', 'yaml', 'json', 'jsdoc' },
	    highlight = { enable = true },
	    incremental_selection = { enable = true },
	    indent = { enable = false }
	}
    end}

    -- Completion
    use { 'ms-jpq/coq_nvim', branch = 'coq', requires = { 'kyazdani42/nvim-web-devicons' }, config = function() require('coq') end }
    use { 'ms-jpq/coq.artifacts', branch = 'artifacts' }

    -- Debug
    use { 'mfussenegger/nvim-dap', config = function()
        if vim.loop.os_uname().sysname == 'Windows_NT' then
	    require('dap').adapters.cppdbg = {
		id = 'cppdbg',
		type = 'executable',
		command = vim.fn.stdpath('config') .. '\\cpptools\\debugAdapters\\bin\\OpenDebugAD7.exe',
        	options = {
        		detached = false
		    }
        	}
        end

        require('dap').configurations.cpp = {
            {
        	name = 'Launch file',
        	type = 'cppdbg',
        	request = 'launch',
        	program = function() return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file') end,
        	cwd = '${workspaceFolder}',
        	stopOnEntry = true,
        	setupCommands = {
		    {
        		text = '-enable-pretty-printing',
        		description = 'Enable pretty printing',
        		ignoreFailures = false
		    }
        	}
            }
        }
    end}
    use { 'theHamsta/nvim-dap-virtual-text', config = function() require('nvim-dap-virtual-text').setup() end }

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
