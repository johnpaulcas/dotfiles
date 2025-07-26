return {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    -- dependencies = { "nvim-tree/nvim-web-devicons" },
    -- or if using mini.icons/mini.nvim
    dependencies = { "echasnovski/mini.icons" },
    opts = {
	winopts = {
	    preview = { 
		layout = "vertical",
		winopts = {
		    winblend = 15,
		    winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
		}
	    }
	}
    },
    keys = {
	{ 
	    "<leader>ff",
	    function() 
		require('fzf-lua').files() 
	    end,
	    desc = "[F]ind [F]iles" 
	},
	{ 
	    "<leader>fg",
	    function() 
		require('fzf-lua').live_grep() 
	    end,
	    desc = "[F]ind [G]rep" 
	},
	{
	    "<leader>fc",
	    function()
		require('fzf-lua').files({ cwd = '~/.dotfiles/.config' })
	    end,
	    desc = "[F]ind [C]onfig"
	},
	{
	    "<leader>fb",
	    function()
		require('fzf-lua').builtin()
	    end,
	    desc = "[F]ind [B]uiltin"
	},
	{
	    "<leader>fh",
	    function()
		require('fzf-lua').helptags()
	    end,
	    desc = "[F]ind [H]elp"
	},
	{
	    "<leader>fw",
	    function()
		require('fzf-lua').grep_cword()
	    end,
	    desc = "[F]ind word"
	},
	{
	    "<leader>fW",
	    function()
		require('fzf-lua').grep_cWORD()
	    end,
	    desc = "[F]ind WORD"
	},
	{
	    "<leader><leader>",
	    function()
		-- Good utilities to works like tab on vscode
		require('fzf-lua').buffers()
	    end,
	    desc = "Find existing buffers"
	},
	{
	    "<leader>/",
	    function()
		require('fzf-lua').lgrep_curbuf()
	    end,
	    desc = "Live grep the current buffer"
	}
    }
}
