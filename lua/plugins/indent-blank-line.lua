return {
	"lukas-reineke/indent-blankline.nvim",
	event = { "BufReadPre", "BufNewFile" },
	main = "ibl",
	config = function()
		local hooks = require("ibl.hooks")
		hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
		require("ibl").setup({
			indent = { char = "▏" },
			scope = { enabled = false },
			exclude = {
				filetypes = { "dashboard", "haskell", "help", "python", "undotree" },
				buftypes = { "nofile", "terminal" },
			},
		})
	end,
}
