---------------------------------- Aliases ------------------------------------

A = {}

A.augroup = vim.api.nvim_create_augroup
A.autocmd = vim.api.nvim_create_autocmd
A.map = vim.keymap.set
A.opts = {
    n = { noremap = true },
    ns = { noremap = true, silent = true },
}

---------------------------------- Plug-Ins ------------------------------------

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Use a protected call so we don't error out on first use
local status_ok, _ = pcall(require, "lazy")
if not status_ok then
    return
end

require("lazy").setup({
    ---- LSP, Completions, Git, Telescope
    { 'nvim-lua/plenary.nvim' },
    { 'nvim-telescope/telescope.nvim' },
    { 'nvim-telescope/telescope-fzy-native.nvim', run = 'make' },
    { 'fannheyward/telescope-coc.nvim' },
    { 'neoclide/coc.nvim',                        branch = 'release' },
    { 'ahmedkhalf/project.nvim' },
    { 'tpope/vim-fugitive' },

    ---- Theme and Formatting
    { 'folke/tokyonight.nvim' },
    { 'nvim-lualine/lualine.nvim' },
    { 'glepnir/dashboard-nvim' },
    { 'nvim-treesitter/nvim-treesitter',          run = ':TSUpdate' },
    { 'nvim-tree/nvim-tree.lua' },
    { "nvim-tree/nvim-web-devicons" },
    { 'lukas-reineke/indent-blankline.nvim' },

    ---- UI Elements
    { 'mbbill/undotree' },
    { 'akinsho/toggleterm.nvim' },
    { 'gbprod/yanky.nvim' },
    { 'numToStr/Comment.nvim' },
    { 'kylechui/nvim-surround' },
    { 'windwp/nvim-autopairs' },

    ---- Tmux-Vim Integration
    { 'aserowy/tmux.nvim' }
})

---------------------------------- Imports ------------------------------------

require('options')
require('keymaps')
require('setups')
