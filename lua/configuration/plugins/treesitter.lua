return {
    "nvim-treesitter/nvim-treesitter",
    config = function()
        require("nvim-treesitter.configs").setup {
            ensure_installed = {
                "vim",
                "lua",
                "html",
                "css",
                "javascript",
                "typescript",
                "tsx",
                "c",
                "markdown",
                "markdown_inline",
                "python",
                "rust",
            }
        }
    end
}
