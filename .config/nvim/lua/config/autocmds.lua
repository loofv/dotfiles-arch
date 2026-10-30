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
