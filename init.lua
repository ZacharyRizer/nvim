-------------------------------------------------------------------------------
---------------------------------- Aliases ------------------------------------
-------------------------------------------------------------------------------

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local map = vim.keymap.set
local noremap = { noremap = true }
local noremap_s = { noremap = true, silent = true }
local plug = vim.fn['plug#']

-------------------------------------------------------------------------------
---------------------------------- Plug-Ins -----------------------------------
-------------------------------------------------------------------------------

vim.call('plug#begin', '~/.vim/plugged')

---- Cache for lua plugins: Nvim start time
plug('lewis6991/impatient.nvim')

---- LSP, Completions, Git, Telescope
plug('nvim-lua/plenary.nvim')
plug('nvim-telescope/telescope.nvim')
plug('nvim-telescope/telescope-fzy-native.nvim', { ['do'] = 'make' })
plug('fannheyward/telescope-coc.nvim')
plug('ahmedkhalf/project.nvim')
plug('neoclide/coc.nvim', { branch = 'release' })
plug('tpope/vim-fugitive')

---- Theme and Formatting
plug('folke/tokyonight.nvim', { branch = 'main' })
plug('nvim-lualine/lualine.nvim')
plug('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' })
plug('nvim-treesitter/nvim-treesitter-context')
plug('kyazdani42/nvim-web-devicons')
plug('lukas-reineke/indent-blankline.nvim')
plug('windwp/nvim-autopairs')
plug('windwp/nvim-ts-autotag')

---- UI Elements
plug('ThePrimeagen/harpoon')
plug('glepnir/dashboard-nvim')
plug('kyazdani42/nvim-tree.lua')
plug('mbbill/undotree')
plug('akinsho/toggleterm.nvim')
plug('gbprod/yanky.nvim')
plug('numToStr/Comment.nvim')
plug('kylechui/nvim-surround')

---- Tmux-Vim Integration
plug('aserowy/tmux.nvim')

vim.call('plug#end')

-------------------------------------------------------------------------------
------------------------------ General Settings -------------------------------
-------------------------------------------------------------------------------

require('impatient')

