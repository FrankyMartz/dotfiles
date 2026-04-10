return {
  -- vim-go
  {
    "fatih/vim-go",
    ft = "go",
    build = ":GoInstallBinaries",
    init = function()
      -- Settings
      vim.g.go_test_show_name = 1
      vim.g.go_autodetect_gopath = 1
      vim.g.go_fmt_command = "goimports"
      vim.g.go_term_mode = "split"
      vim.g.go_textobj_include_function_doc = 1

      -- Syntax Highlight
      vim.g.go_highlight_types = 1
      vim.g.go_highlight_fields = 1
      vim.g.go_highlight_methods = 1
      vim.g.go_highlight_functions = 1
      vim.g.go_highlight_operators = 1
      vim.g.go_highlight_extra_types = 1
      vim.g.go_highlight_generate_tags = 1
      vim.g.go_highlight_build_constraints = 1
      vim.g.go_highlight_variable_assignments = 1
      vim.g.go_highlight_variable_declarations = 1
      vim.g.go_highlight_space_tab_error = 1
      vim.g.go_highlight_chan_whitespace_error = 1
      vim.g.go_highlight_array_whitespace_error = 1

      -- Disable gopls in vim-go (nvim-lspconfig handles it)
      vim.g.go_gopls_enabled = 0
    end,
    config = function()
      vim.api.nvim_create_augroup("plug_go", { clear = true })
      vim.api.nvim_create_autocmd("FileType", {
        group = "plug_go",
        pattern = "go",
        callback = function(ev)
          local opts = { buffer = ev.buf }
          vim.keymap.set("n", "<leader>r", "<Plug>(go-run)", opts)
          vim.keymap.set("n", "<leader>t", "<Plug>(go-test)", opts)
          vim.keymap.set("n", "<leader>c", "<Plug>(go-coverage-toggle)", opts)
          vim.keymap.set("n", "<leader>b", function()
            local file = vim.fn.expand("%")
            if file:match("_test%.go$") then
              vim.fn["go#test#Test"](0, 1)
            elseif file:match("%.go$") then
              vim.fn["go#cmd#Build"](0)
            end
          end, opts)
        end,
      })
    end,
  },

  -- vim-delve
  {
    "sebdah/vim-delve",
    ft = "go",
    init = function()
      vim.g.delve_backend = "native"
      local cache_path = vim.fn.stdpath("cache") .. "/vim-delve//"
      if vim.fn.isdirectory(cache_path) == 0 then
        vim.fn.mkdir(cache_path, "p")
      end
      vim.g.delve_cache_path = cache_path
    end,
  },

  -- vim-jsdoc
  {
    "heavenshell/vim-jsdoc",
    ft = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
    init = function()
      vim.g.jsdoc_additional_descriptions = 1
      vim.g.jsdoc_input_description = 1
      vim.g.jsdoc_allow_input_prompt = 1
      vim.g.jsdoc_access_descriptions = 1
      vim.g.jsdoc_underscore_private = 1
      vim.g.jsdoc_param_description_separator = " - "
      vim.g.jsdoc_enable_es6 = 1
    end,
    keys = {
      { "<leader>jsd", "<cmd>JsDoc<CR>", desc = "Generate JSDoc" },
    },
  },

  -- vim-ragtag
  {
    "tpope/vim-ragtag",
    ft = { "html", "xml", "eruby", "svelte", "vue" },
  },

  -- goyo.vim
  {
    "junegunn/goyo.vim",
    ft = "markdown",
    config = function()
      vim.api.nvim_create_augroup("plug_goyo", { clear = true })
      vim.api.nvim_create_autocmd("User", {
        group = "plug_goyo",
        pattern = "GoyoEnter",
        nested = true,
        callback = function()
          vim.opt_local.showmode = false
          vim.opt_local.scrolloff = 999
        end,
      })
      vim.api.nvim_create_autocmd("User", {
        group = "plug_goyo",
        pattern = "GoyoLeave",
        nested = true,
        callback = function()
          vim.opt_local.showmode = true
          vim.opt_local.scrolloff = 3
        end,
      })
    end,
  },

  -- vim-markdown-toc
  {
    "mzlogin/vim-markdown-toc",
    ft = "markdown",
  },

  -- markdown-preview.nvim
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    ft = "markdown",
    init = function()
      vim.g.mkdp_auto_start = 0
      vim.g.mkdp_auto_close = 1
      vim.g.mkdp_refresh_slow = 0
    end,
    keys = {
      { "<C-p>", "<cmd>MarkdownPreviewToggle<CR>", desc = "Toggle Markdown Preview" },
    },
  },

  -- rainbow_csv
  {
    "mechatroner/rainbow_csv",
    ft = "csv",
  },

  -- direnv.vim
  {
    "direnv/direnv.vim",
    lazy = false,
  },

  -- vim-projectroot
  {
    "dbakker/vim-projectroot",
    lazy = false,
  },
}
