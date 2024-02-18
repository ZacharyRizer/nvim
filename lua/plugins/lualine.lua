return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local big_screen = function()
            return vim.fn.winwidth(0) > 90
        end

        require("lualine").setup({
            extensions = { "quickfix" },
            options = {
                component_separators = '|',
                section_separators = '',
                disabled_filetypes = { "dashboard", "NvimTree", "undotree" }
            },
            sections = {
                lualine_a = { { "mode", fmt = function(str) return str:sub(1, 1) end, } },
                lualine_b = { "branch", "diff" },
                lualine_c = { "filename", "diagnostics" },
                lualine_x = {
                    {
                        'g:coc_status',
                        cond = big_screen,
                        fmt = function(str)
                            local max_length = 80
                            if #str > max_length then
                                return str:sub(1, max_length) .. "…"
                            end
                            return str
                        end
                    }
                },
                lualine_y = { { "progress", cond = big_screen } },
                lualine_z = { { "location", cond = big_screen } },
            },
        })
    end,
}
