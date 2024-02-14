return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")
		conform.setup({
			formatters_by_ft = {
				css = { "prettier" },
				haskell = { "fourmolu" },
				html = { "prettier" },
				javascript = { "prettier" },
				javascriptreact = { "prettier" },
				json = { "prettier" },
				lua = { "stylua" },
				markdown = { "prettier" },
				python = { "autopep8" },
				rust = { "rustfmt" },
				scss = { "prettier" },
				toml = { "taplo" },
				typescript = { "prettier" },
				typescriptreact = { "prettier" },
			},
			format_on_save = {
				async = true,
				lsp_fallback = true,
			},
		})
	end,
}
