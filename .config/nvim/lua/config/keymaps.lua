vim.keymap.set("n", "-", "<cmd>Oil --float<CR>", { desc = "Go to Parent Directory" })
vim.keymap.set("n", "lg", function()
	vim.diagnostic.open_float()
end, { desc = "View Diagnostic" })

-- clear search highlights --
vim.keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })
vim.keymap.set("n", "<Esc>", ":nohlsearch<CR>")
vim.keymap.set("n", "<leader>h", ":nohlsearch<CR>")

-- formatter --
vim.keymap.set("n", "<leader>cf", function()
	require("conform").format({ lsp_format = "fallback" })
end, { desc = "format code" })
