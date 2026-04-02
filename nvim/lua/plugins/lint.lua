return {
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require("lint")

      lint.linters_by_ft = {
        go = { "golangcilint" },
        html = { "htmlhint" },
        javascript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        typescript = { "eslint_d" },
        typescriptreact = { "eslint_d" },
        css = { "stylelint" },
      }

      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
      vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave", "BufReadPost" }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })
    end,
    keys = {
      {
        "<leader>el",
        function()
          require("lint").try_lint()
        end,
        desc = "Lint current buffer",
      },
      {
        "<leader>er",
        function()
          vim.diagnostic.reset()
        end,
        desc = "Reset diagnostics",
      },
    },
  },
}
