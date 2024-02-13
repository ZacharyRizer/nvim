return {
	"tpope/vim-fugitive",
	config = function()
		vim.api.nvim_create_user_command("Diff", function(input)
			local branch = input.args ~= "" and input.args or "main"
			vim.cmd("Gvdiffsplit! " .. branch)
		end, { nargs = "?" })
		vim.cmd([[command! -nargs=0 Blame G blame]])
		vim.cmd([[command! -nargs=0 Merge G mergetool]])
	end,
}
