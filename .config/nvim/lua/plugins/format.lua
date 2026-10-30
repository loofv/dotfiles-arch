return {
  {
    'stevearc/conform.nvim',
    event = 'BufWritePre',
    cmd = 'ConformInfo',
    opts = {
      formatters_by_ft = {
        python = { 'ruff_format', 'ruff_organize_imports' },
        lua = { 'stylua' },
        sh = { 'shfmt' },
        bash = { 'shfmt' },
        zsh = { 'shfmt' },
        json = { 'prettier' },
        jsonc = { 'prettier' },
        markdown = { 'prettier' },
        java = { 'google-java-format' },
        kotlin = { 'ktlint' },
        swift = { 'swift_format' },
      },
      formatters = {
        -- swift-format ships with Xcode, not Mason
        swift_format = { command = 'xcrun', prepend_args = { 'swift-format' } },
        shfmt = { prepend_args = { '-i', '2' } },
      },
      format_on_save = { timeout_ms = 1000, lsp_format = 'fallback' },
    },
  },

  -- Installs the formatter binaries through Mason
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    dependencies = 'mason-org/mason.nvim',
    opts = {
      ensure_installed = { 'stylua', 'shfmt', 'prettier', 'google-java-format', 'ktlint' },
    },
  },
}
