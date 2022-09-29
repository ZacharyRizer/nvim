--------------------------------- Dashboard -----------------------------------

Map('n', '<Leader><CR>', ':Dashboard<CR>', Opts.s)
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

---------------------------------- Lualine ------------------------------------

require 'lualine'.setup({
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
})

--------------------------------- TokyoNight ----------------------------------

require("tokyonight").setup({
    sidebars = { "qf", "help", "undotree" },
    lualine_bold = true,
})
vim.cmd("colorscheme tokyonight")
