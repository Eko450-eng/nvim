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
},


require("lazy").setup({
      -- LSP
      {'saadparwaiz1/cmp_luasnip'},
      { 'neovim/nvim-lspconfig'},
      { 'hrsh7th/cmp-nvim-lsp'},
      { 'hrsh7th/cmp-buffer'},
      { 'hrsh7th/cmp-path'},
      { 'hrsh7th/cmp-cmdline'},
      { 'hrsh7th/nvim-cmp'},
      {"hrsh7th/nvim-cmp", lazy=false},

      {"williamboman/mason-lspconfig", lazy=false},
      {"nvim-lua/plenary.nvim"},
      {"L3MON4D3/LuaSnip", lazy=false},
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

      -- vim.api.nvim_create_user_command("MasonInstallAll", function()
      --   vim.cmd("MasonInstall " .. table.concat(mason_install, " "))
      -- end, {})

      --vim.g.mason_binaries_list = opts.ensure_installed
    end,
  },


  -- Flutter Dev
  { "dart-lang/dart-vim-plugin", lazy=false },
  {
      "akinsho/flutter-tools.nvim", 
      lazy=false,
      config = function()
        require("flutter-tools").setup()
    end
  },
  {"tpope/vim-dadbod", lazy=false},
  {"kristijanhusak/vim-dadbod-ui", lazy=false},

    
  -- GO Dev
  {"darrikonn/vim-gofmt", lazy=false},
  {
    "olexsmir/gopher.nvim", lazy=false,
      config = function()
          require("flutter-tools").setup {}
      end,
  },


  {"mfussenegger/nvim-jdtls", lazy=false},
  {"vonHeikemen/lsp-zero.nvim", lazy=false,},



  -- WebDev
  {"jakerobers/vim-hexrgba", lazy=false},
  {
      "numToStr/Comment.nvim",
      dependencies = "JoosepAlviste/nvim-ts-context-commentstring",
      config = function()
          require("Comment").setup {
              pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
          }
      end,
  },
  { "joeveiga/ng.nvim", lazy = false },

  -- GeneralDev
  -- Postman
  {"diepm/vim-rest-console", lazy= false},

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
      require("nvim-tree").setup{
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

  {"nvim-telescope/telescope-project.nvim", lazy=false},
  {
    "nvim-telescope/telescope.nvim",
    lazy=false,
    dependencies = { "nvim-treesitter/nvim-treesitter", { "nvim-telescope/telescope-fzf-native.nvim", build = "make" } },
    cmd = "Telescope",
    config = function(_, opts)
      local telescope = require "telescope"
      telescope.setup(opts)
      require'telescope'.load_extension('project')
    end,
  },


  -- Git
  {
      "kdheepak/lazygit.nvim",
      dependencies = {"nvim-lua/plenary.nvim"}
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
    "lukas-reineke/indent-blankline.nvim",
    version = "2.20.7",
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
      { "gcc", mode = "n", desc = "Comment toggle current line" },
      { "gc", mode = { "n", "o" }, desc = "Comment toggle linewise" },
      { "gc", mode = "x", desc = "Comment toggle linewise (visual)" },
      { "gbc", mode = "n", desc = "Comment toggle current block" },
      { "gb", mode = { "n", "o" }, desc = "Comment toggle blockwise" },
      { "gb", mode = "x", desc = "Comment toggle blockwise (visual)" },
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
  { "https://github.com/doki-theme/doki-theme-vim.git"},
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
}
)



