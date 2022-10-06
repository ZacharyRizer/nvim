local A = require('utils.aliases')

vim.opt.clipboard = "unnamedplus"
vim.opt.completeopt = { "menuone", "noinsert", "noselect" }
vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.hidden = true
vim.opt.ignorecase = true
vim.opt.inccommand = "nosplit"
vim.opt.lazyredraw = true
vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.pumblend = 15
vim.opt.relativenumber = true
vim.opt.scrolloff = 10
vim.opt.shiftwidth = 2
vim.opt.shortmess:append("cI")
vim.opt.showmode = false
vim.opt.sidescrolloff = 10
vim.opt.signcolumn = "yes"
vim.opt.smartcase = true
vim.opt.softtabstop = 2
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.swapfile = false
vim.opt.tabstop = 2
vim.opt.termguicolors = true
vim.opt.timeoutlen = 250
vim.opt.updatetime = 100
vim.opt.undofile = true
vim.opt.wildignorecase = true
vim.opt.wildmode = "longest:full,full"
vim.opt.wrap = false
vim.opt.writebackup = false

local formating = A.augroup("Formating", { clear = true })
A.autocmd("BufEnter", {
    pattern = "*",
    command = "setlocal fo-=c fo-=r fo-=o",
    group = formating
})
A.autocmd("BufWritePre", {
    pattern = "*",
    command = "%s/\\s\\+$//e",
    group = formating
})
A.autocmd({ "CursorHold, CursorHoldI" }, {
    pattern = "*",
    command = "checktime",
    group = formating
})
A.autocmd("FileType", {
    pattern = { "go", "haskell", "lua", "python", "yaml" },
    command = "setlocal shiftwidth=4 softtabstop=4 tabstop=4",
    group = formating
})
A.autocmd("VimResized", {
    pattern = "*",
    command = ":wincmd =",
    group = formating
})

-- cursorline is only active in current buffer
local group = vim.api.nvim_create_augroup("CursorLineControl", { clear = true })
local set_cursorline = function(event, value, pattern)
    vim.api.nvim_create_autocmd(event, {
        group = group,
        pattern = pattern,
        callback = function()
            vim.opt_local.cursorline = value
        end,
    })
end
set_cursorline("WinLeave", false)
set_cursorline("WinEnter", true)
set_cursorline("FileType", false, "TelescopePrompt")
