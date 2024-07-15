return {
    'rcarriga/nvim-notify',
    config = function()
        vim.o.termguicolors = true
        vim.opt.termguicolors = true
        require("notify").setup({
            background_colour = "#000000",
            enabled = false,
        })
    end
}
