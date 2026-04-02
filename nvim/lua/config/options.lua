-------------------------------------------------------------------------------
-- Options
-- Translated from init.vim.bak
-------------------------------------------------------------------------------

local opt = vim.opt
local g = vim.g
local fn = vim.fn

-------------------------------------------------------------------------------
-- Leader (MUST be set before lazy loads)
-------------------------------------------------------------------------------
g.mapleader = ","
g.maplocalleader = ","

-------------------------------------------------------------------------------
-- General
-------------------------------------------------------------------------------
opt.autoread = true
opt.autowriteall = true
opt.history = 1000
opt.undolevels = 1000
opt.undoreload = 10000
opt.tabpagemax = 50
opt.hidden = true
opt.switchbuf = "useopen"
opt.mouse = "a"
opt.cursorline = true
opt.cursorbind = false
opt.modelines = 0
opt.title = true
opt.number = true
opt.cmdheight = 1
opt.updatetime = 300
opt.shortmess:append("c")
opt.maxmempattern = 5000
opt.scrolloff = 1
opt.sidescrolloff = 5
opt.timeout = false
opt.lazyredraw = true
opt.visualbell = true
opt.errorbells = false
opt.splitbelow = true
opt.splitright = true

-------------------------------------------------------------------------------
-- Wildmenu
-------------------------------------------------------------------------------
opt.wildmenu = true
opt.wildmode = "list:longest"
opt.wildignore:append({
  ".hg", ".git", ".svn",
  "*.aux", "*.out", "*.toc",
  "*.jpg", "*.bmp", "*.gif", "*.png", "*.jpeg",
  "*.o", "*.obj", "*.exe", "*.dmanifest",
  "*.spl",
  "*.sw?",
  "*.DS_Store",
  "*.luac",
  "migrations",
  "*.pyc",
  "*.orig",
})

-------------------------------------------------------------------------------
-- Text, Tab and Indent
-------------------------------------------------------------------------------
opt.formatoptions = "qrn1j"
opt.smartindent = true
opt.shiftround = true
opt.wrap = false
opt.linebreak = true
opt.textwidth = 80
opt.tabstop = 2
opt.wrapmargin = 0
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.conceallevel = 1
opt.concealcursor = "nc"
opt.listchars = { tab = "▸ ", eol = "¬", trail = "…", extends = "❯", precedes = "❮" }

-------------------------------------------------------------------------------
-- Search
-------------------------------------------------------------------------------
opt.ignorecase = true
opt.smartcase = true
opt.gdefault = true
opt.showmatch = true

-------------------------------------------------------------------------------
-- Window
-------------------------------------------------------------------------------
opt.winheight = 5
opt.winminheight = 5
opt.diffopt:append({ "vertical", "iwhite" })
opt.foldenable = false
opt.foldcolumn = "0"

-------------------------------------------------------------------------------
-- Color and Font
-------------------------------------------------------------------------------
if vim.fn.has("termguicolors") == 1 then
  opt.termguicolors = true
else
  g.base16colorspace = 256
end
opt.synmaxcol = 0
opt.colorcolumn = "80"
opt.signcolumn = "yes"
opt.showmode = false -- lualine handles mode display

-------------------------------------------------------------------------------
-- File and Backup
-------------------------------------------------------------------------------
opt.fileformats = "unix"
opt.fileformat = "unix"
opt.sessionoptions:remove("options")
opt.undofile = true
opt.backup = true
opt.backupskip = "/tmp/*,/private/tmp/*"

local tmp_dir = fn.expand("~/.dotfiles/nvim/tmp")
opt.undodir = tmp_dir .. "/undo//"
opt.backupdir = tmp_dir .. "/backup//"
opt.viewdir = tmp_dir .. "/view//"
opt.directory = tmp_dir .. "/swap//"
opt.tags = "./tags,tags"

-- Create directories if they do not exist
for _, dir in ipairs({ "undo", "backup", "view", "swap" }) do
  local path = tmp_dir .. "/" .. dir
  if fn.isdirectory(path) == 0 then
    fn.mkdir(path, "p")
  end
end

-------------------------------------------------------------------------------
-- Provider settings
-------------------------------------------------------------------------------
g.python3_host_prog = "/usr/bin/python3"
g.loaded_perl_provider = 0

-- Volta node detection
if fn.executable("volta") == 1 then
  local npm_path = fn.trim(fn.system('"$(volta which npm)" root -g'))
  if vim.v.shell_error == 0 and npm_path ~= "" then
    g.node_host_prog = npm_path
  end
end

-------------------------------------------------------------------------------
-- Project settings
-------------------------------------------------------------------------------
opt.exrc = true
opt.secure = true
opt.cpoptions:append("d")

-------------------------------------------------------------------------------
-- Markdown fenced languages
-------------------------------------------------------------------------------
g.markdown_fenced_languages = { "css", "js=javascript" }

-------------------------------------------------------------------------------
-- FZF runtime path
-------------------------------------------------------------------------------
local homebrew_prefix = vim.env.HOMEBREW_PREFIX
if homebrew_prefix and homebrew_prefix ~= "" then
  opt.runtimepath:append(homebrew_prefix .. "/opt/fzf")
end
