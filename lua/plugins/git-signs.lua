return {
    'lewis6991/gitsigns.nvim',
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        require('gitsigns').setup({
            on_attach = function()
                local gs = package.loaded.gitsigns
                A.map('n', ']c', function()
                    if vim.wo.diff then return ']c' end
                    vim.schedule(function() gs.next_hunk() end)
                    return '<Ignore>'
                end, { expr = true })
                A.map('n', '[c', function()
                    if vim.wo.diff then return '[c' end
                    vim.schedule(function() gs.prev_hunk() end)
                    return '<Ignore>'
                end, { expr = true })
                A.map('n', 'gc', gs.preview_hunk)
                A.map('n', 'gb', function() gs.blame_line { full = true } end)
            end
        })
    end

}
