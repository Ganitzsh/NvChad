local present, dap = pcall(require, "dap")

if not present then
  return
end

local M = {}

local node2_config = {
  {
    name = "Launch",
    type = "node2",
    request = "launch",
    program = "${file}",
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = "inspector",
    console = "integratedTerminal",
  },
  {
    -- For this to work you need to make sure the node process is started with the `--inspect` flag.
    name = "Attach to process",
    type = "node2",
    request = "attach",
    processId = require("dap.utils").pick_process,
  },
}

M.setup = function()
  dap.adapters.firefox = {
    type = "executable",
    command = "node",
    args = { os.getenv "HOME" .. "/Dev/vscode-firefox-debug/dist/adapter.bundle.js" },
  }

  dap.configurations.typescript = {
    {
      name = "Debug with Firefox",
      type = "firefox",
      request = "launch",
      reAttach = true,
      url = "http://localhost:3000",
      webRoot = "${workspaceFolder}",
      firefoxExecutable = "/Applications/Firefox.app/Contents/MacOS/firefox",
    },
  }

  dap.adapters.node2 = {
    type = "executable",
    command = "node",
    args = { os.getenv "HOME" .. "/Dev/microsoft/vscode-node-debug2/out/src/nodeDebug.js" },
  }
end

return M
