return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPre", "BufNewFile" },
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"bash",
				"comment",
				"css",
				"dockerfile",
				"gitignore",
				"go",
				"haskell",
				"html",
				"javascript",
				"json",
				"lua",
				"markdown",
				"python",
				"regex",
				"rust",
				"scss",
				"sql",
				"toml",
				"tsx",
				"typescript",
				"yaml",
			},
			highlight = { enable = true },
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "+",
					node_incremental = "+",
					node_decremental = "_",
				},
			},
			indent = { enable = true },
		})
	end,
}
