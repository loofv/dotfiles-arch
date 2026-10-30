return {
  {
    'navarasu/onedark.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('onedark').setup { style = 'warmer', term_colors = false, transparent = true }
      require('onedark').load()
    end,
  },

  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    opts = {
      options = {
        icons_enabled = false,
        theme = 'onedark',
        component_separators = '|',
        section_separators = '',
      },
    },
  },

  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {},
  },

  { 'tpope/vim-sleuth' }, -- detect tabstop/shiftwidth

  -- Git
  { 'tpope/vim-fugitive', cmd = { 'Git', 'G' } },
  { 'tpope/vim-rhubarb', dependencies = 'tpope/vim-fugitive' },
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },
}
