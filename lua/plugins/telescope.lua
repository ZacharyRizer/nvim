return {
    "nvim-telescope/telescope.nvim",
    event = { "BufReadPre", "BufNewFile" },
    keys = { "<leader>d", "<leader>f", "<leader>g", "<leader>h" },
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope-fzy-native.nvim",
        "fannheyward/telescope-coc.nvim",
    },
    config = function()
        local actions = require("telescope.actions")
        require("telescope").setup({
            defaults = {
                entry_prefix = "  ",
                layout_config = {
                    horizontal = {
                        preview_cutoff = 150,
                        preview_width = 0.45,
                        prompt_position = "top",
                    },
                    width = 0.9,
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
        require("telescope").load_extension("coc")
        require("telescope").load_extension("fzy_native")
        require("telescope").load_extension("yank_history")

        A.map("n", "<Leader>b", ":Telescope buffers<CR>")
        A.map("n", "<Leader>c", ":Telescope commands<CR>")
        A.map("n", "<Leader>d", ":Telescope help_tags prompt_title=Documentation<CR>")
        A.map("n", "<Leader>f", ":Telescope find_files<CR>")
        A.map("n", "<Leader>g", ":Telescope live_grep<CR>")
        A.map("n", "<Leader>h", ":Telescope oldfiles prompt_title=History<CR>")
        A.map("n", "<Leader>m", ":Telescope keymaps<CR>")
        A.map("n", "<Leader>y", ":Telescope yank_history<CR>")
    end,
}
