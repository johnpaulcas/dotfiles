return {
	"nmac427/guess-indent.nvim",
	config = function()
		require("guess-indent").setup({
			auto_cmd = true, -- run on FileType autocmd
			override_editorconfig = true, -- let .editorconfig take priority
		})
	end,
}
