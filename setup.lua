----------------------------------------------------------------------------- ==>
-------------------------------- Aliases ------------------------------------ ==>
----------------------------------------------------------------------------- ==>

local map = vim.api.nvim_set_keymap
local opts = { noremap = true }
local opts_silent = { noremap = true, silent = true }
local Plug = vim.fn['plug#']

----------------------------------------------------------------------------- ==>
-------------------------------- Plug-Ins ----------------------------------- ==>
----------------------------------------------------------------------------- ==>

vim.call('plug#begin', '~/.vim/plugged')

-- LSP, Completions, Git, Telescope
Plug('nvim-lua/popup.nvim')
Plug('nvim-lua/plenary.nvim')
Plug('nvim-telescope/telescope.nvim')
Plug('nvim-telescope/telescope-fzy-native.nvim', {['do'] = 'make'})
Plug('nvim-telescope/telescope-file-browser.nvim')
Plug('fannheyward/telescope-coc.nvim')
Plug('ahmedkhalf/project.nvim')
Plug('neoclide/coc.nvim', {branch = 'release'})
Plug('lewis6991/gitsigns.nvim')

-- Theme and Formatting
Plug('nvim-treesitter/nvim-treesitter', {['do'] = ':TSUpdate'})
Plug('kyazdani42/nvim-web-devicons')
Plug('lukas-reineke/indent-blankline.nvim')
Plug('windwp/nvim-autopairs')
Plug('norcalli/nvim-colorizer.lua')
Plug('folke/tokyonight.nvim', {branch = 'main'})

-- UI Elements
Plug('glepnir/dashboard-nvim')
Plug('kyazdani42/nvim-tree.lua')
Plug('nvim-lualine/lualine.nvim')
Plug('mbbill/undotree')
Plug('akinsho/toggleterm.nvim')
Plug('ggandor/lightspeed.nvim')
Plug('ZacharyRizer/vim-yankstack')

-- Tpope Plugins
Plug('tpope/vim-commentary')
Plug('tpope/vim-fugitive')
Plug('tpope/vim-repeat')
Plug('tpope/vim-rsi')
Plug('ZacharyRizer/vim-surround')

-- Tmux-Vim integration
Plug('christoomey/vim-tmux-navigator')
Plug('RyanMillerC/better-vim-tmux-resizer')

vim.call('plug#end')
vim.call('yankstack#setup')

----------------------------------------------------------------------------- ==>
---------------------------- General Settings ------------------------------- ==>
----------------------------------------------------------------------------- ==>

-- global
vim.o.clipboard = "unnamedplus"
vim.o.cmdheight = 2
vim.o.completeopt = "menuone,noinsert,noselect"
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
vim.o.wildmode = "longest:full,full"
vim.o.writebackup = false
-- buffer
vim.bo.expandtab = true
vim.bo.shiftwidth = 2
vim.bo.softtabstop = 2
vim.bo.swapfile = false
vim.bo.tabstop = 2
vim.bo.undofile = true
-- window
vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.signcolumn = "yes"
vim.wo.wrap = false

vim.opt.shortmess:append("c")

vim.cmd [[
  augroup FILE_SPECIFICS
    autocmd!
    autocmd FileType go setlocal shiftwidth=4 softtabstop=4 tabstop=4
    autocmd FileType python setlocal shiftwidth=4 softtabstop 4 tabstop=4
  augroup END

  augroup FORMAT_OPTIONS
    autocmd!
    autocmd BufEnter * set fo-=c fo-=r fo-=o
    autocmd BufWritePre * %s/\s\+$//e
    autocmd VimResized * :wincmd =
  augroup END

  augroup HIGHLIGHT_YANK
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 350})
  augroup END
]]

----------------------------------------------------------------------------- ==>
---------------------------- Basic Key Mappings ----------------------------- ==>
----------------------------------------------------------------------------- ==>

vim.g.mapleader = " "
map('i', '<C-c>', '<ESC>', opts)
map('n', '<C-c>', ':nohl<CR>', opts)
--nnoremap <leader>` :source $MYVIMRC <bar> :redraw <bar> :echo "Config Reloaded!"<CR>
--nnoremap <leader>~ :source $MYVIMRC <bar> :PlugUpdate --sync <bar> split <bar> :PlugClean<CR>

-- unmapping a few keys that annoy me
map('n', 'K', '<nop>', opts)
map('n', 'Q', '<nop>', opts)
map('n', '<Space>', '<nop>', opts)
map('n', '<BS>', '<nop>', opts)

-- easy word replace, search/replace, and */# searching stay in place
map('n', 'c*', '*Ncgn', opts)
map('n', '*', '*N', opts)
map('n', '#', '#N', opts)
map('v', '*', 'y/<C-R>"<CR>N', opts)
map('v', '#', 'y?<C-R>"<CR>N', opts)
map('n', '<Leader>s', ':%s/', opts)
map('v', '<Leader>s', ':s/', opts)

-- more intuitive yanking
map('n', 'Y', 'y$', {})

-- insert blank lines
map('n', 'OO', 'O<Esc>j', {})
map('n', 'oo', 'o<Esc>k', {})

-- better line connection/breaking
map('n', 'J', 'mzJ`z', opts)
map('n', 'K', 'f r<CR>', opts)

