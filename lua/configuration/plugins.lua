local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

mason_install = {
    -- lua stuff
    "lua-language-server",
    "stylua",
    "rust-analyzer",

    -- web dev stuff
    "css-lsp",
    "angular-language-server",
    "html-lsp",
    "typescript-language-server",
    "prettier",
    "prettierd",
}

require("lazy").setup({
    -- rust
    {
      'mrcjkb/rustaceanvim',
      version = '^3',
      ft = { 'rust' },
    },
    {"mfussenegger/nvim-dap"},
    {"rcarriga/nvim-dap-ui"},


    
    -- AI
    { "David-Kunz/gen.nvim" },
    { "MunifTanjim/nui.nvim", lazy = false },

    {
        "jackMort/ChatGPT.nvim",
        event = "VeryLazy",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
        },
        config = function()
            require("chatgpt").setup({
                api_key_cmd = "pass show chatgpt",
            })
        end,
    },
    -- LSP
    { 'saadparwaiz1/cmp_luasnip' },
    {
        'neovim/nvim-lspconfig',
        config = function()
            require("lspconfig").rust_analyzer.setup({
                filetypes = { "rust" },
                root_dir = require("lspconfig/util").root_pattern("Cargo.toml"),
                settings = {
                    cargo = {
                        allFeatures = true,
                    },
                },
            })
        end

    },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/cmp-buffer' },
    { 'hrsh7th/cmp-path' },
    { 'hrsh7th/cmp-cmdline' },
    { 'hrsh7th/nvim-cmp' },
    { "hrsh7th/nvim-cmp",             lazy = false },

    { "williamboman/mason-lspconfig", lazy = false },
    { "nvim-lua/plenary.nvim" },
    { "L3MON4D3/LuaSnip",             lazy = false },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            -- format & linting
            {
                "jose-elias-alvarez/null-ls.nvim",
            },
        },
    },
    {
        "williamboman/mason.nvim",
        cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate" },
        opts = {
            ensure_installed = {
                -- lua stuff
                "lua-language-server",
                "stylua",
                "rust-analyzer",

                -- web dev stuff
                "css-lsp",
                "angular-language-server",
                "html-lsp",
                "typescript-language-server",
                "prettier",
                "prettierd",
            }
        },
        config = function(_, opts)
            require("mason").setup(opts)
            --require("mason-lspconfig").setup()

            local on_attach = function(_, _)
                vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {})
                vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
                vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
                vim.keymap.set("n", "<leader>gi", vim.lsp.buf.implementation, {})
                vim.keymap.set("n", "<leader>gr", require("telescope.builtin").lsp_references, {})
                vim.keymap.set("n", "<leader>K", vim.lsp.buf.hover, {})
            end

            local capabilties = require("cmp_nvim_lsp").default_capabilities()

            require("lspconfig").lua_ls.setup {
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" },
                        },
                        workspace = {
                            library = {
                                [vim.fn.expand "$VIMRUNTIME/lua"] = true,
                                [vim.fn.stdpath "config" .. "/lua"] = true,
                            },
                        },
                    },
                }
            }

            require("lspconfig").solargraph.setup({})
            require("lspconfig").tsserver.setup({})
            require("lspconfig").gopls.setup({})

            vim.api.nvim_create_user_command("MasonInstallAll", function()
                vim.cmd("MasonInstall " .. table.concat(mason_install, " "))
            end, {})
        end,
    },


    -- Flutter Dev
    { "dart-lang/dart-vim-plugin",    lazy = false },
    {
        "akinsho/flutter-tools.nvim",
        lazy = false,
        config = function()
            require("flutter-tools").setup()
        end
    },
    { "tpope/vim-dadbod",             lazy = false },
    { "kristijanhusak/vim-dadbod-ui", lazy = false },


    -- GO Dev
    { "darrikonn/vim-gofmt",          lazy = false },
    {
        "olexsmir/gopher.nvim",
        lazy = false,
        config = function()
            require("flutter-tools").setup {}
        end,
    },


    { "mfussenegger/nvim-jdtls",   lazy = false },
    { "vonHeikemen/lsp-zero.nvim", lazy = false, },



    -- WebDev
    { "jakerobers/vim-hexrgba",    lazy = false },
    {
        "numToStr/Comment.nvim",
        dependencies = "JoosepAlviste/nvim-ts-context-commentstring",
        config = function()
            require("Comment").setup {
                pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
            }
        end,
    },
    { "joeveiga/ng.nvim",       lazy = false },

    -- GeneralDev
    -- Postman
    { "diepm/vim-rest-console", lazy = false },

    -- Movement
    {
        "ggandor/leap.nvim",
        lazy = false,
        config = function()
            require('leap').add_default_mappings()
        end
    },
    {
        "theprimeagen/harpoon",
        lazy = false,
    },
    {
        "max397574/better-escape.nvim",
        event = "InsertEnter",
        config = function()
            require("better_escape").setup()
        end,
    },
    {
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
    },
    {
        "nvim-tree/nvim-web-devicons",
        config = function(_, opts)
            require("nvim-web-devicons").setup(opts)
        end,
    },

    {
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
    },

    { "nvim-telescope/telescope-project.nvim", lazy = false },
    {
        "nvim-telescope/telescope.nvim",
        lazy = false,
        dependencies = { "nvim-treesitter/nvim-treesitter", { "nvim-telescope/telescope-fzf-native.nvim", build = "make" } },
        cmd = "Telescope",
        config = function(_, opts)
            local telescope = require "telescope"
            telescope.setup(opts)
            require 'telescope'.load_extension('project')
        end,
    },


    -- Git
    {
        "kdheepak/lazygit.nvim",
        dependencies = { "nvim-lua/plenary.nvim" }
    },
    {
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
    },

    -- QOL
    {
        "NvChad/nvterm",
        lazy = false,
        config = function()
            require("nvterm").setup({
                terminals = {
                    shell = vim.o.shell,
                    list = {},
                    type_opts = {
                        float = {
                            relative = 'editor',
                            row = 0.3,
                            col = 0.25,
                            width = 0.5,
                            height = 0.4,
                            border = "single",
                        },
                        horizontal = { location = "rightbelow", split_ratio = .3, },
                        vertical = { location = "rightbelow", split_ratio = .5 },
                    }
                },
                behavior = {
                    autoclose_on_quit = {
                        enabled = false,
                        confirm = true,
                    },
                    close_on_exit = true,
                    auto_insert = true,
                },
            })
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        lazy = false,
        opts = function()
            return {
                options = {
                    icons_enabled = true,
                    theme = 'auto',
                    component_separators = { left = '', right = '' },
                    section_separators = { left = '', right = '' },
                    disabled_filetypes = {
                        statusline = {},
                        winbar = {},
                    },
                    ignore_focus = {},
                    always_divide_middle = true,
                    globalstatus = false,
                    refresh = {
                        statusline = 1000,
                        tabline = 1000,
                        winbar = 1000,
                    }
                },
                sections = {
                    lualine_a = { 'mode' },
                    lualine_b = { 'branch', 'diff', 'diagnostics' },
                    lualine_c = { 'filename' },
                    lualine_x = { 'encoding', 'fileformat', 'filetype' },
                    lualine_y = { 'progress' },
                    lualine_z = { 'location' }
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = { 'filename' },
                    lualine_x = { 'location' },
                    lualine_y = {},
                    lualine_z = {}
                },
                tabline = {},
                winbar = {},
                inactive_winbar = {},
                extensions = {}
            }
        end
    },
    {
        'Wansmer/treesj',
        keys = { '<space>m', '<space>j', '<space>s' },
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        config = function()
            require('treesj').setup({ --[[ your config ]] })
        end,
    },
    { "zivyangll/git-blame.vim",               lazy = false },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts={}
    },

    -- autopairing of (){}[] etc
    {
        "windwp/nvim-autopairs",
        opts = {
            fast_wrap = {},
            disable_filetype = { "TelescopePrompt", "vim" },
        },
        config = function(_, opts)
            require("nvim-autopairs").setup(opts)
            -- setup cmp for autopairs
            -- local cmp_autopairs = require "nvim-autopairs.completion.cmp"
            -- require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
    },

    {
        "numToStr/Comment.nvim",
        keys = {
            { "gcc", mode = "n",          desc = "Comment toggle current line" },
            { "gc",  mode = { "n", "o" }, desc = "Comment toggle linewise" },
            { "gc",  mode = "x",          desc = "Comment toggle linewise (visual)" },
            { "gbc", mode = "n",          desc = "Comment toggle current block" },
            { "gb",  mode = { "n", "o" }, desc = "Comment toggle blockwise" },
            { "gb",  mode = "x",          desc = "Comment toggle blockwise (visual)" },
        },
        config = function(_, opts)
            require("Comment").setup(opts)
        end,
    },

    {
        "folke/which-key.nvim",
        keys = { "<leader>", "<c-r>", "<c-w>", '"', "'", "`", "c", "v", "g" },
        cmd = "WhichKey",
        config = function(_, opts)
            require("which-key").setup(opts)
        end,
    },

    -- Themes
    { "xiyaowong/transparent.nvim", 
    lazy=false, 
    config=function()

require("transparent").setup({ -- Optional, you don't have to run setup.
  groups = { -- table: default groups
    'Normal', 'NormalNC', 'Comment', 'Constant', 'Special', 'Identifier',
    'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String', 'Function',
    'Conditional', 'Repeat', 'Operator', 'Structure', 'LineNr', 'NonText',
    'SignColumn', 'CursorLine', 'CursorLineNr', 'StatusLine', 'StatusLineNC',
    'EndOfBuffer',
  },
  extra_groups = {}, -- table: additional groups that should be cleared
  exclude_groups = {}, -- table: groups you don't want to clear
})
    end
    },
    { "https://github.com/doki-theme/doki-theme-vim.git" },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000
    },
}
)
