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
				python = { "isort", "black" },
				rust = { "rustfmt" },
				scss = { "prettier" },
				typescript = { "prettier" },
				typescriptreact = { "prettier" },
			},
		})
		A.map("n", "<Leader><Enter>", function()
			conform.format({
				lsp_fallback = true,
				async = true,
			})
		end)
	end,
}
