local js_based_languages = {
  "typescript",
  "javascript",
  "typescriptreact",
  "javascriptreact",
  "vue",
}

return {
	-- "mfussenegger/nvim-dap",
	-- dependencies = {
	-- 	"rcarriga/nvim-dap-ui",
	-- 	"microsoft/vscode-js-debug",
	-- },
	-- keys = {
	-- 	-- normal mode is default
	-- 	{ "<leader>d", function() require 'dap'.toggle_breakpoint() end },
	-- 	{ "<leader>c", function() require 'dap'.continue() end },
	-- 	{ "<C-'>",     function() require 'dap'.step_over() end },
	-- 	{ "<C-;>",     function() require 'dap'.step_into() end },
	-- 	{ "<C-:>",     function() require 'dap'.step_out() end },
	-- },
	-- config = function()
	-- 	local dap = require("dap")
	-- 	dap.adapters.chrome = {
	-- 		type = "executable",
	-- 		command = "pwa-vivaldi",
	-- 		args = { os.getenv("HOME") .. "/path/to/vscode-chrome-debug/out/src/chromeDebug.js" } -- TODO adjust
	-- 	}
	--
	-- 	require("dap-vscode-js").setup({
	-- 		debugger_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug",
	-- 		adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' },
	-- 	})
	--
	-- 	for _, language in ipairs({ "typescript", "javascript", "svelte", "vue" }) do
	-- 		require("dap").configurations[language] = {
	-- 			-- attach to a node process that has been started with
	-- 			-- `--inspect` for longrunning tasks or `--inspect-brk` for short tasks
	-- 			-- npm script -> `node --inspect-brk ./node_modules/.bin/vite dev`
	-- 			{
	-- 				-- use nvim-dap-vscode-js's pwa-node debug adapter
	-- 				type = "pwa-node",
	-- 				-- attach to an already running node process with --inspect flag
	-- 				-- default port: 9222
	-- 				request = "attach",
	-- 				-- allows us to pick the process using a picker
	-- 				processId = require 'dap.utils'.pick_process,
	-- 				-- name of the debug action you have to select for this config
	-- 				name = "Attach debugger to existing `node --inspect` process",
	-- 				-- for compiled languages like TypeScript or Svelte.js
	-- 				sourceMaps = true,
	-- 				-- resolve source maps in nested locations while ignoring node_modules
	-- 				resolveSourceMapLocations = {
	-- 					"${workspaceFolder}/**",
	-- 					"!**/node_modules/**" },
	-- 				-- path to src in vite based projects (and most other projects as well)
	-- 				cwd = "${workspaceFolder}/src",
	-- 				-- we don't want to debug code inside node_modules, so skip it!
	-- 				skipFiles = { "${workspaceFolder}/node_modules/**/*.js" },
	-- 			},
	-- 			{
	-- 				type = "pwa-chrome",
	-- 				name = "Launch Chrome to debug client",
	-- 				request = "launch",
	-- 				url = "http://localhost:5173",
	-- 				sourceMaps = true,
	-- 				protocol = "inspector",
	-- 				port = 9222,
	-- 				webRoot = "${workspaceFolder}/src",
	-- 				-- skip files from vite's hmr
	-- 				skipFiles = { "**/node_modules/**/*", "**/@vite/*", "**/src/client/*", "**/src/*" },
	-- 			},
	-- 			-- only if language is javascript, offer this debug action
	-- 			language == "javascript" and {
	-- 				-- use nvim-dap-vscode-js's pwa-node debug adapter
	-- 				type = "pwa-node",
	-- 				-- launch a new process to attach the debugger to
	-- 				request = "launch",
	-- 				-- name of the debug action you have to select for this config
	-- 				name = "Launch file in new node process",
	-- 				-- launch current file
	-- 				program = "${file}",
	-- 				cwd = "${workspaceFolder}",
	-- 			} or nil,
	-- 		}
	-- 	end
	-- 	require("dapui").setup()
	-- 	local dap, dapui = require("dap"), require("dapui")
	-- 	dap.listeners.after.event_initialized["dapui_config"] = function()
	-- 		dapui.open({ reset = true })
	-- 	end
	-- 	dap.listeners.before.event_terminated["dapui_config"] = dapui.close
	-- 	dap.listeners.before.event_exited["dapui_config"] = dapui.close
	-- end
    --
  { "nvim-neotest/nvim-nio" },
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")
      -- dap.adapters.pwa-chrome = {
      --   type = 'executable';
      --   command = os.getenv('HOME') .. '/.virtualenvs/tools/bin/python';
      --   args = { '-m', 'debugpy.adapter' };
      -- }

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
            type = "chrome",
            request = "launch",
            name = "Launch & Debug Chrome",
            -- url = function()
            --   local co = coroutine.running()
            --   return coroutine.create(function()
            --     vim.ui.input({
            --       prompt = "Enter URL: ",
            --       default = "http://localhost:5173",
            --     }, function(url)
            --       if url == nil or url == "" then
            --         return
            --       else
            --         coroutine.resume(co, url)
            --       end
            --     end)
            --   end)
            -- end,
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
        -- build = "pnpm install --legacy-peer-deps --no-save && npx gulp vsDebugServerBundle && rm -rf out && mv dist out",
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
}

