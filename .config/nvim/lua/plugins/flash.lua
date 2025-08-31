return {
	"folke/flash.nvim",
	event = "VeryLazy",
	---@type Flash.Config
	opts = {
		modes = {
			char = {
				enabled = true,
				jump_labels = true,
				-- runs every time f/t/F/T/;/, are used
				config = function(opts)
					-- Only change behavior when deleting in operator-pending mode
					if vim.v.operator == "d" and vim.fn.mode(true):find("o") then
						opts.autohide = true
						opts.jump_labels = false

						-- IMPORTANT: don't replace the table; mutate it so `groups` stays intact
						opts.highlight = opts.highlight or {}
						opts.highlight.backdrop = false
						opts.highlight.matches = false

						-- disable special ; , actions
						opts.char_actions = function()
							return {}
						end
					end
					-- else: leave opts untouched so Flash uses its defaults
				end,
			},
		},
	},
    -- stylua: ignore
    keys = {
        { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
        { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
        { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
        { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
        { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
        { "f", mode = { "o" }},
    },
}
