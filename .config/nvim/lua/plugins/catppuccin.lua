return {
	"catppuccin/nvim",
	name = "catppuccin",
	lazy = false,
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			flavour = "macchiato", -- "macchiato", "frappe", "latte", "mocha"
		})
		vim.cmd("colorscheme catppuccin")
	end,
}
