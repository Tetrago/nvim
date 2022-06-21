require('which-key').register({
    ['<C-a>'] = { '<Cmd>A<CR>', 'Alternate' },
    ['<C-k>'] = { '<Cmd>Telescope find_files<CR>', 'Find files' },
    ['<C-t>'] = { '<Cmd>Telescope treesitter<CR>', 'Find tokens' },
    ['<C-p>'] = { '<Cmd>lua vim.lsp.buf.signature_help()<CR>', 'List parameters' },
    ['<C-h>'] = { '<Cmd>WhichKey<CR>', 'List keys' },
    ['<F6>'] = { '<Cmd>Mbuild<CR>', 'Build' },
    ['<F5>'] = { '<Cmd>lua require("dap").continue()<CR>', 'Run/continue' },
    ['<F9>'] = { '<Cmd>lua require("dap").toggle_breakpoint()<CR>', 'Toggle breakpoint' },
    ['<F10>'] = { '<Cmd>lua require("dap").step_over()<CR>', 'Step over' },
    ['<F11>'] = { '<Cmd>lua require("dap").step_over()<CR>', 'Step into' },
    ['<F12>'] = { '<Cmd>lua require("dap").step_over()<CR>', 'Step out' }
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
        p = { '<Cmd>PackerSync<CR>', 'Plugins' }
    },
    d = {
        name = '+debug',
        t = { '<Cmd>lua require("dap").terminate()<CR>', 'Terminate' },
        i = { '<Cmd>lua require("dap.ui.widgets").hover()<CR>', 'Inspect' },
        s = { '<Cmd>lua local w = require("dap.ui.widgets"); w.centered_float(w.scopes)<CR>', 'Scope' },
        q = { '<Cmd>lua require("dap").repl.toggle()<CR>)', 'Repl' }
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
