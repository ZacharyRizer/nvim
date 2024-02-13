return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lspconfig = require("lspconfig")
		local capabilities = require("cmp_nvim_lsp").default_capabilities()
		local opts = A.opts

		A.autocmd("LspAttach", {

			group = A.augroup("Lsp_Custom_Attach", { clear = true }),
			callback = function(_, bufnr)
				opts.buffer = bufnr
				A.map("n", "gr", ":Telescope lsp_references<CR>", opts)
				A.map("n", "gd", ":Telescope lsp_definitions<CR>", opts)
				A.map("n", "gi", ":Telescope lsp_implementations<CR>", opts)
				A.map("n", "gt", ":Telescope lsp_type_definitions<CR>", opts)
				A.map("n", "<Leader>la", vim.lsp.buf.code_action, opts)
				A.map("n", "<Leader>ld", ":Telescope diagnostics bufnr=0<CR>", opts)
				A.map("n", "<Leader>ls", ":Telescope treesitter<CR>", opts)
				A.map("n", "<Leader>rn", vim.lsp.buf.rename, opts)
				A.map("n", "[d", vim.diagnostic.goto_prev, opts)
				A.map("n", "]d", vim.diagnostic.goto_next, opts)
				A.map("n", "K", vim.lsp.buf.hover, opts)
			end,
		})

		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		vim.diagnostic.config({
			float = { border = "rounded" },
			virtual_text = true,
		})
		vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
		vim.lsp.handlers["textDocument/signatureHelp"] =
			vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

		--------------- SERVER CONFIGURATIONS ---------------
		lspconfig["cssls"].setup({ capabilities = capabilities })
		lspconfig["html"].setup({ capabilities = capabilities })
		lspconfig["hls"].setup({ capabilities = capabilities })
		lspconfig["jsonls"].setup({ capabilities = capabilities })
		lspconfig["lua_ls"].setup({
			capabilities = capabilities,
			settings = {
				Lua = {
					diagnostics = { globals = { "vim" } },
				},
			},
		})
		lspconfig["pyright"].setup({ capabilities = capabilities })
		lspconfig["rust_analyzer"].setup({ capabilities = capabilities })
		lspconfig["tsserver"].setup({ capabilities = capabilities })
	end,
}
