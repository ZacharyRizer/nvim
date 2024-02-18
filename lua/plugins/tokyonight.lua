return {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        require("tokyonight").setup({
            sidebars = { "qf", "help", "undotree" },
            lualine_bold = true,
        })
        vim.cmd("colorscheme tokyonight")
    end,
}
