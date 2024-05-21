-- local on_attach = function(_, _)
-- end
--
-- local capabilties = require("cmp_nvim_lsp").default_capabilities()

require("mason-lspconfig").setup({})
local mason = require("mason")

local opts = {
    ensure_installed = {
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
        "vue-language-server",
    }
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
