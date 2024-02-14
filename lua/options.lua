vim.loader.enable()

vim.opt.backup = false
vim.opt.clipboard = "unnamedplus"
vim.opt.completeopt = { "menu", "menuone", "noselect" }
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
vim.opt.shortmess:append("c")
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

local proton_pack = A.augroup("Proton_Pack", { clear = true })
-- turn off automatic comment formatting
A.autocmd("BufEnter", {
	pattern = "*",
	command = "setlocal fo-=c fo-=r fo-=o",
	group = proton_pack,
})
-- check for file changes
A.autocmd({ "BufEnter", "FocusGained" }, {
	pattern = "*",
	command = "checktime",
	group = proton_pack,
})
-- remove trailing white space on save
A.autocmd("BufWritePre", {
	pattern = "*",
	command = "%s/\\s\\+$//e",
	group = proton_pack,
})
-- use 4 space tabs for specific languages
A.autocmd("FileType", {
	pattern = { "go", "haskell", "lua", "python", "yaml" },
	command = "setlocal shiftwidth=4 softtabstop=4 tabstop=4",
	group = proton_pack,
})
-- make windows equal sizes when opening/closing
A.autocmd("VimResized", {
	pattern = "*",
	command = ":wincmd =",
	group = proton_pack,
})
-- cursorline is only active in current buffer
local set_cursorline = function(event, value, pattern)
	A.autocmd(event, {
		group = proton_pack,
		pattern = pattern,
		callback = function()
			vim.opt_local.cursorline = value
		end,
	})
end
set_cursorline("WinLeave", false)
set_cursorline("WinEnter", true)
set_cursorline("FileType", false, "TelescopePrompt")
