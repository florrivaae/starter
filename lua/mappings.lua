require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "<leader>gp", "<cmd>Gitsigns preview_hunk<CR>", { desc = "Preview git hunk" })
map("n", "<leader>gs", "<cmd>Gitsigns stage_hunk<CR>", { desc = "Stage git hunk" })
map("n", "<leader>gr", "<cmd>Gitsigns reset_hunk<CR>", { desc = "Reset git hunk" })
map("n", "<leader>gb", "<cmd>Gitsigns blame<CR>", { desc = "Show current line blame" })
map("t", "<ESC><ESC>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
map("t", "<C-q>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
