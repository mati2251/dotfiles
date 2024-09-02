return {
  "francoiscabrol/ranger.vim",
  dependencies = {
    "rbgrouleff/bclose.vim"
  },
  config = function()
    vim.keymap.set("n", "<Leader>ra", ":Ranger<cr>", {})
  end
}
