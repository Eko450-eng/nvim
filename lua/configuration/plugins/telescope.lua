return {
    "nvim-telescope/telescope-project.nvim",
    "nvim-telescope/telescope.nvim",
    lazy = false,
    dependencies = { "nvim-treesitter/nvim-treesitter", { "nvim-telescope/telescope-fzf-native.nvim", build = "make" } },
    cmd = "Telescope",
    config = function(_, opts)
        local telescope = require "telescope"
        telescope.setup(opts)
        require 'telescope'.load_extension('project')
    end,
}
