local group = vim.api.nvim_create_augroup('UserAutocmds', { clear = true })

vim.api.nvim_create_autocmd('TextYankPost', {
  group = group,
  callback = function() vim.hl.on_yank() end,
})

-- Remember last cursor position
vim.api.nvim_create_autocmd('BufReadPost', {
  group = group,
  desc = 'Restore last cursor position',
  callback = function(ev)
    local mark = vim.api.nvim_buf_get_mark(ev.buf, '"')
    if mark[1] > 0 and mark[1] <= vim.api.nvim_buf_line_count(ev.buf) then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Commit messages: body lines start with "  * " and Enter continues the bullet
vim.api.nvim_create_autocmd('FileType', {
  group = group,
  pattern = 'gitcommit',
  callback = function(ev)
    vim.opt_local.autoindent = false -- the mapping below supplies the indent

    -- Enter starts the bullet list on line 2 and continues bullets after that
    vim.keymap.set('i', '<CR>', function()
      local line = vim.api.nvim_get_current_line()
      local row = vim.api.nvim_win_get_cursor(0)[1]
      if row == 2 and line == '' then
        return '<CR>  * '
      end
      local bullet = line:match('^%s*[*-] ')
      if bullet and line:match('^%s*[*-] %S') then
        return '<CR>' .. bullet
      end
      if bullet then -- empty bullet: remove it and end the list
        return '<C-u><CR>'
      end
      return '<CR>'
    end, { buffer = ev.buf, expr = true, replace_keycodes = true })
  end,
})
