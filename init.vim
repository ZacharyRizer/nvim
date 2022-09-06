" ---------------------------------------------------------------------------- "
" ------------------------------- Plug-Ins ----------------------------------- "
" ---------------------------------------------------------------------------- "

call plug#begin('~/.vim/plugged')

" LSP, Completions, Git, Telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim', {'do': 'make'}
Plug 'fannheyward/telescope-coc.nvim'
Plug 'ahmedkhalf/project.nvim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Theme and Formatting
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-context'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'nvim-lualine/lualine.nvim'

" UI Elements
Plug 'glepnir/dashboard-nvim'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'mbbill/undotree'
Plug 'akinsho/toggleterm.nvim'
Plug 'ggandor/leap.nvim'
Plug 'gbprod/yanky.nvim'

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
  autocmd CursorHold,CursorHoldI * checktime        " make sure buffer is up to date
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
function Filenames()
  if vim.bo.filetype == dashboard then
    return ''
  else
    return vim.fn.expand('%:p:t')
  end
end

require'lualine'.setup {
  extensions = { 'nvim-tree', 'quickfix'},
  options = {
    disabled_filetypes = { 'undotree' },
  },
  sections = {
    lualine_a = {{'mode', fmt = function(str) return str:sub(1,1) end}},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {Filenames},
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

" Leap
lua require("leap").set_default_keymaps()

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
    width = 37,
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
local Terminal  = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })

function _lazygit_toggle()
  lazygit:toggle()
end

vim.api.nvim_set_keymap("n", "<leader>lg", "<cmd>lua _lazygit_toggle()<CR>", {noremap = true, silent = true})
EOF

" Treesitter setup
lua << EOF
require'treesitter-context'.setup{
  patterns = {
    default = { 'class', 'function', 'method', 'for', 'while', 'if', 'switch', 'case' },
  },
}
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
  indent = { enable = true }
}
EOF

" Undo tree
nnoremap <Leader>u :UndotreeToggle<CR>
let g:undotree_DiffAutoOpen = 0
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_SplitWidth = 37
let g:undotree_WindowLayout = 3

" Vim-Commentary
nnoremap <Leader>/ :Commentary<cr>
vnoremap <Leader>/ :Commentary<cr>

" Vim-RSI
let g:rsi_no_meta = 1

" Yanky
lua << EOF
require("yanky").setup()
vim.keymap.set({"n","x"}, "p", "<Plug>(YankyPutAfter)")
vim.keymap.set({"n","x"}, "P", "<Plug>(YankyPutBefore)")
vim.keymap.set({"n","x"}, "gp", "<Plug>(YankyGPutAfter)")
vim.keymap.set({"n","x"}, "gP", "<Plug>(YankyGPutBefore)")
vim.keymap.set("n", "<c-n>", "<Plug>(YankyCycleForward)")
vim.keymap.set("n", "<c-p>", "<Plug>(YankyCycleBackward)")
EOF

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
  }
}
require('telescope').load_extension('coc')
require('telescope').load_extension('fzy_native')
require('telescope').load_extension('projects')
require("telescope").load_extension("yank_history")
EOF

command! -nargs=0 H lua require('telescope.builtin').help_tags()<cr>
command! -nargs=0 M lua require('telescope.builtin').keymaps()<cr>

nnoremap <Leader>c  <cmd>Telescope commands<cr>
nnoremap <Leader>f  <cmd>Telescope find_files<cr>
nnoremap <Leader>g  <cmd>Telescope live_grep<cr>
nnoremap <Leader>h  <cmd>Telescope buffers<cr>
nnoremap <Leader>la <cmd>Telescope coc file_code_actions<cr>
nnoremap <Leader>lc <cmd>Telescope command_history<cr>
nnoremap <Leader>ld <cmd>Telescope coc diagnostics<cr>
nnoremap <Leader>lh <cmd>Telescope oldfiles<cr>
nnoremap <Leader>ls <cmd>Telescope treesitter<cr>
nnoremap <Leader>m  <cmd>Telescope marks<cr>
nnoremap <Leader>p  <cmd>Telescope projects<cr>
nnoremap <Leader>y  <cmd>Telescope yank_history<cr>

" ---------------------------------------------------------------------------- "
" ------------------------------ COC Config ---------------------------------- "
" ---------------------------------------------------------------------------- "

let g:coc_global_extensions = [
  \ 'coc-angular',
  \ 'coc-css',
  \ 'coc-emmet',
  \ 'coc-git',
  \ 'coc-go',
  \ 'coc-highlight',
  \ 'coc-html',
  \ 'coc-json',
  \ 'coc-marketplace',
  \ 'coc-pairs',
  \ 'coc-prettier',
  \ 'coc-pyright',
  \ 'coc-sumneko-lua',
  \ 'coc-tsserver',
  \ 'coc-vimlsp',
  \]

" basic completion mappings
inoremap <silent><expr> <TAB>  coc#pum#visible() ? coc#pum#next(1) :  CheckBackspace() ? "\<Tab>" :  coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Show documentation
nnoremap <silent>K :call CocActionAsync('doHover')<CR>

" Lsp code navigation.
nnoremap <silent> gd <cmd>Telescope coc definitions<cr>
nnoremap <silent> gi <cmd>Telescope coc implementations<cr>
nnoremap <silent> gr <cmd>Telescope coc references<cr>
nnoremap <silent> gt <cmd>Telescope coc type_definitions<cr>
nmap <Leader>rn  <Plug>(coc-rename)

" Use `[d` and `]d` to navigate diagnostics
nmap <silent> [d <Plug>(coc-diagnostic-prev)
nmap <silent> ]d <Plug>(coc-diagnostic-next)

" coc-git
nmap [g <Plug>(coc-git-prevchunk)
nmap ]g <Plug>(coc-git-nextchunk)
nmap gc <Plug>(coc-git-chunkinfo)

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
  {icon = '    ', desc = 'New File       ', action = 'DashboardNewFile'},
  {icon = '    ', desc = 'Find File      ', action = 'Telescope find_files'},
  {icon = '    ', desc = 'Find Word      ', action = 'Telescope live_grep'},
  {icon = '    ', desc = 'Recent Files   ', action = 'Telescope oldfiles'},
  {icon = '    ', desc = 'Recent Projects', action = 'Telescope projects'},
  {icon = '    ', desc = 'Config         ', action = 'e ~/.config/nvim/init.vim'},
}
db.custom_footer = {}
db.hide_statusline = false
db.session_directory = '~/.local/share/nvim/session'
EOF
