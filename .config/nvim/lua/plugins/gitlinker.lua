return {
	"ruifm/gitlinker.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		require("gitlinker").setup({
			opts = {
				-- default: opens link in system clipboard
				-- you can map it to open in browser directly
				-- add your customization here
				action_callback = require("gitlinker.actions").open_in_browser,
			},
			callbacks = {
				["github.com"] = require("gitlinker.hosts").get_github_type_url,
				["gitlab.com"] = require("gitlinker.hosts").get_gitlab_type_url,
				["bitbucket.org"] = require("gitlinker.hosts").get_bitbucket_type_url,
			},
		})

		-- optional keymaps
		vim.api.nvim_set_keymap(
			"n",
			"<leader>gy",
			'<cmd>lua require"gitlinker".get_buf_range_url("n")<cr>',
			{ silent = true, noremap = true }
		)

		vim.api.nvim_set_keymap(
			"v",
			"<leader>gy",
			'<cmd>lua require"gitlinker".get_buf_range_url("v")<cr>',
			{ silent = true, noremap = true }
		)
	end,
}
