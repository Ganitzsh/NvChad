local present, dap = pcall(require, "dap")

if not present then
  return
end

local M = {}

M.setup = function()
  require("dap-vscode-js").setup {
    adapters = {
      "pwa-node",
      "pwa-chrome",
    },
  }

  for _, language in ipairs { "typescript", "javascript" } do
    dap.configurations[language] = {
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
