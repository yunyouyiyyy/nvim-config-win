-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.g.mapleader = " "
local keymap = vim.keymap

-- ---------- 插入模式 ---------- ---
keymap.set("i", "jk", "<ESC>")

--当前位置打开终端
-- floating terminal
keymap.set("n", "<leader>fT", function()
  Snacks.terminal()
end, { desc = "Terminal (cwd)" })
keymap.set("n", "<leader>ft", function()
  Snacks.terminal(nil, { cwd = LazyVim.root() })
end, { desc = "Terminal (Root Dir)" })
keymap.set("n", "<c-/>", function()
  Snacks.terminal()
end, { desc = "Terminal (cwd)" })
keymap.set("n", "<c-_>", function()
  Snacks.terminal(nil, { cwd = LazyVim.root() })
end, { desc = "which_key_ignore" })

-- Terminal Mappings
keymap.set("t", "<C-/>", "<cmd>close<cr>", { desc = "Hide Terminal" })
keymap.set("t", "<c-_>", "<cmd>close<cr>", { desc = "which_key_ignore" })
