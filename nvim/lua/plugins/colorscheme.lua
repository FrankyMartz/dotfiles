-------------------------------------------------------------------------------
-- Colorscheme
-- Translated from init.vim.bak (Color Scheme section)
-------------------------------------------------------------------------------

local color_scheme_light = "rose-pine"
local color_scheme_dark = "OceanicNext"

--- Detect system dark/light mode
---@return string "dark" or "light"
local function check_dark_mode()
  local bg = "dark" -- Default
  if vim.fn.has("mac") == 1 and vim.fn.executable("defaults") == 1 then
    local result = vim.fn.system("defaults read -g AppleInterfaceStyle 2>/dev/null")
    if result:match("Dark") then
      bg = "dark"
    else
      bg = "light"
    end
  elseif vim.fn.executable("gsettings") == 1 then
    local schema = vim.fn.system("gsettings get org.gnome.desktop.interface color-scheme 2>/dev/null")
    bg = schema:match("dark") and "dark" or "light"
  elseif vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1 then
    local res = vim.fn.system(
      'powershell -c "Get-ItemPropertyValue -Path HKCU:\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Themes\\Personalize -Name AppsUseLightTheme"'
    )
    bg = vim.fn.trim(res) == "0" and "dark" or "light"
  end
  return bg
end

--- Apply colorscheme based on background
local function apply_colorscheme(bg)
  vim.o.background = bg
  local scheme = (bg == "dark") and color_scheme_dark or color_scheme_light
  local ok, _ = pcall(vim.cmd.colorscheme, scheme)
  if not ok then
    vim.notify("Colorscheme " .. scheme .. " not found, falling back to default", vim.log.levels.WARN)
  end
end

--- Toggle between dark and light
local function toggle_background()
  local new_bg = (vim.o.background == "dark") and "light" or "dark"
  apply_colorscheme(new_bg)
end

return {
  -- OceanicNext (dark, primary)
  {
    "mhartington/oceanic-next",
    lazy = false,
    priority = 1000,
    init = function()
      vim.g.oceanic_next_terminal_bold = 1
      vim.g.oceanic_next_terminal_italic = 1
    end,
  },

  -- rose-pine (light, primary)
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = false,
    priority = 1000,
  },

  -- Solarized (optional)
  {
    "lifepillar/vim-solarized8",
    lazy = true,
    init = function()
      vim.g.solarized_visibility = "normal"
      vim.g.solarized_diffmode = "normal"
      vim.g.solarized_termtrans = 0
      vim.g.solarized_statusline = "normal"
      vim.g.solarized_italics = 1
      vim.g.solarized_old_cursor_style = 0
      vim.g.solarized_enable_extra_hi_groups = 1
    end,
  },

  -- base16 (optional)
  {
    "RRethy/base16-nvim",
    lazy = true,
  },

  -- Apply colorscheme on VeryLazy so all plugins have loaded
  {
    "mhartington/oceanic-next",
    event = "VimEnter",
    config = function()
      -- Detect and apply
      local bg = check_dark_mode()
      apply_colorscheme(bg)

      -- ToggleBg command and keymap
      vim.api.nvim_create_user_command("ToggleBg", toggle_background, { desc = "Toggle dark/light background" })
      vim.keymap.set("n", "<leader>bg", "<cmd>ToggleBg<CR>", { desc = "Toggle dark/light background" })
    end,
  },
}
