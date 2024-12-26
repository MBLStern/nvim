vim.g.mapleader = " "
vim.keymap.set("n", "<leader>gp", ":e #<CR>")


-- add a quick error check for a go program
vim.keymap.set(
    "n",
    "<leader>ee",
    "oif err != nil {<CR>}<Esc>Oreturn err<Esc>"
)
