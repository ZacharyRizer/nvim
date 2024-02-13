vim.g.mapleader = " "
A.map("i", "<C-c>", "<ESC>")
A.map("n", "<C-c>", ":nohl<CR>")

---- terminal buffer mappings
A.map("t", "<Leader><ESC>", "<C-\\><C-n>")
A.map("t", "<C-h>", "<C-\\><C-N><C-w>h")
A.map("t", "<C-j>", "<C-\\><C-N><C-w>j")
A.map("t", "<C-k>", "<C-\\><C-N><C-w>k")
A.map("t", "<C-l>", "<C-\\><C-N><C-w>l")

---- unmapping a few keys that annoy me
A.map("n", "K", "<nop>")
A.map("n", "Q", "<nop>")
A.map("n", "<Space>", "<nop>")
A.map("n", "<BS>", "<nop>")

---- readline/emacs keys for i and c modes
A.map({ "c", "i" }, "<C-a>", "<Home>")
A.map({ "c", "i" }, "<C-b>", "<Left>")
A.map({ "c", "i" }, "<C-d>", "<Del>")
A.map({ "c", "i" }, "<C-e>", "<End>")
A.map({ "c", "i" }, "<C-f>", "<Right>")
A.map({ "c", "i" }, "<M-BS>", "<C-w>")

---- easy word replace, search/replace, and */# searching stay in place
A.map("n", "c*", "*Ncgn")
A.map("n", "*", "*N")
A.map("n", "#", "#N")
A.map("v", "*", 'y/<C-R>"<CR>N')
A.map("v", "#", 'y?<C-R>"<CR>N')
A.map("n", "<Leader>/", ":%s/")
A.map("v", "<Leader>/", ":s/")

---- more intuitive yanking
A.map("n", "Y", "y$")

---- better line connection
A.map("n", "J", "mzJ`z")

---- move/tab text easily
A.map("v", "<", "<gv")
A.map("v", ">", ">gv")
A.map("n", "<", "<<")
A.map("n", ">", ">>")
A.map("v", "J", ":m '>+1<CR>gv=gv")
A.map("v", "K", ":m '<-2<CR>gv=gv")

---- quickfix lists
vim.cmd([[
  function! QuickFixToggle()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
      copen
    else
      cclose
    endif
  endfunction
]])

A.map("n", "]q", ":cnext<CR>")
A.map("n", "[q", ":cprev<CR>")
A.map("n", "<C-q>", ":call QuickFixToggle()<CR>")
