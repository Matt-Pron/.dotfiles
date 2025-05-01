return {
    {
        "nvim-lua/plenary.nvim",
        name = "plenary"
    },

    "tpope/vim-fugitive",
    {
        "MeanderingProgrammer/render-markdown.nvim",
        enabled = true,
        opts = {},
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' },
    },
    {
        "iamcco/markdown-preview.nvim",
        cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
        build = 'cd app && yarn install',
        keys = {},
        init = function()
            vim.g.mkdp_filetypes = { 'markdown' }
        end,
        ft = { 'markdown' },
    },
}
