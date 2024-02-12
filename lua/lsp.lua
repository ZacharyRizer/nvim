return {
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
                    { name = 'path' },
                }),
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
            })
        end
    }
    -- 'neoclide/coc.nvim',
    -- branch = 'release',
    -- event = { "BufReadPre", "BufNewFile" },
    -- config = function()
    --     vim.g.coc_global_extensions = {
    --         'coc-css',
    --         'coc-html',
    --         'coc-json',
    --         'coc-lua',
    --         'coc-prettier',
    --         'coc-pyright',
    --         'coc-rust-analyzer',
    --         'coc-tsserver',
    --     }
    --
    --     vim.cmd [[
    --             function! CheckBackspace() abort
    --               let col = col('.') - 1
    --               return !col || getline('.')[col - 1]  =~# '\s'
    --             endfunction
    --
    --             inoremap <silent><expr> <TAB> coc#pum#visible() ? coc#pum#next(1) : CheckBackspace() ? "\<Tab>" : coc#refresh()
    --             inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
    --             inoremap <silent><expr> <CR> coc#pum#visible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
    --
    --             nnoremap <silent><nowait><expr> <C-d> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-d>"
    --             nnoremap <silent><nowait><expr> <C-u> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-u>"
    --             inoremap <silent><nowait><expr> <C-d> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Del>"
    --             inoremap <silent><nowait><expr> <C-u> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : ""
    --         ]]
    --
    --     A.map('n', 'K', ":call CocActionAsync('doHover')<CR>", A.opts.ns)
    --
    --     A.map('n', 'gd', ':Telescope coc definitions<CR>', A.opts.ns)
    --     A.map('n', 'gi', ':Telescope coc implementations<CR>', A.opts.ns)
    --     A.map('n', 'gr', ':Telescope coc references<CR>', A.opts.ns)
    --     A.map('n', 'gt', ':Telescope coc type_definitions<CR>', A.opts.ns)
    --     A.map('n', '<Leader>rn', '<Plug>(coc-rename)')
    --
    --     A.map('n', '<Leader>la', ':Telescope coc file_code_actions<CR>', A.opts.ns)
    --     A.map('n', '<Leader>ld', ':Telescope coc diagnostics<CR>', A.opts.ns)
    --     A.map('n', '<Leader>ls', ':Telescope treesitter<CR>', A.opts.ns)
    --
    --     A.map('n', '[d', '<Plug>(coc-diagnostic-prev)', A.opts.ns)
    --     A.map('n', ']d', '<Plug>(coc-diagnostic-next)', A.opts.ns)
    -- end
}
