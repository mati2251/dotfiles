return {
  "francoiscabrol/ranger.vim",
  dependencies = {
    "rbgrouleff/bclose.vim"
  },
  config = function()
    vim.keymap.set("n", "<C-r>", ":Ranger<cr>", {})
  end
}
