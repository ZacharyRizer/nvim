return {
    "glepnir/dashboard-nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        A.map("n", "<Leader><CR>", ":Dashboard<CR>")
        require("dashboard").setup({
            theme = "doom",
            config = {
                center = {
                    { icon = "    ", desc = "Plugin Manager ", action = "Lazy" },
                    { icon = "    ", desc = "Config         ", action = "e ~/.config/nvim/init.lua" },
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
                    [[                                                       ]],
                },
            },
        })
    end,
}
