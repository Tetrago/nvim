function nmap(key, command)
    vim.api.nvim_set_keymap('n', key, command, { noremap = true, silent = true })
end

function imap(key, command)
    vim.api.nvim_set_keymap('i', key, command, { noremap = true, silent = true })
end

-- alternate
nmap('<C-a>', ':A<CR>')
nmap('<C-w>A', ':AS<CR>')
nmap('<C-w>a', ':AV<CR>')

-- windows
nmap('<C-w>.', ':vertical resize +10<CR>')
nmap('<C-w>,', ':vertical resize -10<CR>')
nmap('<Leader>q', ':call ToggleQuickfixList()<CR>')
nmap('<Leader>l', ':call ToggleLocationList()<CR>')
nmap('<Leader>Q', ':Telescope quickfix<CR>')
nmap('<Leader>L', ':Telescope loclist<CR>')

-- telescope
nmap('<Leader>f', ':Telescope file_browser<CR>')
nmap('<C-k>', ':Telescope find_files<CR>')
nmap('<C-t>', ':Telescope treesitter<CR>')

-- installers
nmap('<Leader>i', ':LspInstallInfo<CR>')
nmap('<Leader>p', ':PackerSync<CR>')

-- lsp
nmap('<C-p>', '<Cmd>lua vim.lsp.buf.signature_help()<CR>')
imap('<C-p>', '<Cmd>lua vim.lsp.buf.signature_help()<CR>')
nmap('<C-i>', '<Cmd>lua vim.lsp.buf.hover()<CR>')
nmap('gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>')
nmap('gd', ':Telescope lsp_definitions<CR>')
nmap('gi', ':Telescope lsp_implementations<CR>')
nmap('gr', ':Telescope lsp_references<CR>')
nmap('gt', ':Telescope lsp_type_definitions<CR>')
nmap('gl', '<Cmd>lua vim.lsp.diagnostic.get_line_diagnostics()<CR>')

-- dap
nmap('<Leader>dq', '<Cmd>lua require("dap").repl.toggle()<CR><C-w>w')
nmap('<F5>', '<Cmd>lua require("dap").continue()<CR>')
nmap('<S-F5>', '<Cmd>lua require("dap").run_last()<CR>')
nmap('<F9>', '<Cmd>lua require("dap").toggle_breakpoint()<CR>')
nmap('<F10>', '<Cmd>lua require("dap").step_over()<CR>')
nmap('<F11>', '<Cmd>lua require("dap").step_into()<CR>')
nmap('<F12>', '<Cmd>lua require("dap").step_out()<CR>')
nmap('<Leader>dt', '<Cmd>lua require("dap").terminate()<CR>')
nmap('<Leader>dk', '<Cmd>lua require("dap").up()<CR>')
nmap('<Leader>dj', '<Cmd>lua require("dap").down()<CR>')
nmap('<Leader>di', '<Cmd>lua require("dap.ui.widgets").hover()<CR>')
nmap('<Leader>ds', '<Cmd>lua local w = require("dap.ui.widgets"); w.centered_float(w.scopes)<CR>')
nmap('<Leader>dq', '<Cmd>lua require("dap").repl.toggle()<CR>')

-- sessions
nmap('<Leader>ss', ':SessionManager save_current_session<CR>')
nmap('<Leader>sl', ':SessionManager load_session<CR>')
nmap('<Leader>sd', ':SessionManager delete_session<CR>')

-- makery
nmap('<F6>', ':Mbuild<CR>')
