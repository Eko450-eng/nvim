return {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    config = function(_, opts)
        require("nvim-tree").setup {
            git = {
                enable = true,
            },

            renderer = {
                highlight_git = true,
                icons = {
                    show = {
                        git = true,
                    },
                },
            },
        }
    end,
}
