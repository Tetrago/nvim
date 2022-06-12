" ________             ______        
" ___  __/___  ___________  /_______ 
" __  /  _  / / /_  ___/_  __ \  __ \
" _  /   / /_/ /_  /   _  /_/ / /_/ /
" /_/    \__,_/ /_/    /_.___/\____/ 
"
" Required Items:
" - deno: https://deno.land/

call plug#begin(stdpath('data') . '/plugged')

Plug 'morhetz/gruvbox'
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'
Plug 'p00f/clangd_extensions.nvim'
Plug 'vim-airline/vim-airline'
Plug 'numToStr/FTerm.nvim'
Plug 'milkypostman/vim-togglelist'
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
Plug 'airblade/vim-gitgutter'
Plug 'ryanoasis/vim-devicons'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'vim-scripts/a.vim'
Plug 'windwp/nvim-autopairs'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-sleuth'
Plug 'Shougo/ddc.vim'
Plug 'vim-denops/denops.vim'
Plug 'delphinus/ddc-treesitter'
Plug 'Shougo/ddc-nvim-lsp'
Plug 'tani/ddc-fuzzy'
Plug 'Shougo/pum.vim'
Plug 'ray-x/lsp_signature.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-file-browser.nvim'
Plug 'nvim-telescope/telescope-ui-select.nvim'
Plug 'pianocomposer321/consolation.nvim'
Plug 'tpope/vim-dispatch'
Plug 'igemnace/vim-makery'
Plug 'godlygeek/tabular'
Plug 'SirVer/ultisnips'
Plug 'mfussenegger/nvim-dap'
Plug 'theHamsta/nvim-dap-virtual-text'
Plug 'lewis6991/spellsitter.nvim'
Plug 'mhinz/vim-startify'
Plug 'ntpeters/vim-better-whitespace'
Plug 'lewis6991/impatient.nvim'
Plug 'folke/which-key.nvim'

call plug#end()

lua << EOF

local Path = require('plenary.path')

require('impatient')

require('telescope').setup{ defaults = { file_ignore_patterns = { ".cache", "build", ".git", ".vs", "external" } } }
require('telescope').load_extension('file_browser')
require('telescope').load_extension('ui-select')

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

require('spellsitter').setup()

require('nvim-lsp-installer').setup{
	ensure_installed = { 'clangd' },
	ui = { border = 'rounded' }
}

require('clangd_extensions').setup{
	extensions = {
		inlay_hints = { show_parameter_hints = false }
	}
}

require('lsp_signature').setup({
	bind = true,
	handler_opts = {
		border = 'rounded'
	},
	toggle_key = '<C-p>'
})

if vim.loop.os_uname().sysname == 'Windows_NT' then
	require('dap').adapters.cppdbg = {
		id = 'cppdbg',
		type = 'executable',
		command = Path:new(vim.fn.stdpath('config'), 'cpptools/debugAdapters/bin/OpenDebugAD7.exe'),
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

vim.g.startify_custom_header = {
	[[ ________             ______         ]],
	[[ ___  __/___  ___________  /_______  ]],
	[[ __  /  _  / / /_  ___/_  __ \  __ \ ]],
	[[ _  /   / /_/ /_  /   _  /_/ / /_/ / ]],
	[[ /_/    \__,_/ /_/    /_.___/\____/  ]]}

EOF

" nvim
let g:mapleader = ' '
let g:gruvbox_italics = 1

" airline
let g:airline_powerline_fonts = 1

" UltiSnips
let g:UltiSnipsExpandTrigger = '<C-e>'
let g:UltiSnipsSnippetDirectories = [ stdpath('config') . '/UltiSnips' ]

" vim-better-whitespace
let g:better_whitespace_filetypes_blacklist = [ 'startify', 'vim' ]

" vim-startify
let g:startify_session_persistence = 1

colorscheme gruvbox

" a.vim
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
nnoremap gD <Cmd>lua vim.lsp.buf.declaration<CR>
nnoremap gd :Telescope lsp_definitions<CR>
nnoremap gi :Telescope lsp_implementations<CR>
nnoremap gl <Cmd>lua vim.lsp.buf.hover<CR>
nnoremap gr :Telescope lsp_references<CR>
nnoremap gt :Telescope lsp_type_definitions<CR>

" dap
nnoremap <Leader>d <Cmd>lua require('dap').repl.open()<CR><C-w>w
nnoremap <F5> <Cmd>lua require('dap').continue()<CR>
nnoremap <S-F5> <Cmd>lua require('dap').run_last()<CR>
nnoremap <F9> <Cmd>lua require('dap').toggle_breakpoint()<CR>
nnoremap <F10> <Cmd>lua require('dap').step_over()<CR>
nnoremap <F11> <Cmd>lua require('dap').step_into()<CR>
nnoremap <F12> <Cmd>lua require('dap').step_out()<CR>
nnoremap <Leader>dt <Cmd>lua require('dap').stop()<CR>
nnoremap <Leader>dk <Cmd>lua require('dap').up()<CR>
nnoremap <Leader>dj <Cmd>lua require('dap').down()<CR>
nnoremap <Leader>di <Cmd>lua require('dap.ui.widgets').hover()<CR>
nnoremap <Leader>ds <Cmd>lua local w = require('dap.ui.widgets'); w.centered_float(w.scopes)<CR>

" vim-startify
nnoremap <Leader>ss :SSave<CR>
nnoremap <Leader>sl :SLoad<CR>
nnoremap <Leader>sc :SClose<CR>

" vim-makery
nnoremap <F6> :Mbuild<CR>

" ddc
inoremap <TAB> <Cmd>call pum#map#insert_relative(+1)<CR>
inoremap <S-TAB> <Cmd>call pum#map#insert_relative(-1)<CR>

set number
set relativenumber
set tabstop=4
set shiftwidth=4
set mouse=a
set autoread
set termguicolors
set encoding=utf8
set nowrap
set spell
set autoindent
set timeoutlen=0
set sessionoptions=blank,curdir,winsize

" ddc
call ddc#custom#patch_global('completionMenu', 'pum.vim')
call ddc#custom#patch_global('sources', ['nvim-lsp', 'treesitter'])
call ddc#custom#patch_global('sourceOptions', { '_': { 'matchers': ['matcher_fuzzy'], 'sorters': ['sorter_fuzzy'] },
			\ 'nvim-lsp': { 'mark': 'LSP', 'forceCompletionPattern': '\.\w*|:\w*|->\w*', 'maxItems': 10 }, 'treesitter': { 'mark': 'T', 'maxItems': 10 } })

call ddc#enable()
