return {
	"aserowy/tmux.nvim",
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
			},
		})
	end,
}
