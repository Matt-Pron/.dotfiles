return {
	{
		"nvim-lua/plenary.nvim",
		name = "plenary"
	},

	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"plenary"
		}
	},

	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
	},

    "tpope/vim-fugitive",
}
