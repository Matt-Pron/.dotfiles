return {
	{
		"sainnhe/gruvbox-material",
		name = "gruvbox-material",
        lazy = false,
        priority = 1000,
		config = function()
            vim.g.gruvbox_material_background = 'hard'
            vim.g.gruvbox_material_transparent_background = 1
            vim.g.gruvbox_material_ui_contrast = 'high'
			vim.cmd("colorscheme gruvbox-material")
		end
	},
	--[[{
		"ellisonleao/gruvbox.nvim",
		name = "gruvbox",
		config = function()
            require("gruvbox").setup({
                contrast = "hard",
            })
            vim.o.background = dark
			vim.cmd("colorscheme gruvbox")
		end
	},]]--
}
