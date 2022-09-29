---------------------------------- Aliases ------------------------------------

Augroup = vim.api.nvim_create_augroup
Autocmd = vim.api.nvim_create_autocmd
Map = vim.keymap.set
Opts = {
    n = { noremap = true },
    s = { noremap = true, silent = true },
}

---------------------------------- Imports ------------------------------------

require('proton.keymaps')
require('proton.options')
require('proton.plugins')
require('proton.setups')
require('proton.theme')
