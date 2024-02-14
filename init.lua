---------------------------------- Aliases ------------------------------------

A = {}
A.augroup = vim.api.nvim_create_augroup
A.autocmd = vim.api.nvim_create_autocmd
A.del = vim.keymap.del
A.map = vim.keymap.set

--------------------------------- Core Setup -----------------------------------

require("options")
require("keymaps")

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

local lazy_configuration = {
    change_detection = { notify = false },
    install = { colorscheme = { "tokyonight" } },
    ui = { border = "rounded" },
}

require("lazy").setup("plugins", lazy_configuration)
