require("which-key").add {
  { "<leader>db", "<cmd>DapToggleBreakpoint<cr>", desc = "[Debugger] Toggle Breakpoint" },
  { "<leader>dc", "<cmd>DapContinue<cr>", desc = "[Debugger] Show debug configurations" },
  { "<leader>dt", "<cmd>DapTerminate<cr>", desc = "[Debugger] Disconnect debug configurations" },
  { "<leader>du", "<cmd>lua require('dapui').toggle()<cr>", desc = "[Debugger] Toggle DapUI" },
}

local dap, dapui = require "dap", require "dapui"
dap.configurations.java = {
  {
    type = "java",
    request = "attach",
    name = "Debug (Attach) - Remote",
    hostName = "127.0.0.1",
    port = 5005,
  },
}

local dapconfig = {
  layouts = {
    {
      elements = { -- Elements can be strings or table with id and size keys.
        {
          id = "scopes",
          size = 0.25,
        },
        "stacks",
        "watches",
      },
      size = 40,
      position = "left",
    },
    {
      elements = { "repl", "breakpoints" },
      size = 10,
      position = "bottom",
    },
  },
  floating = {
    max_height = nil, -- These can be integers or a float between 0 and 1.
    max_width = nil, -- Floats will be treated as percentage of your screen.
    border = "single", -- Border style. Can be "single", "double" or "rounded"
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
}

dapui.setup(dapconfig)
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
