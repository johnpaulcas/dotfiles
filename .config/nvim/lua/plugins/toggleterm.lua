return {
	"akinsho/toggleterm.nvim",
	version = "*",
	event = "VeryLazy",
	opts = {
		-- keep defaults; no global <C-\> mapping
		open_mapping = nil,
	},
	keys = {
		{
			"<leader>gg",
			function()
				_LAZYGIT_TOGGLE()
			end,
			desc = "LazyGit (git root)",
		},
		{ "<leader>tt", "<cmd>ToggleTerm<CR>", desc = "Toggle terminal" }, -- optional
	},
	config = function(_, opts)
		require("toggleterm").setup(opts)

		local Terminal = require("toggleterm.terminal").Terminal

		-- reusable LazyGit instance (opens at repo root of current file)
		local lazygit = Terminal:new({
			cmd = "lazygit",
			dir = "git_dir", -- resolve to repository root
			direction = "float",
			float_opts = { border = "double" },
			hidden = true,
			on_open = function(term)
				vim.cmd("startinsert!") -- enter terminal-mode
				-- close with 'q' from terminal-mode
				vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
				-- also allow 'q' from normal-mode (if you exit terminal-mode)
				vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = term.bufnr, noremap = true, silent = true })
			end,
		})

		function _LAZYGIT_TOGGLE()
			if vim.fn.executable("lazygit") ~= 1 then
				vim.notify("lazygit not found in PATH", vim.log.levels.WARN)
				return
			end
			lazygit:toggle()
		end
	end,
}
