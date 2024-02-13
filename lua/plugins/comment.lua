return {
	"numToStr/Comment.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("Comment").setup({
			toggler = { line = "<Leader>`", block = "<Leader>~" },
			opleader = { line = "<Leader>`", block = "<Leader>~" },
			mappings = { extra = false, extended = false },
		})
	end,
}
