--------------------------------  Plugin Settings -----------------------------

---- Autopairs and Autotag
require('nvim-autopairs').setup({ check_ts = true, fast_wrap = {} })
require('nvim-ts-autotag').setup()

---- Comment
require('Comment').setup({
    toggler = { line = '<Leader>/', block = '<Leader>?', },
    opleader = { line = '<Leader>/', block = '<Leader>?', },
    mappings = { extra = false, extended = false, },
})

---- Harpoon
Map("n", "<Leader>a", ":lua require('harpoon.mark').add_file() <cr>", Opts.s)
Map("n", "<Leader>m", ":lua require('harpoon.ui').toggle_quick_menu() <cr>", Opts.s)
Map("n", "<Leader>1", ":lua require('harpoon.ui').nav_file(1) <cr>", Opts.s)
Map("n", "<Leader>2", ":lua require('harpoon.ui').nav_file(2) <cr>", Opts.s)
Map("n", "<Leader>3", ":lua require('harpoon.ui').nav_file(3) <cr>", Opts.s)
Map("n", "<Leader>4", ":lua require('harpoon.ui').nav_file(4) <cr>", Opts.s)

---- Indentline
require("indent_blankline").setup({
    char = '▏',
    use_treesitter = true,
    show_first_indent_level = false,
    filetype_exclude = { 'dashboard', 'help', 'undotree' },
    buftype_exclude = { 'nofile', 'terminal' }
})

---- Lualine
local big_screen = function() return vim.fn.winwidth(0) > 90 end
require 'lualine'.setup({
    extensions = { 'quickfix' },
    options = {
        disabled_filetypes = { 'dashboard', 'NvimTree', 'undotree' },
    },
    sections = {
        lualine_a = { { 'mode', fmt = function(str) return str:sub(1, 1) end } },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { 'filename' },
        lualine_x = { { 'g:coc_status', cond = big_screen } },
        lualine_y = { { 'progress', cond = big_screen } },
        lualine_z = { { 'location', cond = big_screen } }
    },
})

---- ProjectNvim
require('project_nvim').setup()

---- Surround
require("nvim-surround").setup()

---- Tmux
require("tmux").setup({
    copy_sync = {
        redirect_to_clipboard = true,
    },
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

---- ToggleTerm
require("toggleterm").setup({
    open_mapping = [[<c-t>]],
    direction = 'float',
    float_opts = { border = 'curved' }
})

---- TokyoNight
require("tokyonight").setup({
    sidebars = { "qf", "help", "undotree" },
    lualine_bold = true,
})
vim.cmd("colorscheme tokyonight")

---- Treesitter
require 'nvim-treesitter.configs'.setup({
    ensure_installed = {
        "bash",
        "comment",
        "css",
        "dockerfile",
        "gitignore",
        "go",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "python",
        "regex",
        "rust",
        "scss",
        "sql",
        "toml",
        "tsx",
        "typescript",
        "yaml",
    },
    highlight = { enable = true },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "+",
            node_incremental = "+",
            node_decremental = "_",
        },
    },
    indent = { enable = true }
})
require 'treesitter-context'.setup()

---- Undo tree
Map('n', '<Leader>u', ':UndotreeToggle<CR>', Opts.s)
vim.g.undotree_DiffAutoOpen = false
vim.g.undotree_SetFocusWhenToggle = true
vim.g.undotree_SplitWidth = 35
vim.g.undotree_WindowLayout = 3

---- Vim-Fugitive
vim.cmd [[command! -nargs=0 Blame G blame]]
vim.cmd [[command! -nargs=0 Diff Gdiffsplit!]]
vim.cmd [[command! -nargs=0 Merge G mergetool]]

