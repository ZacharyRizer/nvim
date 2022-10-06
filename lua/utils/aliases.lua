local A = {}

A.augroup = vim.api.nvim_create_augroup
A.autocmd = vim.api.nvim_create_autocmd
A.map = vim.keymap.set
A.opts = {
    n = { noremap = true },
    s = { noremap = true, silent = true },
}

return A
