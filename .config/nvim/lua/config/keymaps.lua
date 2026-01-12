-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set({ "n", "v" }, ";", ":", { desc = "Command mode" })
vim.keymap.set({ "n" }, "<CR>", ":w<CR>", { desc = "Save file" })
vim.keymap.set({ "n" }, "<C-p>", function()
  Snacks.picker.smart()
end, { desc = "Open files" })
