return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
    },
    cmd = "Telescope",
    keys = {
      -- C-t: find files (replaces FZF)
      { "<C-t>", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
      -- <space>a: diagnostics (replaces CocFzfList diagnostics)
      { "<space>a", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics" },
      -- <space>c: commands (replaces CocFzfList commands)
      { "<space>c", "<cmd>Telescope commands<cr>", desc = "Commands" },
      -- <space>o: document symbols (replaces CocFzfList outline)
      { "<space>o", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document Symbols" },
      -- <space>s: workspace symbols (replaces CocFzfList symbols)
      { "<space>s", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Workspace Symbols" },
      -- <space>p: resume (replaces CocFzfListResume)
      { "<space>p", "<cmd>Telescope resume<cr>", desc = "Resume" },
      -- <leader>ag: live grep (replaces Ack/rg)
      { "<leader>ag", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
      -- F9: document symbols
      { "<F9>", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document Symbols" },
      -- <space>e: builtin pickers (replaces CocFzfList extensions)
      { "<space>e", "<cmd>Telescope builtin<cr>", desc = "Telescope Builtin" },
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")

      telescope.setup({
        defaults = {
          layout_config = {
            width = 0.9,
            height = 0.6,
          },
          mappings = {
            i = {
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
            },
          },
        },
      })

      telescope.load_extension("fzf")
    end,
  },
}
