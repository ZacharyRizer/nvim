return {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        require("tokyonight").setup({
            sidebars = { "qf", "help", "undotree" },
            lualine_bold = true,
            on_colors = function(colors)
                colors.hint = colors.comment
            end
        })
        vim.cmd("colorscheme tokyonight")
    end,
}