vim.opt.clipboard = "unnamedplus"
vim.opt.completeopt = { "menuone", "noinsert", "noselect" }
vim.opt.expandtab = true
vim.opt.hidden = true
vim.opt.ignorecase = true
vim.opt.inccommand = "nosplit"
vim.opt.lazyredraw = true
vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.pumblend = 15
vim.opt.relativenumber = true
vim.opt.scrolloff = 999
vim.opt.shiftwidth = 2
vim.opt.shortmess:append("c")
vim.opt.showmode = false
vim.opt.sidescrolloff = 15
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
autocmd({ "CursorHold, CursorHoldI" }, {
    pattern = "*",
    command = "checktime",
    group = Formating
})
autocmd("FileType", {
    pattern = { "go", "haskell", "lua", "python", "yaml" },
    command = "setlocal shiftwidth=4 softtabstop=4 tabstop=4",
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
map('t', '<C-[>', '<C-\\><C-n>', noremap)

---- unmapping a few keys that annoy me
map('n', 'K', '<nop>', noremap)
map('n', 'Q', '<nop>', noremap)
map('n', '<Space>', '<nop>', noremap)
map('n', '<BS>', '<nop>', noremap)

---- readline/emacs keys for i and c modes
map({ 'c', 'i' }, '<C-a>', '<Home>', noremap)
map({ 'c', 'i' }, '<C-b>', '<Left>', noremap)
map({ 'c', 'i' }, '<C-d>', '<Del>', noremap)
map({ 'c', 'i' }, '<C-e>', '<End>', noremap)
map({ 'c', 'i' }, '<C-f>', '<Right>', noremap)

---- easy word replace, search/replace, and */# searching stay in place
map('n', 'c*', '*Ncgn', noremap)
map('n', '*', '*N', noremap)
map('n', '#', '#N', noremap)
map('v', '*', 'y/<C-R>"<CR>N', noremap)
map('v', '#', 'y?<C-R>"<CR>N', noremap)
map('n', '<Leader>s', ':%s/', noremap)
map('v', '<Leader>s', ':s/', noremap)

---- more intuitive yanking
map('n', 'Y', 'y$')

---- better line connection
map('n', 'J', 'mzJ`z', noremap)

---- move/tab text easily
map('v', '<', '<gv', noremap)
map('v', '>', '>gv', noremap)
map('n', '<', '<<', noremap)
map('n', '>', '>>', noremap)
map('v', 'J', ":m '>+1<CR>gv=gv", noremap)
map('v', 'K', ":m '<-2<CR>gv=gv", noremap)

---- easy buffer delete and close
map('n', '<Leader>d', ':bd<cr>', noremap)
map('n', '<Leader>dd', ':bd!<cr>', noremap)
map('n', '<Leader>wo', ':%bd <bar> e# <bar> normal `--<cr>', noremap)

---- quickfix lists
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
map('n', '<C-q>', ToggleQFList, noremap)

-------------------------------------------------------------------------------
------------------------------ Theme & Statusline -----------------------------
-------------------------------------------------------------------------------

---- Lualine
require 'lualine'.setup {
    extensions = { 'nvim-tree', 'quickfix' },
    options = {
        disabled_filetypes = { 'dashboard', 'undotree' },
    },
    sections = {
        lualine_a = { { 'mode', fmt = function(str) return str:sub(1, 1) end } },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { 'filename' },
        lualine_x = { { 'g:coc_status', cond = function() return vim.fn.winwidth(0) > 90 end } },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
    },
}

---- Tokyonight
require("tokyonight").setup({
    sidebars = { "qf", "help", "undotree" },
    lualine_bold = true,
})
vim.cmd("colorscheme tokyonight")

-------------------------------------------------------------------------------
--------------------------------  Plugin Settings -----------------------------
-------------------------------------------------------------------------------

---- Autopairs and Autotag
require('nvim-autopairs').setup({ check_ts = true, fast_wrap = {} })
require('nvim-ts-autotag').setup()

---- Comment
require('Comment').setup({
    toggler = { line = '<leader>/', block = '<leader>?', },
    opleader = { line = '<leader>/', block = '<leader>?', },
    mappings = { extra = false, extended = false, },
})

---- Harpoon
map("n", "<Leader>a", ":lua require('harpoon.mark').add_file() <cr>", noremap_s)
map("n", "<Leader>m", ":lua require('harpoon.ui').toggle_quick_menu() <cr>", noremap_s)
map("n", "<Leader>1", ":lua require('harpoon.ui').nav_file(1) <cr>", noremap_s)
map("n", "<Leader>2", ":lua require('harpoon.ui').nav_file(2) <cr>", noremap_s)
map("n", "<Leader>3", ":lua require('harpoon.ui').nav_file(3) <cr>", noremap_s)
map("n", "<Leader>4", ":lua require('harpoon.ui').nav_file(4) <cr>", noremap_s)

---- Indentline
require("indent_blankline").setup {
    char = '▏',
    use_treesitter = true,
    show_first_indent_level = false,
    filetype_exclude = { 'dashboard', 'help', 'undotree' },
    buftype_exclude = { 'nofile', 'terminal' }
}

---- NvimTree setup
map('n', '<C-e>', ':NvimTreeToggle<CR>', noremap)
local tree_cb = require 'nvim-tree.config'.nvim_tree_callback
require 'nvim-tree'.setup {
    actions             = {
        open_file = { quit_on_open = true },
    },
    renderer            = {
        indent_markers = { enable = true }
    },
    respect_buf_cwd     = true,
    update_cwd          = true,
    update_focused_file = { enable = true, update_cwd = true },
    view                = {
        width = 37,
        side = 'right',
        mappings = {
            custom_only = false,
            list = {
                { key = "<CR>", cb = tree_cb("edit") },
                { key = "h", cb = tree_cb("close_node") },
                { key = "l", cb = tree_cb("open_node") },
                { key = "<BS>", cb = tree_cb("dir_up") },
                { key = "?", cb = tree_cb("toggle_help") },
                { key = "<C-e>", cb = tree_cb("close") },
            }
        },
    },
}

---- ProjectNvim
require('project_nvim').setup()

---- Surround
require("nvim-surround").setup()

---- ToggleTerm
require("toggleterm").setup {
    open_mapping = [[<c-t>]],
    direction = 'float',
    float_opts = { border = 'curved' }
}
local Terminal = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new({
    cmd = "lazygit",
    hidden = true,
    direction = "float",
    float_opts = {
        border = 'none',
        height = vim.o.lines,
        width = vim.o.columns,
    },
})
function Lazygit_Toggle()
    lazygit:toggle()
end

map("n", "<Leader>lg", Lazygit_Toggle, noremap_s)

---- Treesitter setup
require 'treesitter-context'.setup {
    patterns = {
        default = { 'class', 'function', 'method', 'for', 'while', 'if', 'switch', 'case' },
    },
}
require 'nvim-treesitter.configs'.setup {
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

---- Undo tree
map('n', '<Leader>u', ':UndotreeToggle<CR>', noremap)
vim.g.undotree_DiffAutoOpen = false
vim.g.undotree_SetFocusWhenToggle = true
vim.g.undotree_SplitWidth = 35
vim.g.undotree_WindowLayout = 3

---- Vim-Fugitive
vim.cmd [[command! -nargs=0 Blame G blame]]
vim.cmd [[command! -nargs=0 Diff Gdiffsplit!]]

---- Yankstack
require("yanky").setup({ highlight = { timer = 250 } })
map({ "n", "x" }, "y", "<Plug>(YankyYank)")
map({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
map({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")
map({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)")
map({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)")
map("n", "<C-n>", "<Plug>(YankyCycleForward)")
map("n", "<C-p>", "<Plug>(YankyCycleBackward)")

-------------------------------------------------------------------------------
---------------------------- Telescope Config ---------------------------------
-------------------------------------------------------------------------------

local actions = require('telescope.actions')
require('telescope').setup {
    defaults = {
        entry_prefix = "  ",
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

vim.cmd [[command! -nargs=0 H lua require('telescope.builtin').help_tags()<cr>]]
vim.cmd [[command! -nargs=0 M lua require('telescope.builtin').keymaps()<cr>]]

map('n', '<Leader>c', ':Telescope commands<CR>', noremap)
map('n', '<Leader>f', ':Telescope find_files<CR>', noremap)
map('n', '<Leader>g', ':Telescope live_grep<CR>', noremap)
map('n', '<Leader>h', ':Telescope buffers<CR>', noremap)
map('n', '<Leader>la', ':Telescope coc file_code_actions<CR>', noremap)
map('n', '<Leader>lc', ':Telescope command_history<CR>', noremap)
map('n', '<Leader>ld', ':Telescope coc diagnostics<CR>', noremap)
map('n', '<Leader>lh', ':Telescope oldfiles<CR>', noremap)
map('n', '<Leader>ls', ':Telescope treesitter<CR>', noremap)
map('n', '<Leader>p', ':Telescope projects<CR>', noremap)
map('n', '<Leader>y', ':Telescope yank_history<CR>', noremap)

-------------------------------------------------------------------------------
---------------------------------- COC Config ---------------------------------
-------------------------------------------------------------------------------

vim.g.coc_global_extensions = {
    'coc-angular',
    'coc-css',
    'coc-emmet',
    'coc-git',
    'coc-go',
    'coc-highlight',
    'coc-html',
    'coc-json',
    'coc-marketplace',
    'coc-prettier',
    'coc-pyright',
    'coc-sumneko-lua',
    'coc-tsserver',
}

---- basic completion mappings
vim.cmd [[
    inoremap <silent><expr> <TAB> coc#pum#visible() ? coc#pum#next(1) : CheckBackspace() ? "\<Tab>" : coc#refresh()
    inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
    inoremap <silent><expr> <CR> coc#pum#visible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

    function! CheckBackspace() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~# '\s'
    endfunction
]]

---- Show documentation
map('n', 'K', ":call CocActionAsync('doHover')<CR>", noremap_s)

---- Lsp code navigation.
map('n', 'gd', '<cmd>Telescope coc definitions<cr>', noremap_s)
map('n', 'gi', '<cmd>Telescope coc implementations<cr>', noremap_s)
map('n', 'gr', '<cmd>Telescope coc references<cr>', noremap_s)
map('n', 'gt', '<cmd>Telescope coc type_definitions<cr>', noremap_s)
map('n', '<Leader>rn', '<Plug>(coc-rename)')

---- Use `[d` and `]d` to navigate diagnostics
map('n', '[d', '<Plug>(coc-diagnostic-prev)')
map('n', ']d', '<Plug>(coc-diagnostic-next)')

---- coc-git
map('n', '[c', '<Plug>(coc-git-prevchunk)')
map('n', ']c', '<Plug>(coc-git-nextchunk)')
map('n', 'gc', ':CocCommand git.chunkInfo<cr>')
map('n', 'gb', ':CocCommand git.showBlameDoc<cr>')

-------------------------------------------------------------------------------
------------------------------ Tmux Vim Integration----------------------------
-------------------------------------------------------------------------------

require("tmux").setup({
    navigation = {
        cycle_navigation = false,
        enable_default_keybindings = true,
        persist_zoom = true,
    },
    resize = {
        enable_default_keybindings = true,
        resize_step_x = 5,
        resize_step_y = 2,
    }
})

-------------------------------------------------------------------------------
------------------------------- Dashboard Config ------------------------------
-------------------------------------------------------------------------------

map('n', '<Leader><CR>', ':Dashboard<CR>', noremap)
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
    { icon = '    ', desc = 'New File       ', action = 'DashboardNewFile' },
    { icon = '    ', desc = 'Find File      ', action = 'Telescope find_files' },
    { icon = '    ', desc = 'Find Word      ', action = 'Telescope live_grep' },
    { icon = '    ', desc = 'Recent Files   ', action = 'Telescope oldfiles' },
    { icon = '    ', desc = 'Recent Projects', action = 'Telescope projects' },
    { icon = '    ', desc = 'Config         ', action = 'e ~/.config/nvim/init.lua' },
}
db.custom_footer = {}
db.hide_statusline = false
db.session_directory = '~/.local/share/nvim/session'
