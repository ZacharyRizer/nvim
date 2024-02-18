return {
    "neoclide/coc.nvim",
    branch = "release",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        vim.g.coc_global_extensions = {
            "coc-css",
            "coc-git",
            "coc-highlight",
            "coc-html",
            "coc-json",
            "coc-lua",
            "coc-marketplace",
            "coc-pairs",
            "coc-prettier",
            "coc-pyright",
            "coc-rust-analyzer",
            "coc-tsserver",
            "coc-toml",
            "coc-yaml"
        }

        vim.cmd([[
                hi CocInlayHint guifg=#565f89

                function! CheckBackspace() abort
                  let col = col('.') - 1
                  return !col || getline('.')[col - 1]  =~# '\s'
                endfunction

                inoremap <silent><expr> <TAB> coc#pum#visible() ? coc#pum#next(1) : CheckBackspace() ? "\<Tab>" : coc#refresh()
                inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
                inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

                nnoremap <silent><nowait><expr> <C-d> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-d>"
                nnoremap <silent><nowait><expr> <C-u> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-u>"
                inoremap <silent><nowait><expr> <C-d> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Del>"
                inoremap <silent><nowait><expr> <C-u> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : ""
            ]])

        A.map("n", "<Leader>th", ":CocCommand document.toggleInlayHint<CR>")
        A.map("n", "<Leader>tl", ":CocCommand document.toggleCodeLens<CR>")

        A.map("n", "K", ":call CocActionAsync('doHover')<CR>")

        A.map("n", "gd", ":Telescope coc definitions<CR>")
        A.map("n", "gi", ":Telescope coc implementations<CR>")
        A.map("n", "gr", ":Telescope coc references<CR>")
        A.map("n", "gt", ":Telescope coc type_definitions<CR>")
        A.map("n", "<Leader>rn", "<Plug>(coc-rename)")

        A.map("n", "<Leader>la", ":Telescope coc file_code_actions<CR>")
        A.map("n", "<Leader>ld", ":Telescope coc diagnostics<CR>")
        A.map("n", "<Leader>ls", ":Telescope treesitter<CR>")

        A.map("n", "[d", "<Plug>(coc-diagnostic-prev)")
        A.map("n", "]d", "<Plug>(coc-diagnostic-next)")

        A.map("n", "[c", "<Plug>(coc-git-prevchunk)")
        A.map("n", "]c", "<Plug>(coc-git-nextchunk)")
        A.map("n", "gc", ":CocCommand git.chunkInfo<cr>")
        A.map("n", "gb", ":CocCommand git.showBlameDoc<cr>")
    end,
}
