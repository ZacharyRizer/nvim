return {
    ---- Autopairs
    {
        'windwp/nvim-autopairs',
        config = function()
            require('nvim-autopairs').setup({ check_ts = true, fast_wrap = {} })
        end
    },
    ---- CoC
    {
        'neoclide/coc.nvim',
        branch = 'release',
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

            A.map('n', '[c', '<Plug>(coc-git-prevchunk)', A.opts.ns)
            A.map('n', ']c', '<Plug>(coc-git-nextchunk)', A.opts.ns)
            A.map('n', 'gc', ':CocCommand git.chunkInfo<cr>', A.opts.ns)
            A.map('n', 'gb', ':CocCommand git.showBlameDoc<cr>', A.opts.ns)
        end
    },
    ---- Comment
    {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup({
                toggler = { line = '<Leader>/', block = '<Leader>?', },
                opleader = { line = '<Leader>/', block = '<Leader>?', },
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
        config = function()
            require("indent_blankline").setup({
                char = '▏',
                use_treesitter = true,
                show_first_indent_level = false,
                filetype_exclude = { 'dashboard', 'help', 'undotree' },
                buftype_exclude = { 'nofile', 'terminal' }
            })
        end
    },
    ---- Lualine
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
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
        end
    },
    ---- Nvim Tree
    {
        'nvim-tree/nvim-tree.lua',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
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
                view                = {
                    side = 'right',
                    width = 35,
                },
            })
        end
    },
    ---- Surround
    {
        'kylechui/nvim-surround',
        config = function()
            require("nvim-surround").setup()
        end
    },
    ---- Telescope
    {
        'nvim-telescope/telescope.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
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

            vim.cmd [[command! -nargs=0 Help lua require('telescope.builtin').help_tags()<cr>]]

            A.map('n', '<Leader>b', ':Telescope buffers<CR>', A.opts.ns)
            A.map('n', '<Leader>c', ':Telescope commands<CR>', A.opts.ns)
            A.map('n', '<Leader>f', ':Telescope find_files<CR>', A.opts.ns)
            A.map('n', '<Leader>g', ':Telescope live_grep<CR>', A.opts.ns)
            A.map('n', '<Leader>h', ':Telescope oldfiles<CR>', A.opts.ns)
            A.map('n', '<Leader>m', ':Telescope keymaps<CR>', A.opts.ns)
            A.map('n', '<Leader>r', ':Telescope registers<CR>', A.opts.ns)
        end
    },
    ---- Telescope extensions
    { 'nvim-telescope/telescope-fzy-native.nvim', run = 'make' },
    { 'fannheyward/telescope-coc.nvim' },
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
    ---- Treesitter
    {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = function()
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
        end
    },
    ---- Undo Tree
    {
        'mbbill/undotree',
        config = function()
            A.map('n', '<Leader>u', ':UndotreeToggle<CR>', A.opts.ns)
            vim.g.undotree_DiffAutoOpen = false
            vim.g.undotree_SetFocusWhenToggle = true
            vim.g.undotree_SplitWidth = 35
            vim.g.undotree_WindowLayout = 3
        end
    }
}