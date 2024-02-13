return {
	"glepnir/dashboard-nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("dashboard").setup({
			theme = "doom",
			config = {
				center = {
					{ icon = "    ", desc = "Plugin Manager ", action = "Lazy" },
					{ icon = "    ", desc = "LSP Manager ", action = "Mason" },
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