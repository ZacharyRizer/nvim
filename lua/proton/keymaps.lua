------------------------------ Basic Key Mappings -----------------------------

vim.g.mapleader = " "
Map('i', '<C-c>', '<ESC>', Opts.s)
Map('n', '<C-c>', ':nohl<CR>', Opts.s)
Map('t', '<C-[>', '<C-\\><C-n>', Opts.s)

---- unmapping a few keys that annoy me
Map('n', 'K', '<nop>', Opts.s)
Map('n', 'Q', '<nop>', Opts.s)
Map('n', '<Space>', '<nop>', Opts.s)
Map('n', '<BS>', '<nop>', Opts.s)

---- readline/emacs keys for i and c modes
Map({ 'c', 'i' }, '<C-a>', '<Home>', Opts.n)
Map({ 'c', 'i' }, '<C-b>', '<Left>', Opts.n)
Map({ 'c', 'i' }, '<C-d>', '<Del>', Opts.n)
Map({ 'c', 'i' }, '<C-e>', '<End>', Opts.n)
Map({ 'c', 'i' }, '<C-f>', '<Right>', Opts.n)
Map({ 'c', 'i' }, '<M-BS>', '<C-w>', Opts.n)

---- easy word replace, search/replace, and */# searching stay in place
Map('n', 'c*', '*Ncgn', Opts.n)
Map('n', '*', '*N', Opts.n)
Map('n', '#', '#N', Opts.n)
Map('v', '*', 'y/<C-R>"<CR>N', Opts.n)
Map('v', '#', 'y?<C-R>"<CR>N', Opts.n)
Map('n', '<Leader>s', ':%s/', Opts.n)
Map('v', '<Leader>s', ':s/\\%V', Opts.n)

---- more intuitive yanking
Map('n', 'Y', 'y$', Opts.s)

---- better line connection
Map('n', 'J', 'mzJ`z', Opts.s)

---- move/tab text easily
Map('v', '<', '<gv', Opts.s)
Map('v', '>', '>gv', Opts.s)
Map('n', '<', '<<', Opts.s)
Map('n', '>', '>>', Opts.s)
Map('v', 'J', ":m '>+1<CR>gv=gv", Opts.s)
Map('v', 'K', ":m '<-2<CR>gv=gv", Opts.s)

---- easy buffer delete and close
Map('n', '<Leader>d', ':bd<cr>', Opts.s)
Map('n', '<Leader>D', ':bd!<cr>', Opts.s)
Map('n', '<Leader>wo', ':%bd | e# | normal `--<cr>', Opts.s)

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

Map('n', ']q', ':cnext<CR>', Opts.s)
Map('n', '[q', ':cprev<CR>', Opts.s)
Map('n', '<C-q>', ':call QuickFixToggle()<CR>', Opts.s)
