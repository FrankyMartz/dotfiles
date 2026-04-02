return {
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "G", "Gwrite", "Gread", "Gdiffsplit" },
    keys = {
      { "<leader>?", "<cmd>Git<CR>", desc = "Git status" },
    },
  },
  {
    "junegunn/gv.vim",
    cmd = "GV",
    dependencies = { "tpope/vim-fugitive" },
  },
}
