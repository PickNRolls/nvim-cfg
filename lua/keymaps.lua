vim.keymap.set("n", "<leader>o", "<cmd>Neotree toggle<cr>", { desc = "Neotree toggle" })
vim.keymap.set("n", "<leader>e", "<cmd>Neotree close<cr>", { desc = "Neotree close" })
vim.keymap.set("n", "<c-s>", "<cmd>:w<cr>", { desc = "Save file" })

vim.keymap.set("n", "<c-h>", "<c-w>h", { desc = "Go left window" })
vim.keymap.set("t", "<c-h>", "<c-\\><c-n><c-w>h", { desc = "Go left window" })
vim.keymap.set("n", "<c-l>", "<c-w>l", { desc = "Go right window" })

local telescope = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", telescope.find_files, { desc = "Find Files" })
vim.keymap.set("n", "<leader>fo", telescope.oldfiles, { desc = "Find Recent Files" })
vim.keymap.set("n", "<leader>fw", telescope.live_grep, { desc = "Find Live Grep" })
vim.keymap.set("n", "<leader>ft", "<cmd>TodoTelescope cwd=.<cr>", { desc = "Find Todos" })

vim.keymap.set("n", "<leader>li", "<cmd>LspInfo<cr>", {
  desc = "Lsp info",
})

vim.keymap.set("n", "<leader>lf", function()
  vim.lsp.buf.format()
end, {
  desc = "Format buffer",
})

vim.keymap.set("n", "<leader>lR", function()
  telescope.lsp_references()
end, { desc = "Show LSP References" })

vim.keymap.set("n", "<leader>lr", function()
  vim.lsp.buf.rename()
end)

vim.keymap.set("n", "gd", function()
  telescope.lsp_definitions()
end, { desc = "Go to definition" })

vim.keymap.set(
  "n",
  "<leader>tv",
  "<cmd>ToggleTerm direction=vertical size=70<cr>",
  { desc = "Toggle vertical terminal" }
)

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

vim.keymap.set("n", "<tab>", "<cmd>bnext<cr>", { noremap = true })
vim.keymap.set("n", "<s-tab>", "<cmd>bprevious<cr>", { noremap = true })
vim.keymap.set("n", "<leader>c", function()
  -- TODO: may be add fancy confirm ui
  if vim.bo.modified then
    local choice = vim.fn.confirm(("Save changes to %q?"):format(vim.fn.bufname()), "&Yes\n&No\n&Cancel")
    if choice == 1 then -- Yes
      vim.cmd.write()
    end
  end

  vim.cmd("bdelete!")
end, { desc = "Save then Close buffer" })

local neoscroll = require("neoscroll")
local scroll_duration = 75
vim.keymap.set({ "n", "v", "s" }, "<c-u>", function()
  neoscroll.scroll(-vim.wo.scroll, {
    move_cursor = true,
    duration = scroll_duration,
  })
end)
vim.keymap.set({ "n", "v", "s" }, "<c-d>", function()
  neoscroll.scroll(vim.wo.scroll, {
    move_cursor = true,
    duration = scroll_duration,
  })
end)

vim.keymap.set("n", "<leader>pl", "<cmd>Lazy<cr>", { desc = "Open Lazy" })

vim.keymap.set({'n', 'x', 'o'}, 's', '<Plug>(leap)')
