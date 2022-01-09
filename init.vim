" --------------------------------------------------------------------------- ==>
" ------------------------------ Plug-Ins ----------------------------------- ==>
" --------------------------------------------------------------------------- ==>

call plug#begin('~/.vim/plugged')

" ==> LSP, Completions, Git, Telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim', {'do': 'make'}
Plug 'nvim-telescope/telescope-file-browser.nvim'
Plug 'fannheyward/telescope-coc.nvim'
Plug 'ahmedkhalf/project.nvim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'lewis6991/gitsigns.nvim'

" ==> Theme and Formatting
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'kyazdani42/nvim-web-devicons'
Plug 'christianchiarulli/nvcode-color-schemes.vim'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'norcalli/nvim-colorizer.lua'

" ==> UI Elements
Plug 'glepnir/dashboard-nvim'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'nvim-lualine/lualine.nvim'
Plug 'mbbill/undotree'
Plug 'akinsho/toggleterm.nvim'
Plug 'ggandor/lightspeed.nvim'
Plug 'ZacharyRizer/vim-yankstack'
" Plug 'yamatsum/nvim-cursorline'

" ==> Tpope Plugins
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-surround'

" ==> Tmux-Vim integration
Plug 'christoomey/vim-tmux-navigator'
Plug 'RyanMillerC/better-vim-tmux-resizer'

call plug#end()
call yankstack#setup()

" --------------------------------------------------------------------------- ==>
" -------------------------- General Settings ------------------------------- ==>
" --------------------------------------------------------------------------- ==>

set clipboard+=unnamedplus                " Copy/Yank work with system clipboard
set cmdheight=2                           " More space for displaying messages
set colorcolumn=1000
set completeopt=menuone,noinsert,noselect " Hanldes how the completion menus function
set expandtab                             " Converts tabs to spaces
set hidden                                " Required to keep multiple buffers open
set ignorecase smartcase                  " Smart searching in regards to case
set inccommand=nosplit                    " Interactive substitution
set lazyredraw                            " Help with screen redraw lag
set mouse=a                               " Enable your mouse
set nobackup noswapfile nowritebackup     " This is recommended by coc
set noerrorbells                          " Stop those annoying bells
set noshowmode                            " Airline takes care of showing modes
set nowrap                                " Display long lines as just one line
set number                                " Line numbers
set pumblend=15                           " Transparency for floating windows
set scrolloff=10                          " 10 lines are above and below cursor
set shortmess+=c                          " Don't pass messages to |ins-completion-menu|.
set sidescrolloff=10                      " Keep 5 columns on either side of the cursor
set signcolumn=yes                        " So error/git diagnostics don't cause a column shift
set shiftwidth=2 softtabstop=2 tabstop=2  " Insert 2 spaces for a tab
set splitbelow splitright                 " Splits will automatically be below and to the right
set syntax=off                            " Treesitter takes care of this
set termguicolors                         " Enable gui colors
set timeoutlen=250                        " By default timeoutlen is 1000 ms
set undodir=~/.vim/undodir                " Creates directory to store undos
set undofile                              " Returns name of undo file
set updatetime=100                        " Faster completion
set wildignorecase                        " Ignore Case in wildmenu
set wildmode=longest:full,full            " Bash like completion in command model
set wildoptions+=pum                      " Wildmenu completion happens in a popup

" augroup CURSORLINE
"     autocmd!
"     autocmd BufWinEnter,FocusGained,VimEnter,WinEnter, * setlocal cursorline
"     autocmd FocusLost,WinLeave * setlocal nocursorline
" augroup END

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

colorscheme nvcode

" --------------------------------------------------------------------------- ==>
" -------------------------- Basic Key Mappings ----------------------------- ==>
" --------------------------------------------------------------------------- ==>

