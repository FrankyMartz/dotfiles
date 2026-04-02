return {
  -- nvim-cmp: completion engine (replaces CoC completion)
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      {
        "L3MON4D3/LuaSnip",
        dependencies = { "rafamadriz/friendly-snippets" },
        config = function()
          require("luasnip.loaders.from_vscode").lazy_load()
          local luasnip = require("luasnip")
          luasnip.filetype_extend("javascriptreact", { "javascript", "html", "xml" })
          luasnip.filetype_extend("typescriptreact", { "javascript", "html", "xml" })
          luasnip.filetype_extend("typescript", { "javascript" })
        end,
      },
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        preselect = cmp.PreselectMode.Item,
        mapping = cmp.mapping.preset.insert({
          -- Tab/S-Tab: navigate menu or snippet jump (CoC: Tab/S-Tab)
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
          -- CR: confirm selection (CoC: CR confirm)
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          -- C-Space: trigger completion (CoC: c-space refresh)
          ["<C-Space>"] = cmp.mapping.complete(),
          -- C-f/C-b: scroll docs (CoC: C-f/C-b scroll float)
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          -- C-l: expand or jump snippet (CoC: C-l snippet expand)
          ["<C-l>"] = cmp.mapping(function(fallback)
            if luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          -- C-j/C-k: snippet jump next/prev (CoC: C-j/C-k snippet nav)
          ["<C-j>"] = cmp.mapping(function(fallback)
            if luasnip.jumpable(1) then
              luasnip.jump(1)
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<C-k>"] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
          -- C-c: close/abort (CoC: C-c escape)
          ["<C-c>"] = cmp.mapping.abort(),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }, {
          { name = "buffer" },
          { name = "path" },
        }),
        formatting = {
          format = function(entry, vim_item)
            local source_labels = {
              nvim_lsp = "[LSP]",
              luasnip = "[Snip]",
              buffer = "[Buf]",
              path = "[Path]",
            }
            vim_item.menu = source_labels[entry.source.name] or ""
            return vim_item
          end,
        },
      })
    end,
  },
}
