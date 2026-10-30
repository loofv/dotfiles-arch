-- Modern LSP setup: nvim-lspconfig now only ships server definitions (lsp/*.lua);
-- servers are configured with the built-in vim.lsp.config() and started with vim.lsp.enable().
return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'mason-org/mason.nvim', opts = {} },
      'mason-org/mason-lspconfig.nvim',
      { 'j-hui/fidget.nvim', opts = {} },
      { 'saghen/blink.cmp' },
    },
    config = function()
      -- Per-server overrides
      vim.lsp.config('lua_ls', {
        settings = { Lua = { workspace = { checkThirdParty = false }, telemetry = { enable = false } } },
      })
      vim.lsp.config('basedpyright', {
        settings = { basedpyright = { analysis = { typeCheckingMode = 'standard' } } },
      })

      -- Share blink.cmp's completion capabilities with every server
      vim.lsp.config('*', {
        capabilities = require('blink.cmp').get_lsp_capabilities(),
      })

      -- Installed and enabled through Mason
      require('mason-lspconfig').setup {
        ensure_installed = {
          'basedpyright', 'ruff', -- python
          'lua_ls', -- lua
          'bashls', -- bash/shell
          'jsonls', -- json
          'jdtls', -- java
          'kotlin_language_server', -- kotlin
        },
        automatic_enable = true,
      }

      -- Swift: sourcekit-lsp ships with Xcode, so it is not managed by Mason
      vim.lsp.config('sourcekit', {
        cmd = { vim.trim(vim.fn.system 'xcrun -f sourcekit-lsp') },
      })
      vim.lsp.enable 'sourcekit'
    end,
  },

  -- Lua LSP knowledge of the nvim API (replaces neodev.nvim)
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = { library = { { path = '${3rd}/luv/library', words = { 'vim%.uv' } } } },
  },

  {
    'saghen/blink.cmp',
    version = '1.*',
    event = 'InsertEnter',
    opts = {
      keymap = {
        preset = 'enter',
        ['<Tab>'] = { 'select_next', 'snippet_forward', 'fallback' },
        ['<S-Tab>'] = { 'select_prev', 'snippet_backward', 'fallback' },
        ['<C-d>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
      },
      completion = { documentation = { auto_show = true } },
      sources = {
        default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
        providers = {
          lazydev = { name = 'LazyDev', module = 'lazydev.integrations.blink', score_offset = 100 },
        },
      },
    },
  },

  {
    'folke/trouble.nvim',
    cmd = 'Trouble',
    opts = {},
    keys = {
      { '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>', desc = 'Diagnostics (Trouble)' },
      { '<leader>xb', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', desc = 'Buffer diagnostics (Trouble)' },
    },
  },
}
