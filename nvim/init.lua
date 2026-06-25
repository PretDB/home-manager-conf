-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.g.encoding = "UTF-8"

vim.opt.backup = true
vim.opt.backupskip = "/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*,.vault.vim"
vim.opt.backupdir = ".vim/backup/"

vim.opt.clipboard:append("unnamedplus")
vim.opt.colorcolumn = "80,120"
vim.opt.cursorline = true
vim.opt.cursorcolumn = true

vim.opt.directory = ".vim/swap/"

vim.opt.fileencoding = "utf-8"
vim.opt.filetype = "on"

vim.opt.hidden = true

vim.opt.listchars = {
  tab = "▸ ",
  trail = "·",
  extends = "»",
  precedes = "«",
  nbsp = "␣",
  eol = "↴",
}

vim.opt.mouse = ""

vim.opt.ruler = true

vim.opt.scrolloff = 3
vim.opt.sidescrolloff = 3
vim.opt.showtabline = 2
vim.opt.smoothscroll = false
vim.opt.softtabstop = 2

vim.opt.splitbelow = true
vim.opt.splitkeep = "cursor"
vim.opt.splitright = true
vim.opt.swapfile = true

vim.opt.timeoutlen = 10000

vim.opt.updatetime = 100
vim.opt.undofile = true
vim.opt.undodir = ".vim/undo/"
vim.opt.undolevels = 1000
vim.opt.undoreload = 10000

vim.opt.wrap = true
vim.opt.writebackup = true
vim.opt.whichwrap:append("<,>,[,],h,l,b,s")
