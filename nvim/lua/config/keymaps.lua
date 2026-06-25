-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = LazyVim.safe_keymap_set

map("n", "<localleader>ta", "<cmd>FloatermNew<cr>", { desc = "Floaterm New" })
map("n", "<A-n>", "<cmd>FloatermPrev<CR>", { desc = "Floaterm Prev" })
map("n", "<A-m>", "<cmd>FloatermNext<CR>", { desc = "Floaterm Next" })
map("n", "<localleader>tt", "<cmd>FloatermToggle<CR>", { desc = "Floaterm Toggle" })
map("t", "<localleader>ta", "<cmd>FloatermNew<cr>", { desc = "Floaterm New" })
map("t", "<A-m>", "<cmd>FloatermNext<CR>", { desc = "Floaterm Next" })
map("t", "<A-n>", "<cmd>FloatermPrev<CR>", { desc = "Floaterm Prev" })
map("t", "<localleader>tt", "<cmd>FloatermToggle<CR>", { desc = "Floaterm Toggle" })
