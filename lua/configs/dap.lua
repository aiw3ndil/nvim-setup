local dap = require "dap"
local dapui = require "dapui"

-- Configure DAP UI
dapui.setup()

-- Configure DAP Virtual Text
local ok_virt, dap_virt = pcall(require, "nvim-dap-virtual-text")
if ok_virt then
  dap_virt.setup {
    commented = true,
  }
end

-- Automatically open/close dap-ui on debug session events
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

-- Breakpoint icons and highlights
vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = "#e51400" })
vim.api.nvim_set_hl(0, "DapBreakpointCondition", { fg = "#e5c07b" })
vim.api.nvim_set_hl(0, "DapLogPoint", { fg = "#61afef" })
vim.api.nvim_set_hl(0, "DapStopped", { fg = "#98c379" })

vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointCondition", { text = "◆", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
vim.fn.sign_define("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "▶", texthl = "DapStopped", linehl = "Visual", numhl = "DapStopped" })
vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "DapBreakpoint", linehl = "", numhl = "" })

-- Mason-nvim-dap configuration
local ok_mason_dap, mason_dap = pcall(require, "mason-nvim-dap")
if ok_mason_dap then
  mason_dap.setup {
    ensure_installed = { "python", "bash", "js" },
    automatic_installation = true,
    handlers = {
      function(config)
        mason_dap.default_setup(config)
      end,
      python = function()
        local ok_py, dap_python = pcall(require, "dap-python")
        if ok_py then
          local mason_path = vim.fn.stdpath "data" .. "/mason/packages/debugpy/venv/bin/python"
          if vim.fn.executable(mason_path) == 1 then
            dap_python.setup(mason_path)
          else
            dap_python.setup "python3"
          end
        end
      end,
    },
  }
end

-- Python setup fallback if mason-nvim-dap handler didn't run yet
local ok_py, dap_python = pcall(require, "dap-python")
if ok_py then
  local mason_path = vim.fn.stdpath "data" .. "/mason/packages/debugpy/venv/bin/python"
  if vim.fn.executable(mason_path) == 1 then
    dap_python.setup(mason_path)
  else
    dap_python.setup "python3"
  end
end
