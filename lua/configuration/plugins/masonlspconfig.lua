return {
    "williamboman/mason-lspconfig",
    lazy = false,
    requires = {
        'williamboman/mason.nvim'
    },
    config = function()
        -- local mason_registry = require('mason-registry')

        local lspconfig = require('lspconfig')
        -- local vue_language_server_path = mason_registry.get_package('vue-language-server'):get_install_path() .. '/node_modules/@vue/language-server'
        local vue_language_server_path = "/home/eko/node_modules/.pnpm/.pnpm/5/node_modules/@vue/typescript-plugin"

        lspconfig.slint_lsp.setup {
            filetypes = { 'slint' },
        }


        lspconfig.pyright.setup {
            filetypes = { 'python' }
        }

        lspconfig.biome.setup {
            filetypes = { 'json', 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
        }

        lspconfig.tsserver.setup {
            init_options = {
                plugins = {
                    {
                        name = '@vue/typescript-plugin',
                        location = "/home/eko/node_modules/.pnpm/.pnpm/5/node_modules/@vue/typescript-plugin",
                        languages = { 'vue' },
                    },
                },
            },
            filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
        }

        lspconfig.rust_analyzer.setup({
            filetypes = { "rust" },
            root_dir = require("lspconfig/util").root_pattern("Cargo.toml"),
            cmd = { "/home/eko/.nix-profile/bin/rust-analyzer" },
            settings = {
                cargo = {
                    allFeatures = true,
                },
            },
        })


        lspconfig.volar.setup({})


        lspconfig.lua_ls.setup {
            on_init = function(client)
                local path = client.workspace_folders[1].name
                if vim.loop.fs_stat(path .. '/.luarc.json') or vim.loop.fs_stat(path .. '/.luarc.jsonc') then
                    return
                end

                client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
                    runtime = {
                        version = 'LuaJIT'
                    },
                    workspace = {
                        checkThirdParty = false,
                        library = {
                            vim.env.VIMRUNTIME
                        }
                    }
                })
            end,
            settings = {
                Lua = {}
            }
        }
    end
}
