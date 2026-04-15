return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    lazy = false,
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
      require("nvim-treesitter").setup()

      local ensure_installed = {
        "bash", "c", "cpp", "css", "dockerfile", "go", "gomod",
        "graphql", "html", "javascript", "json", "lua", "markdown",
        "markdown_inline", "python", "rust", "scss", "sql", "svelte",
        "tsx", "typescript", "vim", "vimdoc", "xml", "yaml",
      }

      -- Install any missing parsers (async; will not block startup).
      local installed = require("nvim-treesitter.config").get_installed("parsers")
      local missing = vim.tbl_filter(function(lang)
        return not vim.tbl_contains(installed, lang)
      end, ensure_installed)
      if #missing > 0 then
        require("nvim-treesitter").install(missing)
      end

      -- Start treesitter highlighting + indentation on matching filetypes.
      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          local ft = args.match
          local lang = vim.treesitter.language.get_lang(ft) or ft
          if not pcall(vim.treesitter.language.add, lang) then
            return
          end
          pcall(vim.treesitter.start, args.buf, lang)
          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })

      -- Textobjects (main-branch API: keymaps set manually).
      require("nvim-treesitter-textobjects").setup({
        select = {
          lookahead = true,
        },
        move = {
          set_jumps = true,
        },
      })

      local select = require("nvim-treesitter-textobjects.select")
      vim.keymap.set({ "x", "o" }, "af", function()
        select.select_textobject("@function.outer", "textobjects")
      end, { desc = "Select around function" })
      vim.keymap.set({ "x", "o" }, "if", function()
        select.select_textobject("@function.inner", "textobjects")
      end, { desc = "Select inside function" })
      vim.keymap.set({ "x", "o" }, "ac", function()
        select.select_textobject("@class.outer", "textobjects")
      end, { desc = "Select around class" })
      vim.keymap.set({ "x", "o" }, "ic", function()
        select.select_textobject("@class.inner", "textobjects")
      end, { desc = "Select inside class" })

      local move = require("nvim-treesitter-textobjects.move")
      vim.keymap.set({ "n", "x", "o" }, "]m", function()
        move.goto_next_start("@function.outer", "textobjects")
      end, { desc = "Next function start" })
      vim.keymap.set({ "n", "x", "o" }, "[m", function()
        move.goto_previous_start("@function.outer", "textobjects")
      end, { desc = "Previous function start" })
    end,
  },
}
