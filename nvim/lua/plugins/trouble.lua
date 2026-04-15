return {
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = "Trouble",
    keys = {
      { "<leader>ee", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
      { "<leader>qq", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
      { "<leader>xd", "<cmd>Trouble diagnostics toggle<cr>", desc = "Workspace Diagnostics (Trouble)" },
      { "<leader>xs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
      { "gr", "<cmd>Trouble lsp_references toggle<cr>", desc = "LSP References (Trouble)" },
    },
    opts = {
      focus = true,
      auto_close = true,
    },
  },
}
