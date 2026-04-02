return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = "+" },
          change = { text = "~" },
          delete = { text = "-" },
          topdelete = { text = "‾" },
          changedelete = { text = "*" },
        },
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns
          local opts = { buffer = bufnr, silent = true }

          -- Next/prev hunk (replaces signify-next-hunk/signify-prev-hunk)
          vim.keymap.set("n", "<leader>gj", gs.next_hunk, opts)
          vim.keymap.set("n", "<leader>gk", gs.prev_hunk, opts)

          -- Diff (replaces SignifyDiff)
          vim.keymap.set("n", "<leader>gd", gs.diffthis, opts)

          -- Toggle current line blame (replaces SignifyFold)
          vim.keymap.set("n", "<leader>gf", gs.toggle_current_line_blame, opts)

          -- Reset hunk (replaces SignifyHunkUndo)
          vim.keymap.set("n", "<leader>gu", gs.reset_hunk, opts)
        end,
      })
    end,
  },
}
