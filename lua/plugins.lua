return {
    ---- Autopairs
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        opts = {} -- this is equalent to setup({}) function
    },
    ---- CoC
    {
        'neoclide/coc.nvim',
        branch = 'release',
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            vim.g.coc_global_extensions = {
                'coc-css',
                'coc-emmet',
                'coc-git',
                'coc-highlight',
                'coc-html',
                'coc-json',
                'coc-lua',
                'coc-marketplace',
                'coc-prettier',
                'coc-pyright',
                'coc-rust-analyzer',
                'coc-tsserver',
            }

            vim.cmd [[
                function! CheckBackspace() abort
                  let col = col('.') - 1
                  return !col || getline('.')[col - 1]  =~# '\s'
                endfunction

                inoremap <silent><expr> <TAB> coc#pum#visible() ? coc#pum#next(1) : CheckBackspace() ? "\<Tab>" : coc#refresh()
                inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
                inoremap <silent><expr> <CR> coc#pum#visible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

                nnoremap <silent><nowait><expr> <C-d> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-d>"
                nnoremap <silent><nowait><expr> <C-u> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-u>"
                inoremap <silent><nowait><expr> <C-d> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Del>"
                inoremap <silent><nowait><expr> <C-u> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : ""
            ]]

            A.map('n', 'K', ":call CocActionAsync('doHover')<CR>", A.opts.ns)

            A.map('n', 'gd', ':Telescope coc definitions<CR>', A.opts.ns)
            A.map('n', 'gi', ':Telescope coc implementations<CR>', A.opts.ns)
            A.map('n', 'gr', ':Telescope coc references<CR>', A.opts.ns)
            A.map('n', 'gt', ':Telescope coc type_definitions<CR>', A.opts.ns)
            A.map('n', '<Leader>rn', '<Plug>(coc-rename)')

            A.map('n', '<Leader>la', ':Telescope coc file_code_actions<CR>', A.opts.ns)
            A.map('n', '<Leader>ld', ':Telescope coc diagnostics<CR>', A.opts.ns)
            A.map('n', '<Leader>ls', ':Telescope treesitter<CR>', A.opts.ns)

            A.map('n', '[d', '<Plug>(coc-diagnostic-prev)', A.opts.ns)
            A.map('n', ']d', '<Plug>(coc-diagnostic-next)', A.opts.ns)

            A.map('n', '[g', '<Plug>(coc-git-prevchunk)', A.opts.ns)
            A.map('n', ']g', '<Plug>(coc-git-nextchunk)', A.opts.ns)
            A.map('n', 'gc', ':CocCommand git.chunkInfo<cr>', A.opts.ns)
            A.map('n', 'gb', ':CocCommand git.showBlameDoc<cr>', A.opts.ns)
        end
    },
    ---- Comment
    {
        'numToStr/Comment.nvim',
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require('Comment').setup({
                toggler = { line = '<Leader>`', block = '<Leader>~', },
                opleader = { line = '<Leader>`', block = '<Leader>~', },
                mappings = { extra = false, extended = false, },
            })
        end
    },
    ---- Dashboard
    {
        'glepnir/dashboard-nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            A.map('n', '<Leader><CR>', ':Dashboard<CR>', A.opts.ns)
            require('dashboard').setup({
                theme = 'doom',
                config = {
                    center = {
                        { icon = '    ', desc = 'Plugin Manager ', action = 'Lazy' },
                        { icon = '    ', desc = 'Config         ', action = 'e ~/.config/nvim/init.lua' },
                    },
                    header = {
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
                    },
                },
            })
        end
    },
    ---- Fugitive
    {
        'tpope/vim-fugitive',
        config = function()
            vim.cmd [[command! -nargs=0 Blame G blame]]
            vim.cmd [[command! -nargs=0 Diff Gvdiffsplit! main]]
            vim.cmd [[command! -nargs=0 Merge G mergetool]]
        end
    },
    ---- Indent Blank Line
    {
        'lukas-reineke/indent-blankline.nvim',
        event = { "BufReadPre", "BufNewFile" },
        main = "ibl",
        config = function()
            local hooks = require "ibl.hooks"
            hooks.register(
                hooks.type.WHITESPACE,
                hooks.builtin.hide_first_space_indent_level
            )
            require("ibl").setup({
                indent = { char = '▏' },
                scope = { enabled = false },
                exclude = {
                    filetypes = { 'dashboard', 'haskell', 'help', 'python', 'undotree' },
                    buftypes = { 'nofile', 'terminal' }
                }
            })
        end
    },
    ---- Lualine
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            local big_screen = function() return vim.fn.winwidth(0) > 90 end
            require 'lualine'.setup({
                extensions = { 'quickfix' },
                options = { disabled_filetypes = { 'dashboard', 'NvimTree', 'undotree' } },
                sections = {
                    lualine_a = { { 'mode', fmt = function(str) return str:sub(1, 1) end } },
                    lualine_b = { 'branch', 'diff', 'diagnostics' },
                    lualine_c = { 'filename' },
                    lualine_x = { { 'g:coc_status', cond = big_screen } },
                    lualine_y = { { 'progress', cond = big_screen } },
                    lualine_z = { { 'location', cond = big_screen } }
                },
            })
        end
    },
    ---- Markdown Preview
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        build = "cd app && yarn install",
        init = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
        ft = { "markdown" },
    },
    ---- Nvim Tree
    {
        'nvim-tree/nvim-tree.lua',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        keys = { "<C-e>" },
        config = function()
            A.map('n', '<C-e>', ':NvimTreeToggle<CR>', A.opts.ns)

            local function nvim_tree_on_attach(bufnr)
                local api = require('nvim-tree.api')

                local function opts(desc)
                    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
                end

                api.config.mappings.default_on_attach(bufnr)

                vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts('Close Directory'))
                vim.keymap.set('n', 'l', api.node.open.replace_tree_buffer, opts('Open: In Place'))
                vim.keymap.set('n', '<BS>', api.tree.change_root_to_parent, opts('Up'))
                vim.keymap.set('n', '<C-s>', api.node.open.horizontal, opts('Open: Horizontal Split'))
                vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))

                vim.keymap.del('n', '<C-e>', { buffer = bufnr })
                vim.keymap.del('n', '<C-x>', { buffer = bufnr })
            end

            require('nvim-tree').setup({
                actions             = {
                    open_file = { quit_on_open = true },
                },
                renderer            = {
                    indent_markers = { enable = true }
                },
                respect_buf_cwd     = true,
                on_attach           = nvim_tree_on_attach,
                sync_root_with_cwd  = true,
                update_focused_file = { enable = true, update_root = true },
                view                = { width = { min = 35 } },
            })
        end
    },
    ---- Surround
    {
        'kylechui/nvim-surround',
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("nvim-surround").setup()
        end
    },
    ---- Telescope
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope-fzy-native.nvim',
            'fannheyward/telescope-coc.nvim'
        },
        config = function()
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
            })
            require('telescope').load_extension('coc')
            require('telescope').load_extension('fzy_native')
            require('telescope').load_extension('yank_history')

            A.map('n', '<Leader>b', ':Telescope buffers<CR>', A.opts.ns)
            A.map('n', '<Leader>c', ':Telescope commands<CR>', A.opts.ns)
            A.map('n', '<Leader>d', ':Telescope help_tags prompt_title=Documentation<CR>', A.opts.ns)
            A.map('n', '<Leader>f', ':Telescope find_files<CR>', A.opts.ns)
            A.map('n', '<Leader>g', ':Telescope live_grep<CR>', A.opts.ns)
            A.map('n', '<Leader>h', ':Telescope oldfiles prompt_title=History<CR>', A.opts.ns)
            A.map('n', '<Leader>m', ':Telescope keymaps<CR>', A.opts.ns)
            A.map('n', '<Leader>y', ':Telescope yank_history<CR>', A.opts.ns)
        end
    },
    ---- Tmux Integration
    {
        'aserowy/tmux.nvim',
        config = function()
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
        end
    },
    ---- Tokyonight
    {
        'folke/tokyonight.nvim',
        priority = 1000,
        config = function()
            require("tokyonight").setup({
                sidebars = { "qf", "help", "undotree" },
                lualine_bold = true,
            })
            vim.cmd("colorscheme tokyonight")
        end
    },
    ---- Toggleterm
    {
        'akinsho/toggleterm.nvim',
        version = "*",
        keys = { "<C-t>" },
        config = function()
            require("toggleterm").setup({
                size = function(term)
                    if term.direction == "horizontal" then
                        return 15
                    elseif term.direction == "vertical" then
                        return vim.o.columns * 0.4
                    end
                end,
                open_mapping = [[<C-t>]],
                direction = 'vertical',

            })
        end
    },
    ---- Treesitter
    {
        'nvim-treesitter/nvim-treesitter',
        event = { "BufReadPre", "BufNewFile" },
        run = ':TSUpdate',
        config = function()
            -- treesitter base setup
            require 'nvim-treesitter.configs'.setup({
                ensure_installed = {
                    "bash",
                    "comment",
                    "css",
                    "dockerfile",
                    "gitignore",
                    "go",
                    "haskell",
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
        end
    },
    ---- Undo Tree
    {
        'mbbill/undotree',
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            A.map('n', '<Leader>u', ':UndotreeToggle<CR>', A.opts.ns)
            vim.g.undotree_DiffAutoOpen = false
            vim.g.undotree_SetFocusWhenToggle = true
            vim.g.undotree_SplitWidth = 35
            vim.g.undotree_WindowLayout = 3
        end
    },
    ---- Yanky
    {
        'gbprod/yanky.nvim',
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("yanky").setup({ highlight = { timer = 100 } })
            A.map({ "n", "x" }, "y", "<Plug>(YankyYank)", A.opts.ns)
            A.map({ "n", "x" }, "p", "<Plug>(YankyPutAfter)", A.opts.ns)
            A.map({ "n", "x" }, "P", "<Plug>(YankyPutBefore)", A.opts.ns)
            A.map("n", "<C-n>", "<Plug>(YankyNextEntry)", A.opts.ns)
            A.map("n", "<C-p>", "<Plug>(YankyPreviousEntry)", A.opts.ns)
        end
    }
}
