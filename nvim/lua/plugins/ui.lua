return {
  -- nvim-web-devicons
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
    opts = {
      override_by_extension = {
        mjs = { icon = "", name = "Mjs" },
        cjs = { icon = "", name = "Cjs" },
        csv = { icon = "", name = "Csv" },
        graphql = { icon = "", name = "GraphQL" },
      },
    },
  },

  -- vim-startify
  {
    "mhinz/vim-startify",
    lazy = false,
    init = function()
      vim.g.startify_use_env = 1
      vim.g.startify_change_to_dir = 0
      vim.g.startify_change_to_vcs_root = 1
      vim.g.startify_padding_left = 3

      vim.g.startify_skiplist = {
        "COMMIT_EDITMSG",
        vim.fn.escape(vim.fn.fnamemodify(vim.fn.resolve(vim.env.VIMRUNTIME or ""), ":p"), "\\") .. "doc",
        "bundle/.*/doc",
        "/\\.git/index$",
      }

      vim.g.startify_lists = {
        { type = "files", header = { "     GLOBAL: MRU" } },
        { type = "dir", header = { "     MRU" } },
        { type = "sessions", header = { "   Sessions" } },
        { type = "bookmarks", header = { "   Bookmarks" } },
        { type = "commands", header = { "   Commands" } },
      }

      vim.g.startify_custom_header = {
        "   Web browsers are useless here.",
        " ",
        " ",
        "         ,+++77777++=:,                    +=                      ,,++=7++=,,",
        "       7~?7   +7I77 :,I777  I          77 7+77 7:        ,?777777??~,=+=~I7?,=77 I",
        "   =7I7I~7  ,77: ++:~+7 77=7777 7     +77=7 =7I7     ,I777= 77,:~7 +?7, ~7   ~ 777?",
        "   77+7I 777~,,=7~  ,::7=7: 7 77   77: 7 7 +77,7 I777~+777I=   =:,77,77  77 7,777,",
        "     = 7  ?7 , 7~,~  + 77 ?: :?777 +~77 77? I7777I7I7 777+77   =:, ?7   +7 777?",
        "         77 ~I == ~77= +777 777~: I,+77?  7  7:?7? ?7 7 7 77 ~I   7I,,?7 I77~",
        "          I 7=77~+77+?=:I+~77?     , I 7? 77 7   777~ +7 I+?7  +7~?777,77I",
        "            =77 77= +7 7777         ,7 7?7:,??7     +7    7   77??+ 7777,",
        "                =I, I 7+:77?         +7I7?7777 :             :7 7",
        "                   7I7I?77 ~         +7:77,     ~         +7,::7   7",
        "                  ,7~77?7? ?:         7+:77777,           77 :7777=",
        "                   ?77 +I7+,7         7~  7,+7  ,?       ?7?~?777:",
        "                      I777=7777 ~     77 :  77 =7+,    I77  777",
        "                        +      ~?     , + 7    ,, ~I,  = ? ,",
        "                                       77:I+",
        "                                       ,7",
        "                                        :77",
        "                                           :",
        "   Welcome.",
      }

      vim.cmd([[highlight StartifyHeader ctermfg=111 guifg=#98A8FF]])

      vim.api.nvim_create_augroup("plug_startify", { clear = true })
      vim.api.nvim_create_autocmd("ColorScheme", {
        group = "plug_startify",
        callback = function()
          vim.cmd([[highlight link StartifyHeader Comment]])
        end,
      })
      vim.api.nvim_create_autocmd("User", {
        group = "plug_startify",
        pattern = "Startified",
        callback = function()
          vim.bo.buflisted = true
        end,
      })
    end,
  },

  -- indent-blankline.nvim
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      indent = { char = "\u{00A6}" }, -- ¦
      scope = { enabled = true },
    },
    keys = {
      { "<leader>ti", "<cmd>IBLToggle<CR>", desc = "Toggle indent lines" },
    },
  },

  -- vim-signature
  {
    "kshenoy/vim-signature",
    event = "VeryLazy",
    init = function()
      vim.g.SignatureMarkerTextHLDynamic = 1
      vim.g.SignatureMap = {
        Leader = "m",
        PlaceNextMark = "m,",
        ToggleMarkAtLine = "m.",
        PurgeMarksAtLine = "m-",
        DeleteMark = "<Leader>dm",
        PurgeMarks = "<Leader>m<Space>",
        PurgeMarkers = "<Leader>m<Del>",
        GotoNextLineAlpha = "m']",
        GotoPrevLineAlpha = "m'[",
        GotoNextSpotAlpha = "m`]",
        GotoPrevSpotAlpha = "m`[",
        GotoNextLineByPos = "m]'",
        GotoPrevLineByPos = "m['",
        GotoNextSpotByPos = "m]`",
        GotoPrevSpotByPos = "m[`",
        GotoNextMarker = "m]-",
        GotoPrevMarker = "m[-",
        GotoNextMarkerAny = "m]=",
        GotoPrevMarkerAny = "m[=",
        ListBufferMarks = "<Leader>m/",
        ListBufferMarkers = "<Leader>m?",
      }
    end,
  },

  -- vim-obsession
  {
    "tpope/vim-obsession",
    cmd = "Obsession",
  },
}
