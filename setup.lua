----------------------------------------------------------------------------- ==>
-------------------------------- Plug-Ins ----------------------------------- ==>
----------------------------------------------------------------------------- ==>

----------------------------------------------------------------------------- ==>
---------------------------- General Settings ------------------------------- ==>
----------------------------------------------------------------------------- ==>

-- global
vim.o.clipboard = "unnamedplus"
vim.o.cmdheight = 2
vim.o.completeopt = { "menuone", "noinsert", "noselect" }
vim.o.hidden = true
vim.o.ignorecase = true
vim.o.inccommand = "nosplit"
vim.o.lazyredraw = true
vim.o.mouse = "a"
vim.o.pumblend = 15
vim.o.scrolloff = 10
vim.o.showmode = false
vim.o.sidescrolloff = 10
vim.o.smartcase = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.termguicolors = true
vim.o.timeoutlen = 250
vim.o.updatetime = 100
vim.o.wildignorecase = true
vim.o.wildmode = {"longest:full", "full"}
vim.o.writebackup = false
-- buffer
vim.bo.expandtab = true
vim.bo.shiftwidth = 2
vim.bo.softtabstop = 2
vim.bo.swapfile = false
vim.bo.tabstop = 2
vim.bo.undofile = true
-- window
vim.wo.number_relativenumber = true
vim.wo.signcolumn = true
vim.wo.wrap = false

----------------------------------------------------------------------------- ==>
---------------------------- Basic Key Mappings ----------------------------- ==>
----------------------------------------------------------------------------- ==>

local map = vim.api.nvim_set_keymap
local opts = { noremap = true }

vim.g.mapleader = " "
map('i', '<C-c>', '<ESC>', opts)
map('n', '<C-c>', ':nohl<CR>', opts)
--nnoremap <leader>` :source $MYVIMRC <bar> :redraw <bar> :echo "Config Reloaded!"<CR>
--nnoremap <leader>~ :source $MYVIMRC <bar> :PlugUpdate --sync <bar> split <bar> :PlugClean<CR>

-- unmapping a few keys that annoy me
map('n', 'K', '<nop>', opts)
map('n', 'Q', '<nop>', opts)
map('n', '<SPACE>', '<nop>', opts)
map('n', '<BACKSPACE>', '<nop>', opts)

-- easy word replace, search/replace, and */# searching stay in place
map('n', 'c*', '*Ncgn', opts)
map('n', '*', '*N', opts)
map('n', '#', '#N', opts)
map('v', '*', 'y/\V<C-R>=escape(@",'/\')<CR><CR>N', opts)
map('v', '#', 'y?\V<C-R>=escape(@",'/\')<CR><CR>N', opts)
map('n', '<leader>s', ':%s/', opts)
map('v', '<leader>s', ':s/', opts)

-- more intuitive yanking
map('n', 'Y', 'y$')

-- insert blank lines
map('n', 'OO', 'O<ESC>j')
map('n', 'oo', 'o<ESC>k')

-- better line connection/breaking
map('n', 'J', 'mzJ`z', opts)
map('n', 'K', 'f r<CR>', opts)

-- tab text easily
map('v', '<', '<gv', opts)
map('v', '>', '>gv', opts)
map('n', '<', '<<', opts)
map('n', '>', '>>', opts)

-- easy buffer delete and close
map('n', '<leader>d', ':bd<cr>', opts)
map('n', '<leader>dd', ':bd!<cr>', opts)
map('n', '<leader>wo', ':%bd <bar> e# <bar> normal `" <cr>', opts)


-- quickfix lists
local ToggleQFList = function()
  local nr = vim.cmd.winnr("$")
  if (nr == 1) then
    return 'copen'
  else
    return 'cclose'
  end
end
map('n', '<leader>j', ':cnext<CR>', opts)
map('n', '<leader>k', ':cprev<CR>', opts)
map('n', '<C-q>', ToggleQFList(), opts)