let g:mapleader = " "
inoremap <C-c> <Esc>
nnoremap <C-c> :nohl<CR>
nnoremap <leader>` :source $MYVIMRC <bar> :PlugUpdate --sync <bar> split <bar> :PlugClean<CR>

" unmapping a few keys that annoy me
nnoremap K <nop>
nnoremap Q <nop>
nnoremap <Space> <nop>
nnoremap <Backspace> <nop>

" easy word replace, search/replace, and */# searching stay in place
nnoremap c* *Ncgn
nnoremap *  *N
nnoremap #  #N
vnoremap *  y/\V<C-R>=escape(@",'/\')<CR><CR>N
vnoremap #  y?\V<C-R>=escape(@",'/\')<CR><CR>N
nnoremap <leader>s :%s/
vnoremap <leader>s :s/

" more intuitive yanking
nmap Y y$
vmap y y`>

" insert blank lines
nmap OO O<Esc>j
nmap oo o<Esc>k

" better line connection/breaking
nnoremap J mzJ`z
nnoremap K f r<CR>

" move text easily
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
vnoremap < <gv
vnoremap > >gv
nnoremap < <<
nnoremap > >>

" easy buffer delete and close
nnoremap <leader>d   :bd<cr>
nnoremap <leader>dd  :bd!<cr>
nnoremap <leader>wo  :%bd <bar> e# <bar> normal `" <cr>

" quickfix lists
nnoremap <leader>j :cnext<CR>
nnoremap <leader>k :cprev<CR>
nnoremap <C-q> :call ToggleQFList()<CR>
fun! ToggleQFList()
  let l:nr =  winnr("$")
  if l:nr == 1
    copen
  else
    cclose
  endif
endfun

" --------------------------------------------------------------------------- ==>
" ----------------------------  Plugin Settings ----------------------------- ==>
" --------------------------------------------------------------------------- ==>

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
  filetype_exclude = {'dashboard', 'help', 'startify', 'undotree'},
  buftype_exclude = {'nofile', 'terminal'}
}
EOF

" Lualine setup
lua << EOF
require'lualine'.setup {
  options = {
    disabled_filetypes = {'dashboard', 'NvimTree', 'startify', 'undotree'},
  },
  sections = {
    lualine_a = {{'mode', fmt = function(str) return str:sub(1,1) end}},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'g:coc_status'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  extensions = {'quickfix'}
}
EOF

" NvimTree setup
nmap <C-e> :NvimTreeToggle<CR>
let g:nvim_tree_quit_on_open = 1
let g:nvim_tree_indent_markers = 1
let g:nvim_tree_respect_buf_cwd = 1
lua << EOF
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
  ensure_installed = "maintained",
  highlight = { enable = true },
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
nnoremap <leader>u :UndotreeToggle<CR>
let g:undotree_DiffAutoOpen = 0
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_WindowLayout = 3

" Vim-Commentary
nnoremap <space>/ :Commentary<cr>
vnoremap <space>/ :Commentary<cr>

" Vim-RSI ==> disable meta-key bindings
let g:rsi_no_meta = 1

" Yankstack
nnoremap <leader>p :Yanks<CR>

" --------------------------------------------------------------------------- ==>
" ------------------------ Telescope Config --------------------------------- ==>
" --------------------------------------------------------------------------- ==>

lua << EOF
local actions = require('telescope.actions')
require('telescope').setup{
  defaults = {
    file_ignore_patterns = {"main.js", "*.spec.ts"},
    prompt_prefix = " ",
    selection_caret = " ",
    entry_prefix = "  ",
    extensions = {
      file_browser = { path = "%:p:h" }
    },
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
        ["<esc>"] = actions.close,
        ["<c-t>"] = actions.toggle_selection,
        ["<c-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
        ["<c-j>"] = actions.move_selection_next,
        ["<c-k>"] = actions.move_selection_previous,
      },
    },
    path_display = { shorten = 5 },
    sorting_strategy = "ascending",
  }
}
require('telescope').load_extension('coc')
require("telescope").load_extension('file_browser')
require('telescope').load_extension('fzy_native')
require('telescope').load_extension('projects')
EOF

