" ________             ______        
" ___  __/___  ___________  /_______ 
" __  /  _  / / /_  ___/_  __ \  __ \
" _  /   / /_/ /_  /   _  /_/ / /_/ /
" /_/    \__,_/ /_/    /_.___/\____/ 

call plug#begin(stdpath('data') . '/plugged')

Plug 'morhetz/gruvbox'
Plug 'ggandor/lightspeed.nvim'
Plug 'rcarriga/nvim-notify'
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'
Plug 'p00f/clangd_extensions.nvim'
Plug 'vim-airline/vim-airline'
Plug 'numToStr/FTerm.nvim'
Plug 'milkypostman/vim-togglelist'
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
Plug 'airblade/vim-gitgutter'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'tpope/vim-projectionist'
Plug 'windwp/nvim-autopairs'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-sleuth'
Plug 'ms-jpq/coq_nvim', { 'branch': 'coq' }
Plug 'ms-jpq/coq.artifacts', { 'branch': 'artifacts' }
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-file-browser.nvim'
Plug 'stevearc/dressing.nvim'
Plug 'pianocomposer321/consolation.nvim'
Plug 'tpope/vim-dispatch'
Plug 'igemnace/vim-makery'
Plug 'godlygeek/tabular'
Plug 'SirVer/ultisnips'
Plug 'mfussenegger/nvim-dap'
Plug 'theHamsta/nvim-dap-virtual-text'
Plug 'lewis6991/spellsitter.nvim'
Plug 'Shatur/neovim-session-manager'
Plug 'goolord/alpha-nvim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'lewis6991/impatient.nvim'
Plug 'folke/which-key.nvim'

call plug#end()

" nvim
let g:mapleader = ' '
let g:gruvbox_italics = 1
colorscheme gruvbox

" airline
let g:airline_theme = 'gruvbox'
let g:airline_powerline_fonts = 1

" UltiSnips
let g:UltiSnipsExpandTrigger = '<C-e>'
let g:UltiSnipsSnippetDirectories = [ stdpath('config') . '/UltiSnips' ]

" vim-better-whitespace
let g:better_whitespace_filetypes_blacklist = [ 'alpha', 'vim' ]

" coq
let g:coq_settings = { 'auto_start': 'shut-up' }

lua << EOF

require('impatient')

require('telescope').setup{ defaults = { file_ignore_patterns = { ".cache", "build", ".git", ".vs", "external" } } }
require('telescope').load_extension('file_browser')

require('nvim-autopairs').setup{
	disable_filetype = { "TelescopePrompt", "guihua", "guihua_rust", "clap_input" }
}

require('FTerm').setup({ border = 'rounded', dimensions = { width = 0.8, height = 0.8 }, cmd = 'powershell.exe -nologo' })

require('nvim-treesitter.configs').setup{
	ensure_installed = { "c", "lua", "toml", "yaml", "cpp", "cmake", "jsdoc" },
	highlight = {
		enable = true
	},
	incremental_selection = {
		enable = true
	},
	indent = {
		enable = false
	}
}

require('coq')

require('spellsitter').setup()

require('nvim-lsp-installer').setup{
	automatic_installation = true,
	ui = { border = 'rounded' }
}

require('lspconfig').clangd.setup(require('coq').lsp_ensure_capabilities())
require('lspconfig').cmake.setup(require('coq').lsp_ensure_capabilities())
require('lspconfig').jsonls.setup(require('coq').lsp_ensure_capabilities())
require('lspconfig').yamlls.setup(require('coq').lsp_ensure_capabilities())

require('clangd_extensions').setup{
	extensions = {
		inlay_hints = { show_parameter_hints = false }
	}
}

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

require('nvim-dap-virtual-text').setup()

require('which-key').setup{
	triggers = { '<Leader>', 'g', '<C-w>' }
}

require('session_manager').setup({
	autoload_mode = require('session_manager.config').AutoloadMode.Disabled,
	autosave_only_in_session = true
})

require('alpha').setup(require('dashboard').config)

EOF

" alternate
nnoremap <C-a> :A<CR>
nnoremap <C-w>A :AS<CR>
nnoremap <C-w>a :AV<CR>

" windows
nnoremap <C-w>. :vertical resize +5<CR>
nnoremap <C-w>, :vertical resize -5<CR>
nnoremap <Leader>q <Cmd>call ToggleQuickfixList()<CR>
nnoremap <Leader>l <Cmd>call ToggleLocationList()<CR>
nnoremap <Leader>Q :Telescope quickfix<CR>
nnoremap <Leader>L :Telescope loclist<CR>

" FTerm
nnoremap <Leader>t <Cmd>lua require('FTerm').toggle()<CR>
tnoremap <Leader>t <Cmd>lua require('FTerm').toggle()<CR>

" Telescope
nnoremap <Leader>f :Telescope file_browser<CR>
nnoremap <C-k> :Telescope find_files<CR>
nnoremap <C-t> :Telescope treesitter<CR>

" nvim-lsp-installer
nnoremap <Leader>i :LspInstallInfo<CR>

" lsp
nnoremap <C-p> <Cmd>lua vim.lsp.buf.signature_help()<CR>
inoremap <C-p> <Cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <C-i> <Cmd>lua vim.lsp.buf.hover()<CR>
nnoremap gD <Cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap gd :Telescope lsp_definitions<CR>
nnoremap gi :Telescope lsp_implementations<CR>
nnoremap gr :Telescope lsp_references<CR>
nnoremap gt :Telescope lsp_type_definitions<CR>
nnoremap gl <Cmd>lua vim.lsp.diagnostic.get_line_diagnostics()<CR>

" dap
nnoremap <Leader>dq <Cmd>lua require('dap').repl.toggle()<CR><C-w>w
nnoremap <F5> <Cmd>lua require('dap').continue()<CR>
nnoremap <S-F5> <Cmd>lua require('dap').run_last()<CR>
nnoremap <F9> <Cmd>lua require('dap').toggle_breakpoint()<CR>
nnoremap <F10> <Cmd>lua require('dap').step_over()<CR>
nnoremap <F11> <Cmd>lua require('dap').step_into()<CR>
nnoremap <F12> <Cmd>lua require('dap').step_out()<CR>
nnoremap <Leader>dt <Cmd>lua require('dap').terminate()<CR>
nnoremap <Leader>dk <Cmd>lua require('dap').up()<CR>
nnoremap <Leader>dj <Cmd>lua require('dap').down()<CR>
nnoremap <Leader>di <Cmd>lua require('dap.ui.widgets').hover()<CR>
nnoremap <Leader>ds <Cmd>lua local w = require('dap.ui.widgets'); w.centered_float(w.scopes)<CR>

" neovim-session-manager
nnoremap <Leader>ss :SessionManager save_current_session<CR>
nnoremap <Leader>sl :SessionManager load_session<CR>
nnoremap <Leader>sd :SessionManager delete_session<CR>

" vim-makery
nnoremap <F6> :Mbuild<CR>

if has('termguicolors')
	set termguicolors
endif

set background=dark
set number
set relativenumber
set tabstop=4
set shiftwidth=4
set mouse=a
set autoread
set encoding=utf8
set nowrap
set spell
set autoindent
set timeoutlen=0
set sessionoptions=blank,curdir,winsize
