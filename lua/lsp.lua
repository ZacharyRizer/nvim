return {
    ---- Lsp Config
    {
        'neovim/nvim-lspconfig',
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            local lspconfig = require("lspconfig")
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            local opts = { noremap = true, silent = true }

            local on_attach = function(_, bufnr)
                opts.buffer = bufnr
                A.map("n", "gr", ":Telescope lsp_references<CR>", opts)
                A.map("n", "gd", ":Telescope lsp_definitions<CR>", opts)
                A.map("n", "gi", ":Telescope lsp_implementations<CR>", opts)
                A.map("n", "gt", ":Telescope lsp_type_definitions<CR>", opts)
                A.map("n", "<Leader>la", vim.lsp.buf.code_action, opts)
                A.map("n", "<Leader>ld", ":Telescope diagnostics bufnr=0<CR>", opts)
                A.map("n", '<Leader>ls', ':Telescope treesitter<CR>', opts)
                A.map("n", "<Leader>rn", vim.lsp.buf.rename, opts)
                A.map("n", "[d", vim.diagnostic.goto_prev, opts)
                A.map("n", "]d", vim.diagnostic.goto_next, opts)
                A.map("n", "K", vim.lsp.buf.hover, opts)
            end

            local format_on_save = A.augroup("Format_On_Save", { clear = true })
            A.autocmd("BufWritePost", {
                group = format_on_save,
                pattern = "*",
                callback = function()
                    vim.lsp.buf.format({ async = false })
                    vim.diagnostic.show()
                end,
            })

            -- Styling LSP
            local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
            end

            vim.diagnostic.config({
                float = { border = "rounded" },
                virtual_text = true,
            })
            vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
                vim.lsp.handlers.hover, { border = "rounded" }
            )
            vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
                vim.lsp.handlers.signature_help, { border = "rounded" }
            )

            -- SERVER CONFIGURATIONS
            lspconfig["cssls"].setup({
                capabilities = capabilities,
                on_attach = on_attach,
            })
            lspconfig["html"].setup({
                capabilities = capabilities,
                on_attach = on_attach,
            })
            lspconfig["hls"].setup({
                capabilities = capabilities,
                on_attach = on_attach,
                filetypes = { "hs", "lhs", "haskell", "lhaskell" },
                settings = {
                    haskell = {
                        formattingProvider = "fourmolu"
                    }
                }
            })
            lspconfig["jsonls"].setup({
                capabilities = capabilities,
                on_attach = on_attach,
            })
            lspconfig["lua_ls"].setup({
                capabilities = capabilities,
                on_attach = on_attach,
                settings = {
                    Lua = {
                        diagnostics = { globals = { "vim" } },
                    },
                },
            })
            lspconfig["pyright"].setup({
                capabilities = capabilities,
                on_attach = on_attach,
            })
            lspconfig["rust_analyzer"].setup({
                capabilities = capabilities,
                on_attach = on_attach,
            })
            lspconfig["tsserver"].setup({
                capabilities = capabilities,
                on_attach = on_attach,
            })
        end,
    },
    ---- Mason
    {
        'williamboman/mason.nvim',
        dependencies = {
            'williamboman/mason-lspconfig.nvim'
        },
        config = function()
            require("mason").setup({
                ui = {
                    border = "rounded",
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗",
                    },
                },
            })

            require("mason-lspconfig").setup({
                ensure_installed = {
                    "cssls",
                    "html",
                    "hls",
                    "jsonls",
                    "lua_ls",
                    "pyright",
                    "rust_analyzer",
                    "tsserver",
                },
                automatic_installation = true
            })
        end
    },
    ---- Nvim CMP
    {
        'hrsh7th/nvim-cmp',
        event = { "InsertEnter" },
        dependencies = {
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-nvim-lsp',
        },
        config = function()
            local cmp = require("cmp")
            cmp.setup({
                mapping = cmp.mapping.preset.insert({
                    ['<C-d>'] = cmp.mapping.scroll_docs(4),
                    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                    ['<CR>'] = cmp.mapping({
                        i = function(fallback)
                            if cmp.visible() and cmp.get_active_entry() then
                                cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
                            else
                                fallback()
                            end
                        end,
                        s = cmp.mapping.confirm({ select = true }),
                    }),
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'buffer' },
                }),
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
            })
        end
    }
}
