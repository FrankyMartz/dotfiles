-------------------------------------------------------------------------------
-- Autocommands
-- Translated from init.vim.bak
-------------------------------------------------------------------------------

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-------------------------------------------------------------------------------
-- C
-------------------------------------------------------------------------------
autocmd("FileType", {
  group = augroup("ft_c", { clear = true }),
  pattern = "c",
  callback = function()
    vim.opt_local.foldmethod = "marker"
    vim.opt_local.foldmarker = "{,}"
  end,
})

-------------------------------------------------------------------------------
-- CSS, SASS, Stylus, LESS
-------------------------------------------------------------------------------
local ft_css = augroup("ft_css", { clear = true })
autocmd({ "BufNewFile", "BufRead" }, {
  group = ft_css,
  pattern = "*.styl",
  callback = function()
    vim.bo.filetype = "stylus"
  end,
})
autocmd("FileType", {
  group = ft_css,
  pattern = { "scss", "sass", "less", "css" },
  callback = function()
    vim.opt_local.foldmethod = "marker"
    vim.opt_local.foldmarker = "{,}"
  end,
})

-------------------------------------------------------------------------------
-- Docker
-------------------------------------------------------------------------------
autocmd({ "BufRead", "BufNewFile" }, {
  group = augroup("ft_docker", { clear = true }),
  pattern = "*.Dockerfile",
  callback = function()
    vim.bo.filetype = "Dockerfile"
  end,
})

-------------------------------------------------------------------------------
-- DotEnv
-------------------------------------------------------------------------------
autocmd({ "BufRead", "BufNewFile" }, {
  group = augroup("ft_dotenv", { clear = true }),
  pattern = "*.env",
  callback = function()
    vim.bo.filetype = "sh.env"
  end,
})

-------------------------------------------------------------------------------
-- Git
-------------------------------------------------------------------------------
autocmd("FileType", {
  group = augroup("ft_git", { clear = true }),
  pattern = "gitcommit",
  callback = function()
    vim.opt_local.textwidth = 72
    vim.opt_local.colorcolumn = "72"
    vim.opt_local.spell = true
  end,
})

-------------------------------------------------------------------------------
-- HTML
-------------------------------------------------------------------------------
autocmd("FileType", {
  group = augroup("ft_html", { clear = true }),
  pattern = "html",
  callback = function()
    vim.opt_local.foldmethod = "syntax"
  end,
})

-------------------------------------------------------------------------------
-- JavaScript
-------------------------------------------------------------------------------
local ft_javascript = augroup("ft_javascript", { clear = true })
autocmd({ "BufNewFile", "BufRead" }, {
  group = ft_javascript,
  pattern = "*.es6",
  callback = function()
    vim.bo.filetype = "javascript"
  end,
})
autocmd({ "BufNewFile", "BufRead" }, {
  group = ft_javascript,
  pattern = "*.spec.js",
  callback = function()
    vim.bo.filetype = "javascript.spec"
  end,
})

-------------------------------------------------------------------------------
-- JSON
-------------------------------------------------------------------------------
local ft_json = augroup("ft_json", { clear = true })
autocmd({ "BufNewFile", "BufRead" }, {
  group = ft_json,
  pattern = "*.jsonp",
  callback = function()
    vim.bo.filetype = "json"
  end,
})
autocmd("FileType", {
  group = ft_json,
  pattern = "json",
  callback = function()
    vim.opt_local.foldmethod = "marker"
    vim.opt_local.foldmarker = "{,}"
  end,
})

-------------------------------------------------------------------------------
-- Markdown
-------------------------------------------------------------------------------
autocmd("FileType", {
  group = augroup("ft_markdown", { clear = true }),
  pattern = "markdown",
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.list = false
    vim.opt_local.spell = true
  end,
})

