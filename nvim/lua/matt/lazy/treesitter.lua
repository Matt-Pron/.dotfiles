return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",

    config = function()
        ensure_installed = { "javascript", "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" }
        sync_install = false
        auto_install = true
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
        }
    end
}
