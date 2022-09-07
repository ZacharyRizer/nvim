-------------------------------------------------------------------------------
---------------------------------- Aliases ------------------------------------
-------------------------------------------------------------------------------

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local map = vim.api.nvim_set_keymap
local noremap = { noremap = true }
local noremap_s = { noremap = true, silent = true }

-------------------------------------------------------------------------------
---------------------------------- Plug-Ins -----------------------------------
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
------------------------------ General Settings -------------------------------
-------------------------------------------------------------------------------

vim.opt.clipboard = "unnamedplus"
vim.opt.cmdheight = 2
vim.opt.completeopt = "menuone,noinsert,noselect"
vim.opt.expandtab = true
vim.opt.hidden = true
vim.opt.ignorecase = true
vim.opt.inccommand = "nosplit"
vim.opt.lazyredraw = true
vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.pumblend = 15
vim.opt.relativenumber = true
vim.opt.scrolloff = 10
vim.opt.shiftwidth = 2
vim.opt.shortmess:append("c")
vim.opt.showmode = false
vim.opt.sidescrolloff = 10
vim.opt.signcolumn = "yes"
vim.opt.smartcase = true
vim.opt.softtabstop = 2
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.swapfile = false
vim.opt.tabstop = 2
vim.opt.termguicolors = true
vim.opt.timeoutlen = 250
vim.opt.updatetime = 100
vim.opt.undofile = true
vim.opt.wildignorecase = true
vim.opt.wildmode = "longest:full,full"
vim.opt.wrap = false
vim.opt.writebackup = false

local Formating = augroup("Formating", { clear = false })

autocmd("FileType", {
    pattern = { "go", "haskell", "lua", "python", "yaml" },
    command = "setlocal shiftwidth=4 softtabstop=4 tabstop=4",
    group = Formating
})
autocmd("BufEnter", {
    pattern = "*",
    command = "set fo-=c fo-=r fo-=o",
    group = Formating
})
autocmd("BufWritePre", {
    pattern = "*",
    command = "%s/\\s\\+$//e",
    group = Formating
})
autocmd("VimResized", {
    pattern = "*",
    command = ":wincmd =",
    group = Formating
})

-------------------------------------------------------------------------------
------------------------------ Basic Key Mappings -----------------------------
-------------------------------------------------------------------------------

vim.g.mapleader = " "
map('i', '<C-c>', '<ESC>', noremap)
map('n', '<C-c>', ':nohl<CR>', noremap)

-- unmapping a few keys that annoy me
map('n', 'K', '<nop>', noremap)
map('n', 'Q', '<nop>', noremap)
map('n', '<Space>', '<nop>', noremap)
map('n', '<BS>', '<nop>', noremap)

-- easy word replace, search/replace, and */# searching stay in place
map('n', 'c*', '*Ncgn', noremap)
map('n', '*', '*N', noremap)
map('n', '#', '#N', noremap)
map('v', '*', 'y/<C-R>"<CR>N', noremap)
map('v', '#', 'y?<C-R>"<CR>N', noremap)
map('n', '<Leader>s', ':%s/', noremap)
map('v', '<Leader>s', ':s/', noremap)

-- more intuitive yanking
map('n', 'Y', 'y$', {})

-- better line connection
map('n', 'J', 'mzJ`z', noremap)

-- tab text easily
map('v', '<', '<gv', noremap)
map('v', '>', '>gv', noremap)
map('n', '<', '<<', noremap)
map('n', '>', '>>', noremap)

-- easy buffer delete and close
map('n', '<Leader>d', ':bd<cr>', noremap)
map('n', '<Leader>dd', ':bd!<cr>', noremap)
map('n', '<Leader>wo', ':%bd <bar> e# <bar> normal `--<cr>', noremap)

-- quickfix lists
function ToggleQFList()
    local nr = vim.fn.winnr("$")
    if nr == 1 then
        vim.cmd("copen")
    else
        vim.cmd("cclose")
    end
end

map('n', '<Leader>j', ':cnext<CR>', noremap)
map('n', '<Leader>k', ':cprev<CR>', noremap)
map('n', '<C-q>', '', {
    callback = ToggleQFList
})

-------------------------------------------------------------------------------
------------------------------ Theme & Statusline -----------------------------
-------------------------------------------------------------------------------

-- Lualine
function Filenames()
    if vim.bo.filetype == "dashboard" then
        return ''
    else
        return vim.fn.expand('%:p:t', {}, {})
    end
