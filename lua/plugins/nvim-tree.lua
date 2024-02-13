return {
	"nvim-tree/nvim-tree.lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	keys = { "<C-e>" },
	config = function()
		A.map("n", "<C-e>", ":NvimTreeToggle<CR>")

		local function nvim_tree_on_attach(bufnr)
			local api = require("nvim-tree.api")

			local function opts(desc)
				return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
			end

			api.config.mappings.default_on_attach(bufnr)

			A.map("n", "h", api.node.navigate.parent_close, opts("Close Directory"))
			A.map("n", "l", api.node.open.replace_tree_buffer, opts("Open: In Place"))
			A.map("n", "<BS>", api.tree.change_root_to_parent, opts("Up"))
			A.map("n", "<C-s>", api.node.open.horizontal, opts("Open: Horizontal Split"))
			A.map("n", "?", api.tree.toggle_help, opts("Help"))

			A.del("n", "<C-e>", { buffer = bufnr })
			A.del("n", "<C-x>", { buffer = bufnr })
		end

		require("nvim-tree").setup({
			actions = {
				open_file = { quit_on_open = true },
			},
			renderer = {
				indent_markers = { enable = true },
			},
			respect_buf_cwd = true,
			on_attach = nvim_tree_on_attach,
			sync_root_with_cwd = true,
			update_focused_file = { enable = true, update_root = true },
			view = { width = { min = 35 } },
		})
	end,
}
