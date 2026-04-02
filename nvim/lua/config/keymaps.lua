-------------------------------------------------------------------------------
-- Keymaps
-- Translated from init.vim.bak
-------------------------------------------------------------------------------

local map = vim.keymap.set

-------------------------------------------------------------------------------
-- Window Navigation
-------------------------------------------------------------------------------
map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to below window" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to above window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-------------------------------------------------------------------------------
-- Horizontal Scroll
-------------------------------------------------------------------------------
map("n", "<ScrollWheelLeft>", "20zh")
map("n", "<ScrollWheelRight>", "20zl")
map("i", "<ScrollWheelLeft>", "<Left>")
map("i", "<ScrollWheelRight>", "<Right>")
map("n", "<M-h>", "20zh", { desc = "Scroll left" })
map("n", "<M-l>", "20zl", { desc = "Scroll right" })

-------------------------------------------------------------------------------
-- Buffer / Tab Switching
-------------------------------------------------------------------------------
map("n", "<leader>kk", "<cmd>bnext<CR>", { desc = "Next buffer" })
map("n", "<leader>jj", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
map("n", "<leader>hh", "<cmd>tabprevious<CR>", { desc = "Previous tab" })
map("n", "<leader>ll", "<cmd>tabnext<CR>", { desc = "Next tab" })

-------------------------------------------------------------------------------
-- Clipboard
-------------------------------------------------------------------------------
map("v", "<leader>y", '"+y', { desc = "Copy to clipboard" })
map("n", "<leader>Y", '"+yg_', { desc = "Copy to end of line to clipboard" })
map("n", "<leader>y", '"+y', { desc = "Copy to clipboard" })
map("n", "<leader>p", '"+p', { desc = "Paste from clipboard after" })
map("n", "<leader>P", '"+P', { desc = "Paste from clipboard before" })
map("v", "<leader>p", '"+p', { desc = "Paste from clipboard after" })
map("v", "<leader>P", '"+P', { desc = "Paste from clipboard before" })

-------------------------------------------------------------------------------
-- Sudo Write
-------------------------------------------------------------------------------
map("c", "w!!", "w !sudo tee % >/dev/null", { desc = "Sudo write" })

-------------------------------------------------------------------------------
-- Edit vimrc
-------------------------------------------------------------------------------
map("n", "<leader>ev", "<C-w><C-v><C-l>:e $MYVIMRC<CR>", { desc = "Edit vimrc" })

-------------------------------------------------------------------------------
-- Insert Mode Shortcuts
-------------------------------------------------------------------------------
map("i", "jj", "<Esc>", { desc = "Quick escape" })
map("i", "II", "<Esc>I", { desc = "Move cursor to beginning" })
map("i", "AA", "<Esc>A", { desc = "Move cursor to end of line" })
map("i", "OO", "<Esc>O", { desc = "Newline above and place cursor" })
map("i", "CC", "<Esc>cc", { desc = "Clear row and place cursor inline" })

-------------------------------------------------------------------------------
-- Indent with Tab
-------------------------------------------------------------------------------
map("n", "<Tab>", ">>", { desc = "Indent line" })
map("n", "<S-Tab>", "<<", { desc = "Unindent line" })
map("v", "<Tab>", ">gv", { desc = "Indent selection" })
map("v", "<S-Tab>", "<gv", { desc = "Unindent selection" })

-------------------------------------------------------------------------------
-- Split Buffers
-------------------------------------------------------------------------------
map("n", "<C-s>", "<C-w>s", { desc = "Horizontal split" })
map("n", "<C-A-s>", "<C-w>v", { desc = "Vertical split" })
map("n", "<C-q>", "<C-w>q", { desc = "Close window" })

-------------------------------------------------------------------------------
-- Window Resize
-------------------------------------------------------------------------------
map("n", "<Leader>+", function()
  vim.cmd("resize +" .. math.floor(vim.fn.winheight(0) * 1 / 8))
end, { silent = true, desc = "Increase window height" })

map("n", "<Leader>_", function()
  vim.cmd("resize -" .. math.floor(vim.fn.winheight(0) * 1 / 8))
end, { silent = true, desc = "Decrease window height" })

map("n", "<Leader>=", function()
  vim.cmd("vertical resize +" .. math.floor(vim.fn.winwidth(0) * 1 / 8))
end, { silent = true, desc = "Increase window width" })

map("n", "<Leader>-", function()
  vim.cmd("vertical resize -" .. math.floor(vim.fn.winwidth(0) * 1 / 8))
end, { silent = true, desc = "Decrease window width" })

-------------------------------------------------------------------------------
-- Clear Search Results
-------------------------------------------------------------------------------
map("n", "<leader><space>", "<cmd>nohlsearch<CR>", { silent = true, desc = "Clear search highlight" })

-------------------------------------------------------------------------------
-- Terminal
-------------------------------------------------------------------------------
map("t", "<Leader>e", [[<C-\><C-n>]], { desc = "Exit terminal mode" })

-------------------------------------------------------------------------------
-- Sane Regex
-------------------------------------------------------------------------------
map("n", "/", "/\\v", { desc = "Search with very magic" })
map("v", "/", "/\\v", { desc = "Search with very magic" })

-------------------------------------------------------------------------------
-- Component File Loading (.ts/.scss/.html)
-------------------------------------------------------------------------------
local function load_component_type_file(file_type)
  local file_name = vim.fn.expand("%:r")
  if file_name:lower():match("%.component$") and type(file_type) == "string" then
    vim.cmd("find " .. file_name .. file_type)
    print(vim.fn.expand("%"))
  else
    vim.api.nvim_echo(
      { { "File Does NOT match Component Name Scheme. (component.{html,ts,scss})", "WarningMsg" } },
      true,
      {}
    )
  end
end

map("n", "<Leader>1", function() load_component_type_file(".ts") end, { silent = true, desc = "Load .ts component" })
map("n", "<Leader>2", function() load_component_type_file(".scss") end, { silent = true, desc = "Load .scss component" })
map("n", "<Leader>3", function() load_component_type_file(".html") end, { silent = true, desc = "Load .html component" })

-------------------------------------------------------------------------------
-- Quickfix / Location List Toggles (replacing ListToggle plugin)
-------------------------------------------------------------------------------
local function toggle_list(list_type)
  local win_count = #vim.api.nvim_list_wins()
  if list_type == "loclist" then
    pcall(vim.cmd.lclose)
    if #vim.api.nvim_list_wins() == win_count then
      pcall(vim.cmd.lopen)
    end
  else
    pcall(vim.cmd.cclose)
    if #vim.api.nvim_list_wins() == win_count then
      pcall(vim.cmd.copen)
    end
  end
end

map("n", "<leader>ee", function() toggle_list("loclist") end, { silent = true, desc = "Toggle location list" })
map("n", "<leader>qq", function() toggle_list("quickfix") end, { silent = true, desc = "Toggle quickfix list" })

-------------------------------------------------------------------------------
-- Scrollbind Toggles (from vim-unimpaired)
-------------------------------------------------------------------------------
map("n", "[og", "<cmd>set scrollbind cursorbind<CR>", { silent = true, desc = "Enable scrollbind" })
map("n", "]og", "<cmd>set noscrollbind nocursorbind<CR>", { silent = true, desc = "Disable scrollbind" })

-------------------------------------------------------------------------------
-- Custom Commands
-------------------------------------------------------------------------------

-- FormatJSON
vim.api.nvim_create_user_command("FormatJSON", "%!python3 -m json.tool", { desc = "Format JSON with python3" })

-- DosToUnix / UnixToDos
local function convert_dos_eol(to_dos)
  vim.cmd("update")
  vim.cmd("edit ++ff=dos")
  if to_dos then
    vim.bo.fileformat = "dos"
  else
    vim.bo.fileformat = "unix"
  end
  vim.cmd("write")
end

vim.api.nvim_create_user_command("DosToUnix", function() convert_dos_eol(false) end, { desc = "Convert DOS to Unix line endings" })
vim.api.nvim_create_user_command("UnixToDos", function() convert_dos_eol(true) end, { desc = "Convert Unix to DOS line endings" })

-- Todo (using Telescope grep)
vim.api.nvim_create_user_command("Todo", function()
  local ok, builtin = pcall(require, "telescope.builtin")
  if ok then
    builtin.grep_string({ search = "TODO:|FIXME:|XXXX:|NOTE:|BUG:|CHANGED:|OPTIMIZE:", use_regex = true })
  else
    vim.cmd("grep TODO:\\|FIXME:\\|XXXX:\\|NOTE:\\|BUG:\\|CHANGED:\\|OPTIMIZE:")
  end
end, { desc = "Search for TODO/FIXME/etc." })

-------------------------------------------------------------------------------
-- Scratch Buffer (replacing scratch.vim plugin)
-------------------------------------------------------------------------------
local scratch_buf = nil
local scratch_win = nil

local function toggle_scratch()
  if scratch_win and vim.api.nvim_win_is_valid(scratch_win) then
    vim.api.nvim_win_close(scratch_win, true)
    scratch_win = nil
    return
  end

  if scratch_buf == nil or not vim.api.nvim_buf_is_valid(scratch_buf) then
    scratch_buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_name(scratch_buf, "__Scratch__")
    vim.api.nvim_set_option_value("filetype", "markdown", { buf = scratch_buf })
    vim.api.nvim_set_option_value("bufhidden", "hide", { buf = scratch_buf })
    vim.api.nvim_set_option_value("buftype", "nofile", { buf = scratch_buf })
  end

  vim.cmd("botright split")
  scratch_win = vim.api.nvim_get_current_win()
  vim.api.nvim_win_set_buf(scratch_win, scratch_buf)
  vim.cmd("startinsert")
end

map("n", "<F12>", toggle_scratch, { silent = true, desc = "Toggle scratch buffer" })
map("v", "<F12>", toggle_scratch, { silent = true, desc = "Toggle scratch buffer" })