-------------------------------------------------------------------------------
-- Python
-------------------------------------------------------------------------------
local ft_python = augroup("ft_python", { clear = true })
autocmd("FileType", {
  group = ft_python,
  pattern = "python",
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.define = [[^\s*\(def\|class\)]]
    if vim.g.python_space_error_highlight then
      vim.g.python_space_error_highlight = nil
    end
    vim.cmd([[iabbrev <buffer> afo assert False, 'Okay']])
  end,
})
autocmd("FileType", {
  group = ft_python,
  pattern = "man",
  callback = function()
    vim.keymap.set("n", "<CR>", "<cmd>q<CR>", { buffer = true })
  end,
})

-------------------------------------------------------------------------------
-- Text
-------------------------------------------------------------------------------
autocmd("FileType", {
  group = augroup("ft_text", { clear = true }),
  pattern = "text",
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.textwidth = 80
    vim.opt_local.colorcolumn = "1"
  end,
})

-------------------------------------------------------------------------------
-- TypeScript
-------------------------------------------------------------------------------
autocmd("FileType", {
  group = augroup("ft_typescript", { clear = true }),
  pattern = "typescript",
  callback = function()
    vim.opt_local.concealcursor = ""
    vim.opt_local.foldmethod = "syntax"
  end,
})

-------------------------------------------------------------------------------
-- SQL
-------------------------------------------------------------------------------
autocmd("FileType", {
  group = augroup("ft_sql", { clear = true }),
  pattern = "sql",
  callback = function()
    vim.opt_local.foldmethod = "indent"
    vim.opt_local.commentstring = "-- %s"
    vim.opt_local.comments = ":--"
  end,
})

-------------------------------------------------------------------------------
-- Vim
-------------------------------------------------------------------------------
local ft_vim = augroup("ft_vim", { clear = true })
autocmd("FileType", {
  group = ft_vim,
  pattern = "vim",
  callback = function()
    vim.opt_local.foldmethod = "marker"
  end,
})
autocmd("FileType", {
  group = ft_vim,
  pattern = "help",
  callback = function()
    vim.opt_local.textwidth = 78
  end,
})

-------------------------------------------------------------------------------
-- XML
-------------------------------------------------------------------------------
local ft_xml = augroup("ft_xml", { clear = true })
autocmd({ "BufNewFile", "BufRead" }, {
  group = ft_xml,
  pattern = "*.rss",
  callback = function()
    vim.bo.filetype = "xml"
  end,
})
autocmd("FileType", {
  group = ft_xml,
  pattern = "xml",
  callback = function()
    vim.opt_local.foldmethod = "syntax"
  end,
})

-------------------------------------------------------------------------------
-- GraphQL (from plug_graphql augroup)
-------------------------------------------------------------------------------
autocmd({ "BufNewFile", "BufRead" }, {
  group = augroup("ft_graphql", { clear = true }),
  pattern = "*.prisma",
  callback = function()
    vim.bo.filetype = "graphql"
  end,
})

-------------------------------------------------------------------------------
-- VIMRC group
-------------------------------------------------------------------------------
local ft_vimrc = augroup("ft_vimrc", { clear = true })

-- Open help windows in vertical split
autocmd("BufWinEnter", {
  group = ft_vimrc,
  pattern = "*.txt",
  callback = function()
    if vim.bo.filetype == "help" then
      vim.cmd("wincmd L")
    end
  end,
})

-- Terminal: no line numbers
autocmd("TermOpen", {
  group = ft_vimrc,
  pattern = "*",
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
  end,
})

-- Quickfix: no line numbers, no colorcolumn
autocmd("FileType", {
  group = ft_vimrc,
  pattern = "qf",
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.colorcolumn = ""
  end,
})

-- Cursorline on WinEnter / WinLeave
autocmd("WinEnter", {
  group = ft_vimrc,
  pattern = "*",
  callback = function()
    vim.opt_local.cursorline = true
  end,
})
autocmd("WinLeave", {
  group = ft_vimrc,
  pattern = "*",
  callback = function()
    vim.opt_local.cursorline = false
  end,
})

-- Restore cursor position on file reopen
autocmd("BufReadPost", {
  group = ft_vimrc,
  pattern = "*",
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local line_count = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= line_count then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
      vim.cmd("normal! zvzz")
    end
  end,
})
