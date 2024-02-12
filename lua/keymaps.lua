vim.g.mapleader = " "
A.map('i', '<C-c>', '<ESC>', A.opts)
A.map('n', '<C-c>', ':nohl<CR>', A.opts)

---- terminal buffer mappings
A.map('t', '<Leader><ESC>', '<C-\\><C-n>', A.opts)
A.map('t', '<C-h>', '<C-\\><C-N><C-w>h', A.opts)
A.map('t', '<C-j>', '<C-\\><C-N><C-w>j', A.opts)
A.map('t', '<C-k>', '<C-\\><C-N><C-w>k', A.opts)
A.map('t', '<C-l>', '<C-\\><C-N><C-w>l', A.opts)

---- unmapping a few keys that annoy me
A.map('n', 'K', '<nop>', A.opts)
A.map('n', 'Q', '<nop>', A.opts)
A.map('n', '<Space>', '<nop>', A.opts)
A.map('n', '<BS>', '<nop>', A.opts)

---- readline/emacs keys for i and c modes
A.map({ 'c', 'i' }, '<C-a>', '<Home>', A.opts)
A.map({ 'c', 'i' }, '<C-b>', '<Left>', A.opts)
A.map({ 'c', 'i' }, '<C-d>', '<Del>', A.opts)
A.map({ 'c', 'i' }, '<C-e>', '<End>', A.opts)
A.map({ 'c', 'i' }, '<C-f>', '<Right>', A.opts)
A.map({ 'c', 'i' }, '<M-BS>', '<C-w>', A.opts)

---- easy word replace, search/replace, and */# searching stay in place
A.map('n', 'c*', '*Ncgn', A.opts)
A.map('n', '*', '*N', A.opts)
A.map('n', '#', '#N', A.opts)
A.map('v', '*', 'y/<C-R>"<CR>N', A.opts)
A.map('v', '#', 'y?<C-R>"<CR>N', A.opts)
A.map('n', '<Leader>/', ':%s/', A.opts)
A.map('v', '<Leader>/', ':s/', A.opts)

---- more intuitive yanking
A.map('n', 'Y', 'y$', A.opts)

---- better line connection
A.map('n', 'J', 'mzJ`z', A.opts)

---- move/tab text easily
A.map('v', '<', '<gv', A.opts)
A.map('v', '>', '>gv', A.opts)
A.map('n', '<', '<<', A.opts)
A.map('n', '>', '>>', A.opts)
A.map('v', 'J', ":m '>+1<CR>gv=gv", A.opts)
A.map('v', 'K', ":m '<-2<CR>gv=gv", A.opts)

---- quickfix lists
vim.cmd [[
  function! QuickFixToggle()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
      copen
    else
      cclose
    endif
  endfunction
]]

A.map('n', ']q', ':cnext<CR>', A.opts)
A.map('n', '[q', ':cprev<CR>', A.opts)
A.map('n', '<C-q>', ':call QuickFixToggle()<CR>', A.opts)
