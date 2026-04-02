return {
  -- vim-surround
  {
    "tpope/vim-surround",
    event = "VeryLazy",
    init = function()
      vim.g["surround_" .. vim.fn.char2nr("-")] = "<% \r %>"
      vim.g["surround_" .. vim.fn.char2nr("=")] = "<%= \r %>"
      vim.g["surround_" .. vim.fn.char2nr("8")] = "/* \r */"
      vim.g["surround_" .. vim.fn.char2nr("s")] = " \r "
      vim.g["surround_" .. vim.fn.char2nr("^")] = "/^\\r$/"
      vim.g.surround_indent = 1
    end,
  },

  -- vim-repeat
  {
    "tpope/vim-repeat",
    event = "VeryLazy",
  },

  -- vim-unimpaired
  {
    "tpope/vim-unimpaired",
    event = "VeryLazy",
  },

  -- vim-characterize
  {
    "tpope/vim-characterize",
    keys = { "ga" },
  },

  -- Comment.nvim
  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    opts = {
      padding = true,
      sticky = true,
    },
  },

  -- nvim-autopairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      local autopairs = require("nvim-autopairs")
      autopairs.setup({})

      -- Integrate with nvim-cmp
      local cmp_ok, cmp = pcall(require, "cmp")
      if cmp_ok then
        local cmp_autopairs = require("nvim-autopairs.completion.cmp")
        cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
      end
    end,
  },

  -- flash.nvim
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash",
      },
      {
        "S",
        mode = { "n", "x", "o" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
    },
  },

  -- vim-visual-multi
  {
    "mg979/vim-visual-multi",
    event = "VeryLazy",
  },

  -- vim-move
  {
    "matze/vim-move",
    event = "VeryLazy",
    init = function()
      vim.g.move_key_modifier = "C-A"
    end,
  },

  -- targets.vim
  {
    "wellle/targets.vim",
    event = "VeryLazy",
  },

  -- vim-mundo
  {
    "simnalamburt/vim-mundo",
    cmd = "MundoToggle",
    keys = {
      { "<F7>", "<cmd>MundoToggle<CR>", desc = "Toggle Mundo" },
    },
  },

  -- tabular
  {
    "godlygeek/tabular",
    cmd = "Tabularize",
  },
}
