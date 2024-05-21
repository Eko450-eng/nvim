return {
    "kdheepak/lazygit.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    "lewis6991/gitsigns.nvim",
    ft = { "gitcommit", "diff" },
    init = function()
        -- load gitsigns only when a git file is opened
        vim.api.nvim_create_autocmd({ "BufRead" }, {
            group = vim.api.nvim_create_augroup("GitSignsLazyLoad", { clear = true }),
            callback = function()
                vim.fn.system("git -C " .. '"' .. vim.fn.expand "%:p:h" .. '"' .. " rev-parse")
                if vim.v.shell_error == 0 then
                    vim.api.nvim_del_augroup_by_name "GitSignsLazyLoad"
                    vim.schedule(function()
                        require("lazy").load { plugins = { "gitsigns.nvim" } }
                    end)
                end
            end,
        })
    end,
    config = function(_, opts)
        require("gitsigns").setup(opts)
    end,
    "zivyangll/git-blame.vim",
}
