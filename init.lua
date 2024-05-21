vim.g.mapleader = ' '

local function bind(opt, outer_opt)
    outer_opt = outer_opt or {noremap = true}
    return function(lhs, rhs, opts)
        opts = vim.tbl_extend("force", outer_opts, opts or {})
        vim.keymap.set(op, lhs, rhs, opts)
    end
end

require('configuration.lazy')
--require('configuration.options')
require('configuration.mappings')
require('configuration.lspconfig')

vim.cmd([[colorscheme catppuccin]])
