---------------------------------- Plug-Ins ------------------------------------

local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

local ensure_packer = function()
    if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
        vim.fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

-- Autocommand that reloads neovim whenever you save the plugins.lua file
local packer_refresh = Augroup("PackerRefresh", { clear = true })
Autocmd("BufWritePost", {
    pattern = "plugins.lua",
    command = "source <afile> | PackerSync",
    group = packer_refresh
})

-- Use a protected call so we don't error out on first use
local status_ok, _ = pcall(require, "packer")
if not status_ok then
    return
end

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    ---- Cache for lua plugins: Nvim start time
    use { 'lewis6991/impatient.nvim' }

    ---- LSP, Completions, Git, Telescope
    use { 'nvim-lua/plenary.nvim' }
    use { 'nvim-telescope/telescope.nvim' }
    use { 'nvim-telescope/telescope-fzy-native.nvim', run = 'make' }
    use { 'fannheyward/telescope-coc.nvim' }
    use { 'ahmedkhalf/project.nvim' }
    use { 'neoclide/coc.nvim', branch = 'release' }
    use { 'tpope/vim-fugitive' }

    ---- Theme and Formatting
    use { 'folke/tokyonight.nvim' }
    use { 'nvim-lualine/lualine.nvim' }
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use { 'nvim-treesitter/nvim-treesitter-context' }
    use { 'kyazdani42/nvim-web-devicons' }
    use { 'lukas-reineke/indent-blankline.nvim' }
    use { 'windwp/nvim-autopairs' }
    use { 'windwp/nvim-ts-autotag' }

    ---- UI Elements
    use { 'ThePrimeagen/harpoon' }
    use { 'glepnir/dashboard-nvim' }
    use { 'kyazdani42/nvim-tree.lua' }
    use { 'mbbill/undotree' }
    use { 'akinsho/toggleterm.nvim' }
    use { 'gbprod/yanky.nvim' }
    use { 'numToStr/Comment.nvim' }
    use { 'kylechui/nvim-surround' }

    ---- Tmux-Vim Integration
    use { 'aserowy/tmux.nvim' }

    if packer_bootstrap then
        require('packer').sync()
    end

    require('impatient').enable_profile()
end)
