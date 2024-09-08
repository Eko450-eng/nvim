return {
    "nvim-treesitter/nvim-treesitter",
    config = function()
        require("nvim-treesitter.configs").setup {
            ensure_installed = {
                "gdscript",
                "godot_resource",
                "slint",
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
            },
            auto_install = true,
        }
    end
}
