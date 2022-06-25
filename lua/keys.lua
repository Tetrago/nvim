require('which-key').register({
	['<C-a>'] = { '<Cmd>A<CR>', 'Alternate' },
	['<C-k>'] = { '<Cmd>Telescope find_files<CR>', 'Find files' },
	['<C-t>'] = { '<Cmd>Telescope treesitter<CR>', 'Find tokens' },
	['<C-p>'] = { '<Cmd>lua vim.lsp.buf.signature_help()<CR>', 'List parameters' },
	['<C-h>'] = { '<Cmd>WhichKey<CR>', 'List keys' },
	['<F6>'] = { '<Cmd>Mbuild<CR>', 'Build' },
	['<F5>'] = { '<Plug>VimspectorContinue', 'Continue' },
	['<S-F5>'] = { '<Plug>VimspectorStop', 'Stop' },
	['<F9>'] = { '<Plug>VimspectorToggleBreakpoint', 'Toggle breakpoint' },
	['<F10>'] = { '<Plug>VimspectorStepOver', 'Step over' },
	['<F11>'] = { '<Plug>VimspectorStepInto', 'Step into' },
	['<F12>'] = { '<Plug>VimspectorStepOut', 'Step out' }
})

require('which-key').register({
	['<C-p>'] = { '<Cmd>lua vim.lsp.buf.signature_help()<CR>', 'List parameters' },
}, { mode = 'i' })

require('which-key').register({
	q = { '<Cmd>TroubleToggle<CR>', 'Toggle quickfix' },
	f = { '<Cmd>Telescope file_browser<CR>', 'Browse files' },
	p = { '<Cmd>Telescope projects<CR>', 'Projects' },
	i = {
		name = '+install',
		l = { '<Cmd>LspInstallInfo<CR>', 'Language servers' },
		p = { '<Cmd>PackerSync<CR>', 'Plugins' },
		d = { '<Cmd>VimspectorUpdate<CR>', 'Update debug adapters' }
	},
	d = {
		name = '+debug',
		u = { '<Plug>VimspectorUpFrame', 'Move up a frame' },
		d = { '<Plug>VimspectorDownFrame', 'Move down a frame' },
		i = { '<Plug>VimspectorBalloonEval', 'Inspect' },
		l = { '<Cmd>call vimspector#Launch()<CR>', 'Launch' },
		q = { '<Cmd>VimspectorReset<CR>', 'Close debugger' }
	},
	c = {
		name = '+config',
		i = { '<Cmd>e ' .. vim.fn.stdpath('config') .. '/init.lua<CR>', 'Open init.lua' },
		p = { '<Cmd>e ' .. vim.fn.stdpath('config') .. '/lua/plugins.lua<CR>', 'Open plugins.lua' },
		k = { '<Cmd>e ' .. vim.fn.stdpath('config') .. '/lua/keys.lua<CR>', 'Open keys.lua' }
	},
	s = 'which_key_ignore'
}, { prefix = '<Leader>' })

require('which-key').register({
	A = { '<Cmd>AS<CR>', 'Alternate split horizontal' },
	a = { '<Cmd>AV<CR>', 'Alternate split vertical' },
	['.'] = { '<Cmd>vertical resize +10<CR>', 'Increase vertical size' },
	[','] = { '<Cmd>vertical resize -10<CR>', 'Decrease vertical size' }
}, { prefix = '<C-w>' })

require('which-key').register({
	D = { '<Cmd>lua vim.lsp.buf.declaration()<CR>', 'Declaration' },
	d = { '<Cmd>Telescope lsp_definitions<CR>', 'Definitions' },
	i = { '<Cmd>Telescope lsp_implementations<CR>', 'Implementations' },
	r = { '<Cmd>Telescope lsp_references<CR>', 'References' },
	t = { '<Cmd>Telescope lsp_type_definitions<CR>', 'Types' },
	l = { '<Cmd>lua vim.lsp.diagnostic.get_line_diagnostics()<CR>', 'Line diagnostics' }
}, { prefix = 'g' })
