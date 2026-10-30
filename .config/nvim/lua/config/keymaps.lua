local map = vim.keymap.set

map({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Word-wrap aware movement
map('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostics
map('n', '[d', function() vim.diagnostic.jump { count = -1 } end, { desc = 'Previous diagnostic' })
map('n', ']d', function() vim.diagnostic.jump { count = 1 } end, { desc = 'Next diagnostic' })
map('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Diagnostic float' })
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Diagnostics to loclist' })

-- LSP (set when a server attaches)
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspKeymaps', { clear = true }),
  callback = function(ev)
    local function nmap(keys, func, desc)
      map('n', keys, func, { buffer = ev.buf, desc = 'LSP: ' .. desc })
    end
    local tb = require 'telescope.builtin'

    nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
    nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
    nmap('gr', tb.lsp_references, '[G]oto [R]eferences')
    nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
    nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
    nmap('<leader>ds', tb.lsp_document_symbols, '[D]ocument [S]ymbols')
    nmap('<leader>ws', tb.lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
    nmap('K', vim.lsp.buf.hover, 'Hover documentation')
    nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature documentation')
    nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd folder')
    nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove folder')
    nmap('<leader>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, '[W]orkspace [L]ist folders')

    vim.api.nvim_buf_create_user_command(ev.buf, 'Format', function()
      vim.lsp.buf.format()
    end, { desc = 'Format current buffer with LSP' })
  end,
})
