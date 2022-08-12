" ---------------------------------------------------------------------------- "
" ------------------------------- Plug-Ins ----------------------------------- "
" ---------------------------------------------------------------------------- "

call plug#begin('~/.vim/plugged')

" LSP, Completions, Git, Telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim', {'do': 'make'}
Plug 'nvim-telescope/telescope-file-browser.nvim'
Plug 'fannheyward/telescope-coc.nvim'
Plug 'ahmedkhalf/project.nvim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'lewis6991/gitsigns.nvim'

" Theme and Formatting
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'kyazdani42/nvim-web-devicons'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'windwp/nvim-autopairs'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }

" UI Elements
Plug 'glepnir/dashboard-nvim'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'nvim-lualine/lualine.nvim'
Plug 'mbbill/undotree'
Plug 'akinsho/toggleterm.nvim'
Plug 'ggandor/lightspeed.nvim'
Plug 'ZacharyRizer/vim-yankstack'

" Tpope Plugins
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rsi'
Plug 'ZacharyRizer/vim-surround'

" Tmux-Vim integration
Plug 'christoomey/vim-tmux-navigator'
Plug 'RyanMillerC/better-vim-tmux-resizer'

call plug#end()
call yankstack#setup()

" ---------------------------------------------------------------------------- "
" --------------------------- General Settings ------------------------------- "
" ---------------------------------------------------------------------------- "

set clipboard+=unnamedplus
set cmdheight=2
set completeopt=menuone,noinsert,noselect
set expandtab
set hidden
set ignorecase
set inccommand=nosplit
set lazyredraw
set mouse=a
set noswapfile
set nowritebackup
set noerrorbells
set noshowmode
set nowrap
set number relativenumber
set pumblend=15
set scrolloff=10
set sidescrolloff=10
set signcolumn=yes
set shiftwidth=2
set shortmess+=c
set smartcase
set softtabstop=2
set splitbelow
set splitright
set tabstop=2
set termguicolors
set timeoutlen=250
set undofile
set updatetime=100
set wildignorecase
set wildmode=longest:full,full

augroup FILE_SPECIFICS
  autocmd!
  autocmd FileType go setlocal shiftwidth=4 softtabstop=4 tabstop=4
  autocmd FileType python setlocal shiftwidth=4 softtabstop 4 tabstop=4
augroup END

augroup FORMAT_OPTIONS
  autocmd!
  autocmd BufEnter * set fo-=c fo-=r fo-=o          " disable auto comment wrap
  autocmd BufWritePre * %s/\s\+$//e                 " remove whitespace on save
  autocmd VimResized * :wincmd =                    " auto resize windows
augroup END

augroup HIGHLIGHT_YANK
  autocmd!
  autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 350})
augroup END

" ---------------------------------------------------------------------------- "
" --------------------------- Basic Key Mappings ----------------------------- "
" ---------------------------------------------------------------------------- "

let g:mapleader = " "
inoremap <C-c> <Esc>
nnoremap <C-c> :nohl<CR>
nnoremap <Leader>` :source $MYVIMRC <bar> :redraw <bar> :echo "Config Reloaded!"<CR>
nnoremap <Leader>~ :source $MYVIMRC <bar> :PlugUpdate --sync <bar> split <bar> :PlugClean<CR>

" unmapping a few keys that annoy me
nnoremap K <nop>
nnoremap Q <nop>
nnoremap <Space> <nop>
nnoremap <BS> <nop>

" easy word replace, search/replace, and */# searching stay in place
nnoremap c* *Ncgn
nnoremap *  *N
nnoremap #  #N
vnoremap *  y/<C-R>"<CR>N
vnoremap #  y?<C-R>"<CR>N
nnoremap <Leader>s :%s/
vnoremap <Leader>s :s/

" more intuitive yanking
nmap Y y$

" insert blank lines
nmap OO O<Esc>j
nmap oo o<Esc>k

" better line connection/breaking
nnoremap J mzJ`z
nnoremap K f r<CR>

" tab text easily
vnoremap < <gv
vnoremap > >gv
nnoremap < <<
nnoremap > >>

" easy buffer delete and close
nnoremap <Leader>d   :bd<cr>
nnoremap <Leader>dd  :bd!<cr>
nnoremap <Leader>wo  :%bd <bar> e# <bar> normal `" <cr>

" quickfix lists
nnoremap <Leader>j :cnext<CR>
nnoremap <Leader>k :cprev<CR>
nnoremap <C-q> :call ToggleQFList()<CR>
fun! ToggleQFList()
  let l:nr =  winnr("$")
  if l:nr == 1
    copen
  else
    cclose
  endif
