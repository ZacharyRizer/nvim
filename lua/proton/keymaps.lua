local A = require('utils.aliases')

vim.g.mapleader = " "
A.map('i', '<C-c>', '<ESC>', A.opts.s)
A.map('n', '<C-c>', ':nohl<CR>', A.opts.s)
A.map('t', '<C-[>', '<C-\\><C-n>', A.opts.s)

---- unmapping a few keys that annoy me
A.map('n', 'K', '<nop>', A.opts.s)
A.map('n', 'Q', '<nop>', A.opts.s)
A.map('n', '<Space>', '<nop>', A.opts.s)
A.map('n', '<BS>', '<nop>', A.opts.s)

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
A.map('n', '<Leader>s', ':%s/', A.opts.n)
A.map('v', '<Leader>s', ':s/\\%V', A.opts.n)

---- more intuitive yanking
A.map('n', 'Y', 'y$', A.opts.s)

---- better line connection
A.map('n', 'J', 'mzJ`z', A.opts.s)

---- move/tab text easily
A.map('v', '<', '<gv', A.opts.s)
A.map('v', '>', '>gv', A.opts.s)
A.map('n', '<', '<<', A.opts.s)
A.map('n', '>', '>>', A.opts.s)

---- easy buffer delete and close
A.map('n', '<Leader>d', ':bd<cr>', A.opts.s)
A.map('n', '<Leader>D', ':bd!<cr>', A.opts.s)
A.map('n', '<Leader>wo', ':%bd | e# | normal `--<cr>', A.opts.s)

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

A.map('n', ']q', ':cnext<CR>', A.opts.s)
A.map('n', '[q', ':cprev<CR>', A.opts.s)
A.map('n', '<C-q>', ':call QuickFixToggle()<CR>', A.opts.s)