---- Yankstack
require("yanky").setup({ highlight = { timer = 100 } })
Map({ "n", "x" }, "y", "<Plug>(YankyYank)", Opts.s)
Map({ "n", "x" }, "p", "<Plug>(YankyPutAfter)", Opts.s)
Map({ "n", "x" }, "P", "<Plug>(YankyPutBefore)", Opts.s)
Map({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)", Opts.s)
Map({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)", Opts.s)
Map("n", "<C-n>", "<Plug>(YankyCycleForward)", Opts.s)
Map("n", "<C-p>", "<Plug>(YankyCycleBackward)", Opts.s)

---------------------------- Telescope Config ---------------------------------

local actions = require('telescope.actions')
require('telescope').setup({
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
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
                ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
                ["<C-r>"] = actions.delete_buffer,
                ["<C-s>"] = actions.select_horizontal,
                ["<C-t>"] = actions.toggle_selection,
                ["<M-BS>"] = { "<c-s-w>", type = "command" },
            },
            n = {
                ["<C-t>"] = actions.toggle_selection,
            },
        },
        path_display = { shorten = 5 },
        prompt_prefix = " ",
        selection_caret = " ",
        sorting_strategy = "ascending",
    },
    extensions = {
        file_browser = {
            hijack_netrw = true,
            path = "%:p:h",
        }
    }
})
require('telescope').load_extension('coc')
require('telescope').load_extension('file_browser')
require('telescope').load_extension('projects')
require('telescope').load_extension('yank_history')

vim.cmd [[command! -nargs=0 H lua require('telescope.builtin').help_tags()<cr>]]
vim.cmd [[command! -nargs=0 M lua require('telescope.builtin').keymaps()<cr>]]

Map('n', '<Leader>c', ':Telescope commands<CR>', Opts.s)
Map('n', '<Leader>e', ':Telescope file_browser<CR>', Opts.s)
Map('n', '<Leader>f', ':Telescope find_files<CR>', Opts.s)
Map('n', '<Leader>g', ':Telescope live_grep<CR>', Opts.s)
Map('n', '<Leader>h', ':Telescope buffers<CR>', Opts.s)
Map('n', '<Leader>lc', ':Telescope command_history<CR>', Opts.s)
Map('n', '<Leader>lh', ':Telescope oldfiles<CR>', Opts.s)
Map('n', '<Leader>ls', ':Telescope treesitter<CR>', Opts.s)
Map('n', '<Leader>p', ':Telescope projects<CR>', Opts.s)
Map('n', '<Leader>y', ':Telescope yank_history<CR>', Opts.s)

---------------------------------- COC Config ---------------------------------

vim.g.coc_global_extensions = {
    'coc-angular',
    'coc-css',
    'coc-emmet',
    'coc-git',
    'coc-go',
    'coc-highlight',
    'coc-hls',
    'coc-html',
    'coc-json',
    'coc-marketplace',
    'coc-prettier',
    'coc-pyright',
    'coc-rust-analyzer',
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
Map('n', 'K', ":call CocActionAsync('doHover')<CR>", Opts.s)

---- Lsp code navigation.
Map('n', 'gd', ':Telescope coc definitions<CR>', Opts.s)
Map('n', 'gi', ':Telescope coc implementations<CR>', Opts.s)
Map('n', 'gr', ':Telescope coc references<CR>', Opts.s)
Map('n', 'gt', ':Telescope coc type_definitions<CR>', Opts.s)
Map('n', '<Leader>la', ':Telescope coc file_code_actions<CR>', Opts.s)
Map('n', '<Leader>ld', ':Telescope coc diagnostics<CR>', Opts.s)
Map('n', '<Leader>rn', '<Plug>(coc-rename)')

---- Use `[d` and `]d` to navigate diagnostics
Map('n', '[d', '<Plug>(coc-diagnostic-prev)', Opts.s)
Map('n', ']d', '<Plug>(coc-diagnostic-next)', Opts.s)

---- coc-git
Map('n', '[c', '<Plug>(coc-git-prevchunk)', Opts.s)
Map('n', ']c', '<Plug>(coc-git-nextchunk)', Opts.s)
Map('n', 'gc', ':CocCommand git.chunkInfo<cr>', Opts.s)
Map('n', 'gb', ':CocCommand git.showBlameDoc<cr>', Opts.s)
