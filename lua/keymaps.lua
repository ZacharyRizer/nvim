vim.g.mapleader = " "
A.map('i', '<C-c>', '<ESC>', A.opts.ns)
A.map('n', '<C-c>', ':nohl<CR>', A.opts.ns)

---- terminal buffer mappings
A.map('t', '<Leader><ESC>', '<C-\\><C-n>', A.opts.ns)
A.map('t', '<C-h>', '<C-\\><C-N><C-w>h', A.opts.ns)
A.map('t', '<C-j>', '<C-\\><C-N><C-w>j', A.opts.ns)
A.map('t', '<C-k>', '<C-\\><C-N><C-w>k', A.opts.ns)
A.map('t', '<C-l>', '<C-\\><C-N><C-w>l', A.opts.ns)

---- unmapping a few keys that annoy me
A.map('n', 'K', '<nop>', A.opts.ns)
A.map('n', 'Q', '<nop>', A.opts.ns)
A.map('n', '<Space>', '<nop>', A.opts.ns)
A.map('n', '<BS>', '<nop>', A.opts.ns)

---- readline/emacs keys for i and c modes
A.map({ 'c', 'i' }, '<C-a>', '<Home>', A.opts.n)
A.map({ 'c', 'i' }, '<C-b>', '<Left>', A.opts.n)
A.map({ 'c', 'i' }, '<C-d>', '<Del>', A.opts.n)
A.map({ 'c', 'i' }, '<C-e>', '<End>', A.opts.n)
A.map({ 'c', 'i' }, '<C-f>', '<Right>', A.opts.n)
A.map({ 'c', 'i' }, '<M-BS>', '<C-w>', A.opts.n)

---- easy word replace, search/replace, and */# searching stay in place
A.map('n', 'c*', '*Ncgn', A.opts.n)
A.map('n', '*', '*N', A.opts.n)
A.map('n', '#', '#N', A.opts.n)
A.map('v', '*', 'y/<C-R>"<CR>N', A.opts.n)
A.map('v', '#', 'y?<C-R>"<CR>N', A.opts.n)
A.map('n', '<Leader>/', ':%s/', A.opts.n)
A.map('v', '<Leader>/', ':s/\\%V', A.opts.n)

---- more intuitive yanking
A.map('n', 'Y', 'y$', A.opts.ns)
A.map({ 'n', 'v' }, '<Leader>1', '"a', A.opts.ns)
A.map({ 'n', 'v' }, '<Leader>2', '"b', A.opts.ns)
A.map({ 'n', 'v' }, '<Leader>3', '"c', A.opts.ns)
A.map({ 'n', 'v' }, '<Leader>4', '"d', A.opts.ns)

---- better line connection
A.map('n', 'J', 'mzJ`z', A.opts.ns)

---- move/tab text easily
A.map('v', '<', '<gv', A.opts.ns)
A.map('v', '>', '>gv', A.opts.ns)
A.map('n', '<', '<<', A.opts.ns)
A.map('n', '>', '>>', A.opts.ns)

---- easy buffer delete and close
A.map('n', '<Leader>w', ':bd<cr>', A.opts.ns)
A.map('n', '<Leader>wo', ':%bd | e# | normal `--<cr>', A.opts.ns)

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

A.map('n', ']q', ':cnext<CR>', A.opts.ns)
A.map('n', '[q', ':cprev<CR>', A.opts.ns)
A.map('n', '<C-q>', ':call QuickFixToggle()<CR>', A.opts.ns)
