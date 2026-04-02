return {
  -- Mason: manage LSP servers, DAP, linters, formatters
  {
    "mason-org/mason.nvim",
    build = ":MasonUpdate",
    config = function()
      require("mason").setup()
    end,
  },

  -- Mason-lspconfig: bridge mason and lspconfig
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      "mason-org/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "ts_ls",
          "gopls",
          "pyright",
          "rust_analyzer",
          "clangd",
          "lua_ls",
          "cssls",
          "html",
          "jsonls",
          "yamlls",
          "lemminx",
          "graphql",
          "svelte",
          "vue_ls",
          "tailwindcss",
          "sqlls",
          "bashls",
        },
        automatic_installation = true,
      })
    end,
  },

  -- nvim-lspconfig: LSP configuration (replaces CoC)
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
    },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local cmp_nvim_lsp = require("cmp_nvim_lsp")

      -- Diagnostic configuration (mirrors ALE signs and virtual text)
      vim.diagnostic.config({
        virtual_text = {
          prefix = "  ",
        },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "✘",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.HINT] = "",
            [vim.diagnostic.severity.INFO] = "",
          },
        },
        underline = true,
        update_in_insert = false,
        float = {
          border = "rounded",
        },
      })

      -- Shared capabilities (nvim-cmp integration)
      local capabilities = cmp_nvim_lsp.default_capabilities()

      -- LSP keymaps via LspAttach (mirrors CoC keybindings)
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local bufnr = args.buf
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          local opts = { buffer = bufnr, silent = true }

          -- Go-to mappings (CoC: gd, gy, gi, gr)
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, opts)
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
          vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)

          -- Hover (CoC: K)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

          -- Rename (CoC: <leader>rn)
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

          -- Code actions (CoC: <leader>ac, <leader>as, <leader>a, <leader>qf, <leader>cl)
          vim.keymap.set("n", "<leader>ac", vim.lsp.buf.code_action, opts)
          vim.keymap.set("n", "<leader>as", vim.lsp.buf.code_action, opts)
          vim.keymap.set({ "n", "x" }, "<leader>a", vim.lsp.buf.code_action, opts)
          vim.keymap.set("n", "<leader>qf", vim.lsp.buf.code_action, opts)
          vim.keymap.set("n", "<leader>cl", vim.lsp.codelens.run, opts)

          -- Diagnostic navigation (CoC: [g, ]g, <leader>ek, <leader>ej)
          vim.keymap.set("n", "[g", vim.diagnostic.goto_prev, opts)
          vim.keymap.set("n", "]g", vim.diagnostic.goto_next, opts)
          vim.keymap.set("n", "<leader>ek", vim.diagnostic.goto_prev, opts)
          vim.keymap.set("n", "<leader>ej", vim.diagnostic.goto_next, opts)

          -- Document highlight on CursorHold
          if client and client.server_capabilities.documentHighlightProvider then
            local highlight_group = vim.api.nvim_create_augroup("LspDocumentHighlight", { clear = false })
            vim.api.nvim_clear_autocmds({ group = highlight_group, buffer = bufnr })
            vim.api.nvim_create_autocmd("CursorHold", {
              group = highlight_group,
              buffer = bufnr,
              callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd("CursorMoved", {
              group = highlight_group,
              buffer = bufnr,
              callback = vim.lsp.buf.clear_references,
            })
          end

          -- CodeLens refresh on BufEnter/InsertLeave
          if client and client.server_capabilities.codeLensProvider then
            local codelens_group = vim.api.nvim_create_augroup("LspCodeLens", { clear = false })
            vim.api.nvim_clear_autocmds({ group = codelens_group, buffer = bufnr })
            vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave" }, {
              group = codelens_group,
              buffer = bufnr,
              callback = function()
                vim.lsp.codelens.refresh({ bufnr = bufnr })
              end,
            })
          end
        end,
      })

      -- Server configurations using vim.lsp.config (Neovim 0.11+ API)
      -- Simple servers (default config)
      local simple_servers = {
        "gopls", "pyright", "rust_analyzer", "cssls", "html",
        "graphql", "svelte", "vue_ls", "tailwindcss", "sqlls",
        "bashls", "jsonls", "yamlls", "lemminx", "clangd",
      }
      for _, server in ipairs(simple_servers) do
        vim.lsp.config(server, {
          capabilities = capabilities,
        })
      end

      -- ts_ls: TypeScript/JavaScript (mirrors CoC tsserver settings)
      vim.lsp.config("ts_ls", {
        capabilities = capabilities,
        settings = {
          typescript = {
            suggest = {
              autoImports = false,
            },
          },
          javascript = {
            suggest = {
              autoImports = false,
              enabled = false,
            },
            showUnused = true,
          },
          implicitProjectConfiguration = {
            checkJs = true,
          },
          experimentalDecorators = true,
        },
      })

      -- lua_ls: Lua language server (Neovim development)
      vim.lsp.config("lua_ls", {
        capabilities = capabilities,
        settings = {
          Lua = {
            runtime = {
              version = "LuaJIT",
            },
            workspace = {
              checkThirdParty = false,
              library = vim.api.nvim_get_runtime_file("", true),
            },
            diagnostics = {
              globals = { "vim" },
            },
            telemetry = {
              enable = false,
            },
          },
        },
      })

      -- Enable all configured servers
      vim.lsp.enable(simple_servers)
      vim.lsp.enable("ts_ls")
      vim.lsp.enable("lua_ls")

      -- :Format command (CoC: Format)
      vim.api.nvim_create_user_command("Format", function()
        vim.lsp.buf.format({ async = true })
      end, {})

      -- :OR command for organize imports (CoC: OR)
      vim.api.nvim_create_user_command("OR", function()
        vim.lsp.buf.code_action({
          context = { only = { "source.organizeImports" } },
          apply = true,
        })
      end, {})
    end,
  },
}