-- tab text easily
map('v', '<', '<gv', opts)
map('v', '>', '>gv', opts)
map('n', '<', '<<', opts)
map('n', '>', '>>', opts)

-- easy buffer delete and close
map('n', '<Leader>d', ':bd<cr>', opts)
map('n', '<Leader>dd', ':bd!<cr>', opts)
map('n', '<Leader>wo', ':%bd <bar> e# <bar> normal `--<cr>', opts)


-- quickfix lists
map('n', '<Leader>j', ':cnext<CR>', opts)
map('n', '<Leader>k', ':cprev<CR>', opts)
map('n', '<C-q>', 'call ToggleQFList()', opts)
vim.cmd[[
  fun! ToggleQFList()
    let l:nr =  winnr("$")
    if l:nr == 1
      copen
    else
      cclose
    endif
  endfun
]]

----------------------------------------------------------------------------- ==>
---------------------------- Theme & Statusline ----------------------------- ==>
----------------------------------------------------------------------------- ==>

-- Lualine
require'lualine'.setup {
  extensions = {'nvim-tree', 'quickfix'},
  options = {
    disabled_filetypes = {'dashboard', 'undotree'},
  },
  sections = {
    lualine_a = {{'mode', fmt = function(str) return str:sub(1,1) end}},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {{'g:coc_status', cond = function() return vim.fn.winwidth(0) > 90 end}},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
}

-- Tokyonight
vim.g.tokyonight_sidebars = { "NvimTree", "undotree" }
vim.g.tokyonight_lualine_bold = true
vim.g.tokyonight_dark_float = false
vim.cmd[[colorscheme tokyonight]]

----------------------------------------------------------------------------- ==>
------------------------------  Plugin Settings ----------------------------- ==>
----------------------------------------------------------------------------- ==>

-- Autopairs
require('nvim-autopairs').setup({ fast_wrap = {} })

-- Colorizer
require'colorizer'.setup()

-- Gitsigns
require('gitsigns').setup {
  signs = {
    add          = {hl = 'GitSignsAdd'   , text = '+', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
    change       = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    delete       = {hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    topdelete    = {hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    changedelete = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
  },
  keymaps = {
    noremap = true,
    ['n ]g'] = { expr = true, "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'"},
    ['n [g'] = { expr = true, "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'"},
    ['n gs'] = '<cmd>Gitsigns preview_hunk<CR>',
    ['n gb'] = '<cmd>Gitsigns blame_line<CR>',
  },
}

-- IndentLine
require("indent_blankline").setup{
  char = '▏',
  use_treesitter = true,
  show_first_indent_level = false,
  filetype_exclude = {'dashboard', 'help', 'undotree'},
  buftype_exclude = {'nofile', 'terminal'}
}

-- NvimTree setup
map('n', '<C-e>', ':NvimTreeToggle<CR>', {})
vim.gnvim_tree_quit_on_open = true
vim.gnvim_tree_indent_markers = true
vim.gnvim_tree_respect_buf_cwd = true
local tree_cb = require'nvim-tree.config'.nvim_tree_callback
require'nvim-tree'.setup {
  auto_close          = true,
  update_cwd          = true,
  update_to_buf_dir   = { enable = true, auto_open = true },
  update_focused_file = { enable = true, update_cwd = true },
  view = {
    width = 35,
    side = 'right',
    mappings = {
      custom_only = false,
      list = {
        { key = {"l", "<CR>"},  cb = tree_cb("edit") },
        { key = "h",            cb = tree_cb("close_node") },
        { key = "<BS>",         cb = tree_cb("dir_up") },
        { key = "?",            cb = tree_cb("toggle_help") },
      }
    },
  },
}

-- ProjectNvim
require('project_nvim').setup()

-- ToggleTerm
require("toggleterm").setup{
  open_mapping = [[<c-t>]],
  direction = 'float',
  float_opts = { border = 'curved' }
}

-- Treesitter setup
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  highlight = {
    disable = { "vim" },
    enable = true
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "+",
      node_incremental = "+",
      node_decremental = "_",
    },
  },
}

-- Undo tree
map('n', '<Leader>u', ':UndotreeToggle<CR>', opts)
vim.g.undotree_DiffAutoOpen = false
vim.g.undotree_SetFocusWhenToggle = true
vim.g.undotree_SplitWidth = 35
vim.g.undotree_WindowLayout = 3

-- Vim-Commentary
map('n', '<Leader>/', ':Commentary<CR>', opts)
map('v', '<Leader>/', ':Commentary<CR>', opts)

-- Vim-RSI ==> disable meta-key bindings
vim.g.rsi_no_meta = true

-- Yankstack
map('n', '<Leader>p', ':Yanks<CR>', opts)

----------------------------------------------------------------------------- ==>
-------------------------- Telescope Config --------------------------------- ==>
----------------------------------------------------------------------------- ==>

local actions = require('telescope.actions')
require('telescope').setup{
  defaults = {
    entry_prefix = "  ",
    file_ignore_patterns = {"main.js", "%.spec.ts", "%-spec.ts"},
    layout_config = {
      horizontal = {
        preview_cutoff = 150,
        preview_width = 0.45,
        prompt_position = "top"
      },
      width = 0.9
    },
    mappings = {
      i = {
        ["<ESC>"] = actions.close,
        ["<C-t>"] = actions.toggle_selection,
        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-r>"] = actions.delete_buffer,
      },
    },
    path_display = { shorten = 5 },
    prompt_prefix = " ",
    selection_caret = " ",
    sorting_strategy = "ascending",
  },
  extensions = {
    file_browser = { path = "%:p:h" }
  },

}
require('telescope').load_extension('coc')
require("telescope").load_extension('file_browser')
require('telescope').load_extension('fzy_native')
require('telescope').load_extension('projects')

vim.cmd[[command! -nargs=0 H lua require('telescope.builtin').help_tags()<cr>]]
vim.cmd[[command! -nargs=0 M lua require('telescope.builtin').keymaps()<cr>]]

map('n', '<Leader>p', ':Yanks<CR>', opts)
map('n', '<Leader>c', '<cmd>lua require("telescope.builtin").commands()<cr>', opts)
map('n', '<Leader>C', '<cmd>lua require("telescope.builtin").command_history()<cr>', opts)
map('n', '<Leader>e', '<cmd>lua require("telescope").extensions.file_browser.file_browser()<cr>', opts)
map('n', '<Leader>f', '<cmd>lua require("telescope.builtin").find_files()<cr>', opts)
map('n', '<Leader>F', '<cmd>lua require("telescope.builtin").find_files({ cwd = vim.fn.input("Find In Dir: ", "~/")})<cr>', opts)
map('n', '<Leader>g', '<cmd>lua require("telescope.builtin").grep_string({ search = vim.fn.input("Grep > ")})<cr>', opts)
map('n', '<Leader>G', '<cmd>lua require("telescope.builtin").live_grep()<cr>', opts)
map('n', '<Leader>h', '<cmd>lua require("telescope.builtin").buffers()<cr>', opts)
map('n', '<Leader>H', '<cmd>lua require("telescope.builtin").oldfiles()<cr>', opts)
map('n', '<Leader>m', '<cmd>lua require("telescope.builtin").marks()<cr>', opts)

----------------------------------------------------------------------------- ==>
-------------------------------- COC Config --------------------------------- ==>
----------------------------------------------------------------------------- ==>

-- vim.g.coc_global_extensions = {
--   'coc-angular',
--   'coc-css',
--   'coc-emmet',
--   'coc-go',
--   'coc-html',
--   'coc-json',
--   'coc-marketplace',
--   'coc-prettier',
--   'coc-pyright',
--   'coc-sumneko-lua',
--   'coc-tsserver',
--   'coc-vimlsp',
-- }

-- -- Add `:Format` command to format current buffer.
-- vim.cmd[[command! -nargs=0 Format :call CocActionAsync('format')]]

-- -- basic completion mappings
-- map('i', '<expr> <TAB>', vim.cmd[[pumvisible() ? "\<C-n>" : <SID>check_back_space() ? "\<TAB>" : coc#refresh()]], opts_silent)
-- map('i', '<expr> <S-TAB>', vim.cmd[[pumvisible() ? "\<C-p>" : "\<C-h>"]], opts_silent)
-- map('i', '<expr> <CR>', vim.cmd[[pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts_silent)

-- vim.cmd[[
--   fun! s:check_back_space() abort
--     let col = col('.') - 1
--     return !col || getline('.')[col - 1]  =~# '\s'
--   endfun
-- ]]

-- -- Show documentation
-- map('n', 'H', vim.cmd[[:call CocActionAsync('doHover')<CR>]], opts_silent)

-- -- Lsp code navigation.
-- map('n', 'gd', '<cmd>Telescope coc definitions<cr>', opts_silent)
-- map('n', 'gi', '<cmd>Telescope coc implementations<cr>', opts_silent)
-- map('n', 'gr', '<cmd>Telescope coc references<cr>', opts_silent)
-- map('n', 'gt', '<cmd>Telescope coc type_definitions<cr>', opts_silent)
-- map('n', '<Leader>rn', '<Plug>(coc-rename)', opts)
-- map('n', '<Leader>la', '<cmd>Telescope coc file_code_actions<cr>', opts)
-- map('n', '<Leader>ld', '<cmd>Telescope coc diagnostics<cr>', opts)
-- map('n', '<Leader>ls', '<cmd>Telescope coc document_symbols<cr>', opts)

-- -- Use `[d` and `]d` to navigate diagnostics
-- map('n', '[d', '<Plug>(coc-diagnostic-prev)', opts)
-- map('n', ']d', '<Plug>(coc-diagnostic-next)', opts)

----------------------------------------------------------------------------- ==>
---------------------------- Tmux Vim Integration---------------------------- ==>
----------------------------------------------------------------------------- ==>

-- Tmux-Vim navigator
vim.g.tmux_navigator_no_mappings = true
vim.g.tmux_navigator_save_on_switch = true
vim.g.tmux_navigator_disable_when_zoomed = true
-- change windows from any mode
map('n', '<C-h>', ':TmuxNavigateLeft<cr>', opts_silent)
map('n', '<C-j>', ':TmuxNavigateDown<cr>', opts_silent)
map('n', '<C-k>', ':TmuxNavigateUp<cr>', opts_silent)
map('n', '<C-l>', ':TmuxNavigateRight<cr>', opts_silent)
map('i', '<C-h>', '<Esc> :TmuxNavigateLeft<cr>', opts_silent)
map('i', '<C-j>', '<Esc> :TmuxNavigateDown<cr>', opts_silent)
map('i', '<C-k>', '<Esc> :TmuxNavigateUp<cr>', opts_silent)
map('i', '<C-l>', '<Esc> :TmuxNavigateRight<cr>', opts_silent)
map('v', '<C-h>', '<Esc> :TmuxNavigateLeft<cr>', opts_silent)
map('v', '<C-j>', '<Esc> :TmuxNavigateDown<cr>', opts_silent)
map('v', '<C-k>', '<Esc> :TmuxNavigateUp<cr>', opts_silent)
map('v', '<C-l>', '<Esc> :TmuxNavigateRight<cr>', opts_silent)

-- Tmux-Vim Resizer
vim.g.tmux_resizer_no_mappings = true
map('n', '<A-h>', ':TmuxResizeLeft<cr>', opts_silent)
map('n', '<A-j>', ':TmuxResizeDown<cr>', opts_silent)
map('n', '<A-k>', ':TmuxResizeUp<cr>', opts_silent)
map('n', '<A-l>', ':TmuxResizeRight<cr>', opts_silent)

----------------------------------------------------------------------------- ==>
----------------------------- Dashboard Config ------------------------------ ==>
----------------------------------------------------------------------------- ==>

map('n', '<Leader><CR>', ':Dashboard<CR>', {})
vim.g.dashboard_default_executive = 'telescope'
vim.g.dashboard_session_directory = '~/.local/share/nvim/session'

vim.g.dashboard_custom_section = {
  a = { description = { "  Bookmarks          " }, command = "Telescope marks"},
  b = { description = { "  New File           " }, command = "enew"},
  c = { description = { "  Find File          " }, command = "Telescope find_files"},
  d = { description = { "  Find Word          " }, command = "Telescope live_grep"},
  e = { description = { "  Recent Files       " }, command = "Telescope oldfiles"},
  f = { description = { "  Recent Projects    " }, command = "Telescope projects"},
  h = { description = { "  Change Colorscheme " }, command = "Telescope colorscheme"},
}

vim.g.dashboard_custom_header = {
  '',
  '',
  '',
  '',
  '',
  '',
  ' ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗',
  ' ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║',
  ' ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║',
  ' ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║',
  ' ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║',
  ' ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝',
  '',
  '',
  '',
  '',
}
