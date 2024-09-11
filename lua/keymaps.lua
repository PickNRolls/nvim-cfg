vim.keymap.set("n", "<leader>o", "<cmd>Neotree toggle<cr>", { desc = "Neotree toggle" })
vim.keymap.set("n", "<leader>e", "<cmd>Neotree close<cr>", { desc = "Neotree close" })
vim.keymap.set("n", "<c-s>", "<cmd>:w<cr>", { desc = "Save file" })
vim.keymap.set("n", "<leader>c", "<cmd>:q!<cr>", { desc = "Close window" })

vim.keymap.set("n", "<c-h>", "<c-w>h", { desc = "Go left window" })
vim.keymap.set("t", "<c-h>", "<c-\\><c-n><c-w>h", { desc = "Go left window" })
vim.keymap.set("n", "<c-l>", "<c-w>l", { desc = "Go right window" })

local telescope = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", telescope.find_files, { desc = "Find Files" })
vim.keymap.set("n", "<leader>fo", telescope.oldfiles, { desc = "Find Recent Files" })
vim.keymap.set("n", "<leader>fw", telescope.live_grep, { desc = "Find Live Grep" })

vim.keymap.set("n", "<leader>li", "<cmd>LspInfo<cr>", {
  desc = "Lsp info",
})
vim.keymap.set("n", "<leader>lf", function()
  vim.lsp.buf.format()
end, {
  desc = "Format buffer",
})

vim.keymap.set("n", "gd", function()
  telescope.lsp_definitions()
end, { desc = "Go to definition" })

vim.keymap.set(
  "n",
  "<leader>tv",
  "<cmd>ToggleTerm direction=vertical size=70<cr>",
  { desc = "Toggle vertical terminal" }
)

vim.keymap.set("n", "<leader>lr", function()
  telescope.lsp_references()
end, { desc = "Show LSP References" })

local ls = require("luasnip")
vim.keymap.set({ "s" }, "<tab>", function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end, { silent = true, noremap = true })
-- Не знаю как замапить через lua, при этом не сломав tab в insert mode
vim.cmd("imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'")

vim.keymap.set({ "i", "s" }, "<s-tab>", function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end, { silent = true, noremap = true })

vim.keymap.set({ "i", "s" }, "<c-e>", function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end, { silent = true })
