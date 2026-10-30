local o = vim.o

o.clipboard = 'unnamedplus'
o.hlsearch = false
o.number = true
o.relativenumber = true
o.signcolumn = 'yes'
o.mouse = 'a'
o.breakindent = true
o.undofile = true
o.updatetime = 250
o.termguicolors = true

-- Case insensitive searching UNLESS capital in search
o.ignorecase = true
o.smartcase = true

vim.diagnostic.config {
  severity_sort = true,
  float = { border = 'rounded' },
  virtual_text = true,
}