endfun

" ---------------------------------------------------------------------------- "
" --------------------------- Theme & Statusline ----------------------------- "
" ---------------------------------------------------------------------------- "

" Lualine
lua << EOF
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
EOF

" Tokyonight
let g:tokyonight_sidebars = ["NvimTree", "undotree"]
let g:tokyonight_lualine_bold = 1
let g:tokyonight_dark_float = 0
colorscheme tokyonight

" ---------------------------------------------------------------------------- "
" ----------------------------  Plugin Settings ------------------------------ "
" ---------------------------------------------------------------------------- "

" Autopairs
lua require('nvim-autopairs').setup({ check_ts = true, fast_wrap = {} })

" Colorizer
lua require'colorizer'.setup()

" Gitsigns
lua << EOF
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
EOF

" IndentLine
lua << EOF
require("indent_blankline").setup{
  char = '▏',
  use_treesitter = true,
  show_first_indent_level = false,
  filetype_exclude = {'dashboard', 'help', 'undotree'},
  buftype_exclude = {'nofile', 'terminal'}
}
EOF

" NvimTree setup
nnoremap <C-e> :NvimTreeToggle<CR>
lua << EOF
require'nvim-tree'.setup {
  actions = {
    open_file = { quit_on_open = true },
  },
  renderer = {
    indent_markers = { enable = true }
  },
  respect_buf_cwd = true,
  update_cwd          = true,
  update_focused_file = { enable = true, update_cwd = true },
  view = {
    width = 35,
    side = 'right',
    mappings = {
      custom_only = false,
      list = {
        { key = "<CR>",         action = "edit" },
        { key = "h",            action = "close_node" },
        { key = "l",            action = "open_node" },
        { key = "<BS>",         action = "dir_up" },
        { key = "?",            action = "toggle_help" },
        { key = "<C-e>",        action = "" },
      }
    },
  },
}
EOF

" ProjectNvim
lua require('project_nvim').setup()

" ToggleTerm
lua << EOF
require("toggleterm").setup{
  open_mapping = [[<c-t>]],
  direction = 'float',
  float_opts = { border = 'curved' }
}
EOF

