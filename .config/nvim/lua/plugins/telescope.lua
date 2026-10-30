-- Both finders use ripgrep and are case-insensitive. They include hidden files and
-- ignore .gitignore rules (e.g. Xcode's project.pbxproj sits in an ignored *.xcodeproj),
-- so build/dependency folders are excluded explicitly instead.
local excluded = {
  '.git', 'node_modules', 'build', '.build', 'DerivedData', 'Pods', '.gradle',
  '__pycache__', '.venv', 'venv', '.idea', '.DS_Store',
}
local function rg_globs()
  local globs = {}
  for _, dir in ipairs(excluded) do
    table.insert(globs, '--glob=!**/' .. dir .. '/**')
    table.insert(globs, '--glob=!**/' .. dir)
  end
  return globs
end

return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make', cond = vim.fn.executable 'make' == 1 },
  },
  cmd = 'Telescope',
  keys = {
    { '<leader>ff', function() require('telescope.builtin').find_files() end, desc = '[F]ind [F]iles (rg)' },
    { '<leader>rg', function() require('telescope.builtin').live_grep() end, desc = '[R]ip[G]rep in files' },
    { '<leader>sw', function() require('telescope.builtin').grep_string() end, desc = '[S]earch current [W]ord' },
    { '<leader>sh', function() require('telescope.builtin').help_tags() end, desc = '[S]earch [H]elp' },
    { '<leader>sd', function() require('telescope.builtin').diagnostics() end, desc = '[S]earch [D]iagnostics' },
    { '<leader>?', function() require('telescope.builtin').oldfiles() end, desc = 'Recently opened files' },
    { '<leader><space>', function() require('telescope.builtin').buffers() end, desc = 'Existing buffers' },
    {
      '<leader>/',
      function()
        require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end,
      desc = 'Fuzzy search in current buffer',
    },
  },
  config = function()
    local telescope = require 'telescope'
    telescope.setup {
      defaults = {
        path_display = { shorten = { len = 1, exclude = { 1, -1, -2 } } },
        wrap_results = true,
        -- replaces the default --smart-case with --ignore-case
        vimgrep_arguments = vim.list_extend({
          'rg', '--color=never', '--no-heading', '--with-filename', '--line-number', '--column',
          '--ignore-case', '--hidden', '--no-ignore-vcs',
        }, rg_globs()),
        mappings = { i = { ['<C-u>'] = false, ['<C-d>'] = false } },
      },
      pickers = {
        find_files = {
          find_command = vim.list_extend({ 'rg', '--files', '--hidden', '--no-ignore-vcs', '--ignore-case' }, rg_globs()),
        },
      },
      extensions = {
        fzf = { case_mode = 'ignore_case' },
      },
    }
    pcall(telescope.load_extension, 'fzf')
  end,
}