end

require 'lualine'.setup {
    extensions = { 'nvim-tree', 'quickfix' },
    options = {
        disabled_filetypes = { 'undotree' },
    },
    sections = {
        lualine_a = { { 'mode', fmt = function(str) return str:sub(1, 1) end } },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { Filenames },
        lualine_x = { { 'g:coc_status', cond = function() return vim.fn.winwidth(0) > 90 end } },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
    },
}

-- Tokyonight
vim.g.tokyonight_sidebars = { "NvimTree", "undotree" }
vim.g.tokyonight_lualine_bold = true
vim.g.tokyonight_dark_float = false
vim.cmd("colorscheme tokyonight")

------------------------------------------------------------------------------- ==>
--------------------------------  Plugin Settings ----------------------------- ==>
------------------------------------------------------------------------------- ==>

---- Autopairs
--require('nvim-autopairs').setup({ fast_wrap = {} })

---- Colorizer
--require 'colorizer'.setup()

---- Gitsigns
--require('gitsigns').setup {
--  signs = {
--    add          = { hl = 'GitSignsAdd', text = '+', numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn' },
--    change       = { hl = 'GitSignsChange', text = '~', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
--    delete       = { hl = 'GitSignsDelete', text = '_', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
--    topdelete    = { hl = 'GitSignsDelete', text = '‾', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
--    changedelete = { hl = 'GitSignsChange', text = '~', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
--  },
--  keymaps = {
--    noremap = true,
--    ['n ]g'] = { expr = true, "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'" },
--    ['n [g'] = { expr = true, "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'" },
--    ['n gs'] = '<cmd>Gitsigns preview_hunk<CR>',
--    ['n gb'] = '<cmd>Gitsigns blame_line<CR>',
--  },
--}

---- IndentLine
--require("indent_blankline").setup {
--  char = '▏',
--  use_treesitter = true,
--  show_first_indent_level = false,
--  filetype_exclude = { 'dashboard', 'help', 'undotree' },
--  buftype_exclude = { 'nofile', 'terminal' }
--}

---- NvimTree setup
--map('n', '<C-e>', ':NvimTreeToggle<CR>', {})
--vim.gnvim_tree_quit_on_open = true
--vim.gnvim_tree_indent_markers = true
--vim.gnvim_tree_respect_buf_cwd = true
--local tree_cb = require 'nvim-tree.config'.nvim_tree_callback
--require 'nvim-tree'.setup {
--  auto_close          = true,
--  update_cwd          = true,
--  update_to_buf_dir   = { enable = true, auto_open = true },
--  update_focused_file = { enable = true, update_cwd = true },
--  view                = {
--    width = 35,
--    side = 'right',
--    mappings = {
--      custom_only = false,
--      list = {
--        { key = { "l", "<CR>" }, cb = tree_cb("edit") },
--        { key = "h", cb = tree_cb("close_node") },
--        { key = "<BS>", cb = tree_cb("dir_up") },
--        { key = "?", cb = tree_cb("toggle_help") },
--      }
--    },
--  },
--}

---- ProjectNvim
--require('project_nvim').setup()

---- ToggleTerm
--require("toggleterm").setup {
--  open_mapping = [[<c-t>]],
--  direction = 'float',
--  float_noremap = { border = 'curved' }
--}

---- Treesitter setup
--require 'nvim-treesitter.configs'.setup {
--  ensure_installed = "maintained",
--  highlight = {
--    disable = { "vim" },
--    enable = true
--  },
--  incremental_selection = {
--    enable = true,
--    keymaps = {
--      init_selection = "+",
--      node_incremental = "+",
--      node_decremental = "_",
--    },
--  },
--}

---- Undo tree
--map('n', '<Leader>u', ':UndotreeToggle<CR>', noremap)
--vim.g.undotree_DiffAutoOpen = false
--vim.g.undotree_SetFocusWhenToggle = true
--vim.g.undotree_SplitWidth = 35
--vim.g.undotree_WindowLayout = 3

---- Vim-Commentary
--map('n', '<Leader>/', ':Commentary<CR>', noremap)
--map('v', '<Leader>/', ':Commentary<CR>', noremap)

---- Vim-RSI ==> disable meta-key bindings
--vim.g.rsi_no_meta = true

---- Yankstack
--map('n', '<Leader>p', ':Yanks<CR>', noremap)

------------------------------------------------------------------------------- ==>
---------------------------- Telescope Config --------------------------------- ==>
------------------------------------------------------------------------------- ==>

--local actions = require('telescope.actions')
--require('telescope').setup {
--  defaults = {
--    entry_prefix = "  ",
--    file_ignore_patterns = { "main.js", "%.spec.ts", "%-spec.ts" },
--    layout_config = {
--      horizontal = {
--        preview_cutoff = 150,
--        preview_width = 0.45,
--        prompt_position = "top"
--      },
--      width = 0.9
--    },
--    mappings = {
--      i = {
--        ["<ESC>"] = actions.close,
--        ["<C-t>"] = actions.toggle_selection,
--        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
--        ["<C-j>"] = actions.move_selection_next,
--        ["<C-k>"] = actions.move_selection_previous,
--        ["<C-r>"] = actions.delete_buffer,
--      },
--    },
--    path_display = { shorten = 5 },
--    prompt_prefix = " ",
--    selection_caret = " ",
--    sorting_strategy = "ascending",
--  },
--  extensions = {
--    file_browser = { path = "%:p:h" }
--  },

--}
--require('telescope').load_extension('coc')
--require("telescope").load_extension('file_browser')
--require('telescope').load_extension('fzy_native')
--require('telescope').load_extension('projects')

--vim.cmd [[command! -nargs=0 H lua require('telescope.builtin').help_tags()<cr>]]
--vim.cmd [[command! -nargs=0 M lua require('telescope.builtin').keymaps()<cr>]]

--map('n', '<Leader>p', ':Yanks<CR>', noremap)
--map('n', '<Leader>c', '<cmd>lua require("telescope.builtin").commands()<cr>', noremap)
--map('n', '<Leader>C', '<cmd>lua require("telescope.builtin").command_history()<cr>', noremap)
--map('n', '<Leader>e', '<cmd>lua require("telescope").extensions.file_browser.file_browser()<cr>', noremap)
--map('n', '<Leader>f', '<cmd>lua require("telescope.builtin").find_files()<cr>', noremap)
--map('n', '<Leader>F',
--  '<cmd>lua require("telescope.builtin").find_files({ cwd = vim.fn.input("Find In Dir: ", "~/")})<cr>', noremap)
--map('n', '<Leader>g', '<cmd>lua require("telescope.builtin").grep_string({ search = vim.fn.input("Grep > ")})<cr>', noremap)
--map('n', '<Leader>G', '<cmd>lua require("telescope.builtin").live_grep()<cr>', noremap)
--map('n', '<Leader>h', '<cmd>lua require("telescope.builtin").buffers()<cr>', noremap)
--map('n', '<Leader>H', '<cmd>lua require("telescope.builtin").oldfiles()<cr>', noremap)
--map('n', '<Leader>m', '<cmd>lua require("telescope.builtin").marks()<cr>', noremap)

------------------------------------------------------------------------------- ==>
---------------------------------- COC Config --------------------------------- ==>
------------------------------------------------------------------------------- ==>

---- vim.g.coc_global_extensions = {
----   'coc-angular',
----   'coc-css',
----   'coc-emmet',
----   'coc-go',
----   'coc-html',
----   'coc-json',
----   'coc-marketplace',
----   'coc-prettier',
----   'coc-pyright',
----   'coc-sumneko-lua',
----   'coc-tsserver',
----   'coc-vimlsp',
---- }

---- -- Add `:Format` command to format current buffer.
---- vim.cmd[[command! -nargs=0 Format :call CocActionAsync('format')]]

---- -- basic completion mappings
---- map('i', '<expr> <TAB>', vim.cmd[[pumvisible() ? "\<C-n>" : <SID>check_back_space() ? "\<TAB>" : coc#refresh()]], noremap_s)
---- map('i', '<expr> <S-TAB>', vim.cmd[[pumvisible() ? "\<C-p>" : "\<C-h>"]], noremap_s)
---- map('i', '<expr> <CR>', vim.cmd[[pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], noremap_s)

---- vim.cmd[[
----   fun! s:check_back_space() abort
----     let col = col('.') - 1
----     return !col || getline('.')[col - 1]  =~# '\s'
----   endfun
---- ]]

---- -- Show documentation
---- map('n', 'H', vim.cmd[[:call CocActionAsync('doHover')<CR>]], noremap_s)

---- -- Lsp code navigation.
---- map('n', 'gd', '<cmd>Telescope coc definitions<cr>', noremap_s)
---- map('n', 'gi', '<cmd>Telescope coc implementations<cr>', noremap_s)
---- map('n', 'gr', '<cmd>Telescope coc references<cr>', noremap_s)
---- map('n', 'gt', '<cmd>Telescope coc type_definitions<cr>', noremap_s)
---- map('n', '<Leader>rn', '<Plug>(coc-rename)', noremap)
---- map('n', '<Leader>la', '<cmd>Telescope coc file_code_actions<cr>', noremap)
---- map('n', '<Leader>ld', '<cmd>Telescope coc diagnostics<cr>', noremap)
---- map('n', '<Leader>ls', '<cmd>Telescope coc document_symbols<cr>', noremap)

---- -- Use `[d` and `]d` to navigate diagnostics
---- map('n', '[d', '<Plug>(coc-diagnostic-prev)', noremap)
---- map('n', ']d', '<Plug>(coc-diagnostic-next)', noremap)

------------------------------------------------------------------------------- ==>
------------------------------ Tmux Vim Integration---------------------------- ==>
------------------------------------------------------------------------------- ==>

---- Tmux-Vim navigator
--vim.g.tmux_navigator_no_mappings = true
--vim.g.tmux_navigator_save_on_switch = true
--vim.g.tmux_navigator_disable_when_zoomed = true
---- change windows from any mode
--map('n', '<C-h>', ':TmuxNavigateLeft<cr>', noremap_s)
--map('n', '<C-j>', ':TmuxNavigateDown<cr>', noremap_s)
--map('n', '<C-k>', ':TmuxNavigateUp<cr>', noremap_s)
--map('n', '<C-l>', ':TmuxNavigateRight<cr>', noremap_s)
--map('i', '<C-h>', '<Esc> :TmuxNavigateLeft<cr>', noremap_s)
--map('i', '<C-j>', '<Esc> :TmuxNavigateDown<cr>', noremap_s)
--map('i', '<C-k>', '<Esc> :TmuxNavigateUp<cr>', noremap_s)
--map('i', '<C-l>', '<Esc> :TmuxNavigateRight<cr>', noremap_s)
--map('v', '<C-h>', '<Esc> :TmuxNavigateLeft<cr>', noremap_s)
--map('v', '<C-j>', '<Esc> :TmuxNavigateDown<cr>', noremap_s)
--map('v', '<C-k>', '<Esc> :TmuxNavigateUp<cr>', noremap_s)
--map('v', '<C-l>', '<Esc> :TmuxNavigateRight<cr>', noremap_s)

---- Tmux-Vim Resizer
--vim.g.tmux_resizer_no_mappings = true
--map('n', '<A-h>', ':TmuxResizeLeft<cr>', noremap_s)
--map('n', '<A-j>', ':TmuxResizeDown<cr>', noremap_s)
--map('n', '<A-k>', ':TmuxResizeUp<cr>', noremap_s)
--map('n', '<A-l>', ':TmuxResizeRight<cr>', noremap_s)

------------------------------------------------------------------------------- ==>
------------------------------- Dashboard Config ------------------------------ ==>
------------------------------------------------------------------------------- ==>

--map('n', '<Leader><CR>', ':Dashboard<CR>', {})
--vim.g.dashboard_default_executive = 'telescope'
--vim.g.dashboard_session_directory = '~/.local/share/nvim/session'

--vim.g.dashboard_custom_section = {
--  a = { description = { "  Bookmarks          " }, command = "Telescope marks" },
--  b = { description = { "  New File           " }, command = "enew" },
--  c = { description = { "  Find File          " }, command = "Telescope find_files" },
--  d = { description = { "  Find Word          " }, command = "Telescope live_grep" },
--  e = { description = { "  Recent Files       " }, command = "Telescope oldfiles" },
--  f = { description = { "  Recent Projects    " }, command = "Telescope projects" },
--  h = { description = { "  Change Colorscheme " }, command = "Telescope colorscheme" },
--}

--vim.g.dashboard_custom_header = {
--  '',
--  '',
--  '',
--  '',
--  '',
--  '',
--  ' ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗',
--  ' ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║',
--  ' ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║',
--  ' ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║',
--  ' ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║',
--  ' ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝',
--  '',
--  '',
--  '',
--  '',
--}