" Treesitter setup
lua << EOF
require'nvim-treesitter.configs'.setup {
  ignore_install = { "phpdoc" },
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
EOF

" Undo tree
nnoremap <Leader>u :UndotreeToggle<CR>
let g:undotree_DiffAutoOpen = 0
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_SplitWidth = 35
let g:undotree_WindowLayout = 3

" Vim-Commentary
nnoremap <Leader>/ :Commentary<cr>
vnoremap <Leader>/ :Commentary<cr>

" Vim-RSI
let g:rsi_no_meta = 1

" Yankstack
nnoremap <Leader>y :Yanks<CR>

" ---------------------------------------------------------------------------- "
" -------------------------- Telescope Config -------------------------------- "
" ---------------------------------------------------------------------------- "

lua << EOF
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
EOF

command! -nargs=0 H lua require('telescope.builtin').help_tags()<cr>
command! -nargs=0 M lua require('telescope.builtin').keymaps()<cr>

nnoremap <Leader>c :Telescope commands<cr>
nnoremap <Leader>C :Telescope command_history<cr>
nnoremap <Leader>e <cmd>lua require('telescope').extensions.file_browser.file_browser()<cr>
nnoremap <Leader>f :Telescope find_files<cr>
nnoremap <Leader>F <cmd>lua require('telescope.builtin').find_files({ cwd = vim.fn.input("Find In Dir: ", "~/")})<cr>
nnoremap <Leader>g <cmd>lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep > ")})<cr>
nnoremap <Leader>G :Telescope live_grep<cr>
nnoremap <Leader>h :Telescope buffers<cr>
nnoremap <Leader>H :Telescope oldfiles<cr>
nnoremap <Leader>m :Telescope marks<cr>
nnoremap <Leader>p :Telescope projects<cr>

" ---------------------------------------------------------------------------- "
" ------------------------------ COC Config ---------------------------------- "
" ---------------------------------------------------------------------------- "

let g:coc_global_extensions = [
  \ 'coc-angular',
  \ 'coc-css',
  \ 'coc-emmet',
  \ 'coc-go',
  \ 'coc-html',
  \ 'coc-json',
  \ 'coc-marketplace',
  \ 'coc-prettier',
  \ 'coc-pyright',
  \ 'coc-sumneko-lua',
  \ 'coc-tsserver',
  \ 'coc-vimlsp',
  \]

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" basic completion mappings
inoremap <silent><expr> <TAB> coc#pum#visible() ? coc#pum#next(1): check_back_space() ? "\<Tab>" : coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

fun! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfun

" Show documentation
nnoremap <silent>K :call CocActionAsync('doHover')<CR>

" Lsp code navigation.
nnoremap <silent> gd <cmd>Telescope coc definitions<cr>
nnoremap <silent> gi <cmd>Telescope coc implementations<cr>
nnoremap <silent> gr <cmd>Telescope coc references<cr>
nnoremap <silent> gt <cmd>Telescope coc type_definitions<cr>
nmap <Leader>rn  <Plug>(coc-rename)

nnoremap <Leader>la <cmd>Telescope coc file_code_actions<cr>
nnoremap <Leader>ld <cmd>Telescope coc diagnostics<cr>
nnoremap <Leader>ls <cmd>Telescope coc document_symbols<cr>

" Use `[d` and `]d` to navigate diagnostics
nmap <silent> [d <Plug>(coc-diagnostic-prev)
nmap <silent> ]d <Plug>(coc-diagnostic-next)

" ---------------------------------------------------------------------------- "
" -------------------------- Tmux Vim Integration ---------------------------- "
" ---------------------------------------------------------------------------- "

" Tmux-Vim navigator
let g:tmux_navigator_no_mappings = 1
let g:tmux_navigator_save_on_switch = 1
let g:tmux_navigator_disable_when_zoomed = 1
" change windows from any mode
nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-j> :TmuxNavigateDown<cr>
nnoremap <silent> <C-k> :TmuxNavigateUp<cr>
nnoremap <silent> <C-l> :TmuxNavigateRight<cr>
inoremap <silent> <C-h> <Esc> :TmuxNavigateLeft<cr>
inoremap <silent> <C-j> <Esc> :TmuxNavigateDown<cr>
inoremap <silent> <C-k> <Esc> :TmuxNavigateUp<cr>
inoremap <silent> <C-l> <Esc> :TmuxNavigateRight<cr>
vnoremap <silent> <C-h> <Esc> :TmuxNavigateLeft<cr>
vnoremap <silent> <C-j> <Esc> :TmuxNavigateDown<cr>
vnoremap <silent> <C-k> <Esc> :TmuxNavigateUp<cr>
vnoremap <silent> <C-l> <Esc> :TmuxNavigateRight<cr>

" Tmux-Vim Resizer
let g:tmux_resizer_no_mappings = 1
nnoremap <silent> <A-h> :TmuxResizeLeft<cr>
nnoremap <silent> <A-j> :TmuxResizeDown<cr>
nnoremap <silent> <A-k> :TmuxResizeUp<cr>
nnoremap <silent> <A-l> :TmuxResizeRight<cr>

" ---------------------------------------------------------------------------- "
" --------------------------- Dashboard Config ------------------------------- "
" ---------------------------------------------------------------------------- "

nnoremap <Leader><CR> :Dashboard<CR>
lua << EOF
local db = require('dashboard')
local header = {
  [[                                                       ]],
  [[                                                       ]],
  [[                                                       ]],
  [[                                                       ]],
  [[                                                       ]],
  [[                                                       ]],
  [[                                                       ]],
  [[                                                       ]],
  [[                                                       ]],
  [[                                                       ]],
  [[                                                       ]],
  [[                                                       ]],
  [[ ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗]],
  [[ ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║]],
  [[ ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║]],
  [[ ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║]],
  [[ ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║]],
  [[ ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝]],
  [[                                                       ]],
  [[                                                       ]],
  [[                                                       ]],
  [[                                                       ]],
  [[                                                       ]],
  [[                                                       ]]
}
db.custom_header = header
db.custom_center = {
  {icon = '  ', desc = 'New File           ', action = 'DashboardNewFile'},
  {icon = '  ', desc = 'Find File          ', action = 'Telescope find_files'},
  {icon = '  ', desc = 'Find Word          ', action = 'Telescope live_grep'},
  {icon = '  ', desc = 'Recent Files       ', action = 'Telescope oldfiles'},
  {icon = '  ', desc = 'Recent Projects    ', action = 'Telescope projects'},
  {icon = '  ', desc = 'Config             ', action = 'e ~/.config/nvim/init.vim'},
}
db.custom_footer = {}
db.session_directory = '~/.local/share/nvim/session'
EOF
"   {icon = '  ', desc = 'Bookmarks          ', action = 'Telescope marks'},
"   {icon = '  ', desc = 'Change Colorscheme ', action = 'Telescope colorscheme'},


