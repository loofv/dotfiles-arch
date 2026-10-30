-- Syntax highlighting via treesitter.
-- Uses the `main` branch (rewrite for nvim 0.11+); parsers are compiled locally,
-- which requires the `tree-sitter` CLI (brew install tree-sitter-cli) and a C compiler.
local parsers = {
  'python', 'java', 'kotlin', 'lua', 'bash', 'json',
  'markdown', 'markdown_inline', 'swift',
  'vim', 'vimdoc', 'query', 'regex', 'gitcommit', 'diff',
}

return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  lazy = false,
  build = ':TSUpdate',
  config = function()
    local ts = require 'nvim-treesitter'
    ts.setup {}

    if vim.fn.executable 'tree-sitter' == 1 then
      ts.install(parsers)
    else
      vim.notify('tree-sitter CLI not found: brew install tree-sitter-cli', vim.log.levels.WARN)
    end

    -- zsh has no parser of its own; bash is close enough
    vim.treesitter.language.register('bash', 'zsh')
    vim.treesitter.language.register('json', 'jsonc')

    vim.api.nvim_create_autocmd('FileType', {
      group = vim.api.nvim_create_augroup('UserTreesitter', { clear = true }),
      callback = function(ev)
        if pcall(vim.treesitter.start, ev.buf) then
          vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })
  end,
}