nnoremap <leader>b <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>c <cmd>lua require('telescope.builtin').commands()<cr>
nnoremap <leader>C <cmd>lua require('telescope.builtin').command_history()<cr>
nnoremap <leader>e <cmd>lua require('telescope').extensions.file_browser.file_browser()<cr>
nnoremap <leader>f <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>F <cmd>lua require('telescope.builtin').find_files({ cwd = vim.fn.input("Find In Dir: ", "~/")})<cr>
nnoremap <leader>g <cmd>lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep > ")})<cr>
nnoremap <leader>G <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>h <cmd>lua require('telescope.builtin').oldfiles()<cr>
nnoremap <leader>H <cmd>lua require('telescope.builtin').help_tags()<cr>
nnoremap <leader>m <cmd>lua require('telescope.builtin').marks()<cr>
nnoremap <leader>M <cmd>lua require('telescope.builtin').keymaps()<cr>

" --------------------------------------------------------------------------- ==>
" ------------------------------ COC Config --------------------------------- ==>
" --------------------------------------------------------------------------- ==>
let g:coc_global_extensions = [
  \ 'coc-angular',
  \ 'coc-css',
  \ 'coc-emmet',
  \ 'coc-go',
  \ 'coc-html',
  \ 'coc-json',
  \ 'coc-lua',
  \ 'coc-marketplace',
  \ 'coc-pairs',
  \ 'coc-prettier',
  \ 'coc-pyright',
  \ 'coc-tsserver',
  \ 'coc-vimlsp',
  \]

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" basic completion mappings
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

fun! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfun

inoremap <silent><expr> <c-space> coc#refresh()

" Show documentation
nnoremap <silent>H :call <SID>show_documentation()<CR>
fun! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfun

" Lsp code navigation.
nmap <silent> gd <cmd>Telescope coc definitions<cr>
nmap <silent> gi <cmd>Telescope coc implementations<cr>
nmap <silent> gr <cmd>Telescope coc references<cr>
nmap <leader>rn  <Plug>(coc-rename)
nnoremap <Leader>la <cmd>Telescope coc file_code_actions<cr>
nnoremap <Leader>ld <cmd>Telescope coc diagnostics<cr>
nnoremap <Leader>ls <cmd>Telescope coc document_symbols<cr>

" Use `[d` and `]d` to navigate diagnostics
nmap <silent> [d <Plug>(coc-diagnostic-prev)
nmap <silent> ]d <Plug>(coc-diagnostic-next)

" CocSearch
nnoremap <C-s> :CocSearch<space>

" coc-pairs
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" --------------------------------------------------------------------------- ==>
" -------------------------- Tmux Vim Integration---------------------------- ==>
" --------------------------------------------------------------------------- ==>

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
" resize windows
nnoremap <silent> <A-h> :TmuxResizeLeft<cr>
nnoremap <silent> <A-j> :TmuxResizeDown<cr>
nnoremap <silent> <A-k> :TmuxResizeUp<cr>
nnoremap <silent> <A-l> :TmuxResizeRight<cr>

" --------------------------------------------------------------------------- ==>
" --------------------------- Dashboard Config ------------------------------ ==>
" --------------------------------------------------------------------------- ==>

nnoremap <Leader><CR> :Dashboard<CR>
let g:dashboard_default_executive = 'telescope'
let g:dashboard_session_directory = '~/.local/share/nvim/session'

let g:dashboard_custom_section={
\ 'a': { 'description': ['  Bookmarks          '], 'command': 'Telescope marks'},
\ 'b': { 'description': ['  New File           '], 'command': 'enew'},
\ 'c': { 'description': ['  Find File          '], 'command': 'Telescope find_files'},
\ 'd': { 'description': ['  Find Word          '], 'command': 'Telescope live_grep'},
\ 'e': { 'description': ['  Recent Files       '], 'command': 'Telescope oldfiles'},
\ 'f': { 'description': ['  Recent Projects    '], 'command': 'Telescope projects'},
\ 'h': { 'description': ['  Change Colorscheme '], 'command': 'Telescope colorscheme'},
\ }

let g:dashboard_custom_header = [
\ '',
\ '',
\ '',
\ '',
\ '',
\ '',
\ ' ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗',
\ ' ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║',
\ ' ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║',
\ ' ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║',
\ ' ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║',
\ ' ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝',
\ '',
\ '',
\ '',
\ '',
\]
