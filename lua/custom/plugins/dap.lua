-- spell-checker: disable

local present, dap = pcall(require, "dap")

if not present then
  return
end

local logger = require("custom.log").create_logger "dap-custom-rust"

local M = {}

M.setup = function()
  dap.set_log_level "TRACE"

  dap.adapters.cppdbg = {
    id = "cppdbg",
    type = "executable",
    command = "/Users/ganitzsh/Dev/cpptools/extension/debugAdapters/bin/OpenDebugAD7",
    options = { detached = false },
  }

  dap.adapters.codelldb = {
    type = "server",
    port = "${port}",
    executable = {
      command = "/Users/ganitzsh/Dev/codelldb/extension/adapter/codelldb",
      args = { "--port", "${port}" },
    },
  }

  dap.configurations.rust = {
    {
      name = "Launch test",
      type = "codelldb",
      request = "launch",
      program = function()
        local test_name = vim.fn.input("Test name: ", "")
        local cargo_test_cmd = "cargo test " .. test_name .. "--no-run --message-format=json -q"
        local cmd = string.format(
          "%s | jq -r 'select(.target.kind[0] == \"bin\") | .executable' | tr -d '\n'",
          cargo_test_cmd
        )

        local handle = io.popen(cmd)
        if handle == nil then
          print "Failed to run cargo test"
          return nil
        end

        local result = handle:read "*a"
        handle:close()

        logger.debug("Launch test", result, cmd)

        return result
      end,
      cwd = "${workspaceFolder}",
      stopAtEntry = true,
    },
  }
end

return M
