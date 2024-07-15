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

require("lazy").setup("configuration.plugins", {
	change_detection = {
		notify = false,
	},
})

--return {
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
--}
