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

local js_based_languages = {
  "typescript",
  "javascript",
  "typescriptreact",
  "javascriptreact",
  "vue",
}


require("lazy").setup({

    --          ╭─────────────────────────────────────────────────────────╮
    --          │                          rust                           │
    --          ╰─────────────────────────────────────────────────────────╯
    {
        'mrcjkb/rustaceanvim',
        version = '^3',
        ft = { 'rust' },
    },


    --          ╭─────────────────────────────────────────────────────────╮
    --          │                        Debugging                        │
    --          ╰─────────────────────────────────────────────────────────╯

    { 'nvim-neotest/nvim-nio' },
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")

      vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

      for _, language in ipairs(js_based_languages) do
        dap.configurations[language] = {
          -- Debug single nodejs files
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch file",
            program = "${file}",
            cwd = vim.fn.getcwd(),
            sourceMaps = true,
          },
          -- Debug nodejs processes (make sure to add --inspect when you run the process)
          {
            type = "pwa-node",
            request = "attach",
            name = "Attach",
            processId = require("dap.utils").pick_process,
            cwd = vim.fn.getcwd(),
            sourceMaps = true,
          },
          -- Debug web applications (client side)
          {
            type = "pwa-chrome",
            request = "launch",
            name = "Launch & Debug Chrome",
            url = function()
              local co = coroutine.running()
              return coroutine.create(function()
                vim.ui.input({
                  prompt = "Enter URL: ",
                  default = "http://localhost:3000",
                }, function(url)
                  if url == nil or url == "" then
                    return
                  else
                    coroutine.resume(co, url)
                  end
                end)
              end)
            end,
            webRoot = vim.fn.getcwd(),
            protocol = "inspector",
            sourceMaps = true,
            userDataDir = false,
          },
          -- Divider for the launch.json derived configs
          {
            name = "----- ↓ launch.json configs ↓ -----",
            type = "",
            request = "launch",
          },
        }
      end
    end,
    keys = {
      {
        "<leader>dO",
        function()
          require("dap").step_out()
        end,
        desc = "Step Out",
      },
      {
        "<leader>do",
        function()
          require("dap").step_over()
        end,
        desc = "Step Over",
      },
      {
        "<leader>da",
        function()
          if vim.fn.filereadable(".vscode/launch.json") then
            local dap_vscode = require("dap.ext.vscode")
            dap_vscode.load_launchjs(nil, {
              ["pwa-node"] = js_based_languages,
              ["chrome"] = js_based_languages,
              ["pwa-chrome"] = js_based_languages,
            })
          end
          require("dap").continue()
        end,
        desc = "Run with Args",
      },
    },
    dependencies = {
      -- Install the vscode-js-debug adapter
      {
        "microsoft/vscode-js-debug",
        -- After install, build it and rename the dist directory to out
        build = "pnpm install --no-save && npx gulp vsDebugServerBundle && rm -rf out && mv dist out",
        version = "1.*",
      },
      {
        "mxsdev/nvim-dap-vscode-js",
        config = function()
          ---@diagnostic disable-next-line: missing-fields
          require("dap-vscode-js").setup({
            -- Path of node executable. Defaults to $NODE_PATH, and then "node"
            -- node_path = "node",

            -- Path to vscode-js-debug installation.
            debugger_path = vim.fn.resolve(vim.fn.stdpath("data") .. "/lazy/vscode-js-debug"),

            -- Command to use to launch the debug server. Takes precedence over "node_path" and "debugger_path"
            -- debugger_cmd = { "js-debug-adapter" },

            -- which adapters to register in nvim-dap
            adapters = {
              "chrome",
              "pwa-node",
              "pwa-chrome",
              "pwa-msedge",
              "pwa-extensionHost",
              "node-terminal",
            },

            -- Path for file logging
            -- log_file_path = "(stdpath cache)/dap_vscode_js.log",

            -- Logging level for output to file. Set to false to disable logging.
            -- log_file_level = false,

            -- Logging level for output to console. Set to false to disable console output.
            -- log_console_level = vim.log.levels.ERROR,
          })
        end,
      },
      {
        "Joakker/lua-json5",
        build = "./install.sh",
      },
    },
  },
    {
        "mxsdev/nvim-dap-vscode-js",
        dependencies = "mfussenegger/nvim-dap"
    },
    {
        "rcarriga/nvim-dap-ui",
        event = "VeryLazy",
        dependencies = "mfussenegger/nvim-dap",
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")
            require("dapui").setup()

            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
            end
        end
    },

    --          ╭─────────────────────────────────────────────────────────╮
    --          │                           AI                            │
    --          ╰─────────────────────────────────────────────────────────╯
    -- { "David-Kunz/gen.nvim" },
    -- { "MunifTanjim/nui.nvim", lazy = false },
    --
    -- {
    --     "jackMort/ChatGPT.nvim",
    --     event = "VeryLazy",
    --     dependencies = {
    --         "MunifTanjim/nui.nvim",
    --         "nvim-lua/plenary.nvim",
    --         "nvim-telescope/telescope.nvim",
    --     },
    --     config = function()
    --         require("chatgpt").setup({
    --             api_key_cmd = "pass show chatgpt",
    --         })
    --     end,
    -- },

    --          ╭─────────────────────────────────────────────────────────╮
    --          │                           LSP                           │
    --          ╰─────────────────────────────────────────────────────────╯
    { 'slint-ui/vim-slint' },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/cmp-buffer' },
    { 'hrsh7th/cmp-path' },
    { 'hrsh7th/cmp-cmdline' },
    { "hrsh7th/nvim-cmp",     lazy = false },
    { "nvim-lua/plenary.nvim" },

    { 'neovim/nvim-lspconfig' },
    { "nvim-lua/plenary.nvim" },
    { "L3MON4D3/LuaSnip",     lazy = false },
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
        lazy = false,
        cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate" },
    },
    {
        "williamboman/mason-lspconfig",
        requires = {
            'williamboman/mason.nvim'
        }
    },


    --          ╭─────────────────────────────────────────────────────────╮
    --          │                       Flutter Dev                       │
    --          ╰─────────────────────────────────────────────────────────╯
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


    --          ╭─────────────────────────────────────────────────────────╮
    --          │                         GO Dev                          │
    --          ╰─────────────────────────────────────────────────────────╯
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



    --          ╭─────────────────────────────────────────────────────────╮
    --          │                         WebDev                          │
    --          ╰─────────────────────────────────────────────────────────╯
    { "chrisbra/vim-xml-runtime",  lazy = false },
    { "alvan/vim-closetag",        lazy = false },
    { "joeveiga/ng.nvim",          lazy = false },
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

    --          ╭─────────────────────────────────────────────────────────╮
    --          │                         Postman                         │
    --          ╰─────────────────────────────────────────────────────────╯
    { "diepm/vim-rest-console", lazy = false },

    --          ╭─────────────────────────────────────────────────────────╮
    --          │                        Movement                         │
    --          ╰─────────────────────────────────────────────────────────╯
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


    --          ╭─────────────────────────────────────────────────────────╮
    --          │                           Git                           │
    --          ╰─────────────────────────────────────────────────────────╯
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

    --          ╭─────────────────────────────────────────────────────────╮
    --          │                           QOL                           │
    --          ╰─────────────────────────────────────────────────────────╯
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
            require('treesj').setup({})
        end,
    },
    { "zivyangll/git-blame.vim",               lazy = false },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {}
    },

    --          ╭─────────────────────────────────────────────────────────╮
    --          │                       autopairing                       │
    --          ╰─────────────────────────────────────────────────────────╯
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

    --          ╭─────────────────────────────────────────────────────────╮
    --          │                         Themes                          │
    --          ╰─────────────────────────────────────────────────────────╯
    {
        "xiyaowong/transparent.nvim",
        lazy = false,
        config = function()
            require("transparent").setup({ -- Optional, you don't have to run setup.
                groups = {                 -- table: default groups
                    'Normal', 'NormalNC', 'Comment', 'Constant', 'Special', 'Identifier',
                    'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String', 'Function',
                    'Conditional', 'Repeat', 'Operator', 'Structure', 'LineNr', 'NonText',
                    'SignColumn', 'CursorLine', 'CursorLineNr', 'StatusLine', 'StatusLineNC',
                    'EndOfBuffer',
                },
                extra_groups = {},   -- table: additional groups that should be cleared
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
