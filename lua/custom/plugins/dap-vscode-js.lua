local present, dap = pcall(require, "dap")

if not present then
  return
end

local M = {}

M.setup = function()
  require("dap-vscode-js").setup {
    -- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
    -- debugger_cmd = { "js-debug-adapter" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
    debgugger_path = { os.getenv "HOME" .. "/Dev/vscode-js-debug" },
    adapters = {
      "pwa-node",
      -- "pwa-chrome",
      -- "pwa-msedge",
      -- "node-terminal",
      -- "pwa-extensionHost",
    }, -- which adapters to register in nvim-dap
  }

  for _, language in ipairs { "typescript", "javascript" } do
    dap.configurations[language] = {
      -- {
      --   type = "pwa-node",
      --   request = "launch",
      --   name = "Launch file",
      --   program = "${file}",
      --   cwd = "${workspaceFolder}",
      -- },
      -- {
      --   type = "pwa-node",
      --   request = "attach",
      --   name = "Attach",
      --   processId = require("dap.utils").pick_process,
      --   cwd = "${workspaceFolder}",
      -- },
      {
        type = "pwa-node",
        request = "launch",
        name = "Debug Jest Tests",
        -- trace = true, -- include debugger info
        runtimeExecutable = "node",
        runtimeArgs = {
          "./node_modules/jest/bin/jest.js",
          "--runInBand",
        },
        rootPath = "${workspaceFolder}",
        cwd = "${workspaceFolder}",
        console = "integratedTerminal",
        internalConsoleOptions = "neverOpen",
      },
    }
  end
end

return M
