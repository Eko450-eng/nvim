-- local on_attach = function(_, _)
-- end
--
-- local capabilties = require("cmp_nvim_lsp").default_capabilities()

require("mason-lspconfig").setup({})
local mason = require("mason")

local opts = {
    ensure_installed = {
        "slint-lsp",
        "clangd",
        "volar",
        "lua-language-server",
        "js-debug-adapter",
        "stylua",
        "rust-analyzer",
        "css-lsp",
        "angular-language-server",
        "html-lsp",
        "typescript-language-server",
        "prettier",
        "prettierd",
        "codelldb",
        "vue-language-server",
        "pyright",
    },
    servers = {
        -- Ensure mason installs the server
        clangd = {
            keys = {
                { "<leader>ch", "<cmd>ClangdSwitchSourceHeader<cr>", desc = "Switch Source/Header (C/C++)" },
            },
            root_dir = function(fname)
                return require("lspconfig.util").root_pattern(
                    "Makefile",
                    "configure.ac",
                    "configure.in",
                    "config.h.in",
                    "meson.build",
                    "meson_options.txt",
                    "build.ninja"
                )(fname) or require("lspconfig.util").root_pattern("compile_commands.json", "compile_flags.txt")(
                    fname
                ) or require("lspconfig.util").find_git_ancestor(fname)
            end,
            capabilities = {
                offsetEncoding = { "utf-16" },
            },
            cmd = {
                "clangd",
                "--background-index",
                "--clang-tidy",
                "--header-insertion=iwyu",
                "--completion-style=detailed",
                "--function-arg-placeholders",
                "--fallback-style=llvm",
            },
            init_options = {
                usePlaceholders = true,
                completeUnimported = true,
                clangdFileStatus = true,
            },
        },
    },
    setup = {
        clangd = function(_, opts)
            local clangd_ext_opts = LazyVim.opts("clangd_extensions.nvim")
            require("clangd_extensions").setup(vim.tbl_deep_extend("force", clangd_ext_opts or {}, { server = opts }))
            return false
        end,
    },
}
mason.setup(opts)


vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {})
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
vim.keymap.set("n", "<leader>gi", vim.lsp.buf.implementation, {})
-- vim.keymap.set("n", "<leader>gr", require("telescope.builtin").lsp_references, {})
vim.keymap.set("n", "<leader>K", vim.lsp.buf.hover, {})


--          ╭─────────────────────────────────────────────────────────╮
--          │                          Mason                          │
--          ╰─────────────────────────────────────────────────────────╯
