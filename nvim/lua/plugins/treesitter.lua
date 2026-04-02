return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
      -- Ensure parsers are installed
      local ensure_installed = {
        "bash", "c", "cpp", "css", "dockerfile", "go", "gomod",
        "graphql", "html", "javascript", "json", "lua", "markdown",
        "markdown_inline", "python", "rust", "scss", "sql", "svelte",
        "tsx", "typescript", "vim", "vimdoc", "xml", "yaml",
      }

      -- Auto-install missing parsers
      local installed = require("nvim-treesitter.install")
      for _, lang in ipairs(ensure_installed) do
        local ok, _ = pcall(vim.treesitter.language.inspect, lang)
        if not ok then
          pcall(installed.install, lang)
        end
      end

      -- Enable treesitter highlighting and indentation
      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          pcall(vim.treesitter.start, args.buf)
        end,
      })

      -- Textobjects (replaces CoC funcobj/classobj mappings)
      require("nvim-treesitter-textobjects").setup({
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
          },
        },
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            ["]m"] = "@function.outer",
          },
          goto_previous_start = {
            ["[m"] = "@function.outer",
          },
        },
      })
    end,
  },
}
