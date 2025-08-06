vim.keymap.set("n", "-", "<cmd>Oil --float<CR>", { desc = "Go to Parent Directory" })
vim.keymap.set("n", "lg", function()
	vim.diagnostic.open_float()
end, { desc = "View Diagnostic" })

-- clear search highlights --
vim.keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })
vim.keymap.set("n", "<Esc>", ":nohlsearch<CR>")
vim.keymap.set("n", "<leader>h", ":nohlsearch<CR>")

-- Vertical scroll and center
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Verical block search and center
vim.keymap.set("n", "{", "{zz")
vim.keymap.set("n", "}", "}zz")

-- Center screen when searching forward and backward
vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")

-- Center screen when searching for word under cursor
vim.keymap.set("n", "*", "*zz")
vim.keymap.set("n", "#", "#zz")

-- formatter --
vim.keymap.set("n", "<leader>cf", function()
	require("conform").format({ lsp_format = "fallback" })
end, { desc = "format code" })
