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

-- diagnostic and repeat action
local last_diag_jump = nil

-- Jump any diagnostic
vim.keymap.set("n", "]d", function()
	vim.diagnostic.goto_next()
	last_diag_jump = function()
		vim.diagnostic.goto_next()
	end
end, { desc = "Next Diagnostic" })

vim.keymap.set("n", "[d", function()
	vim.diagnostic.goto_prev()
	last_diag_jump = function()
		vim.diagnostic.goto_prev()
	end
end, { desc = "Prev Diagnostic" })

-- Jump only errors
vim.keymap.set("n", "]e", function()
	vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
	last_diag_jump = function()
		vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
	end
end, { desc = "Next Error" })

vim.keymap.set("n", "[e", function()
	vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
	last_diag_jump = function()
		vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
	end
end, { desc = "Prev Error" })

-- Repeat last diagnostic/error jump with `;`
vim.keymap.set("n", ";", function()
	if last_diag_jump then
		last_diag_jump()
	end
end, { desc = "Repeat last diagnostic/error jump" })
