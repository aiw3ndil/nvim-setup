local neotest = require "neotest"

neotest.setup {
  adapters = {
    require "neotest-python" {
      dap = { justMyCode = false },
      runner = "pytest",
    },
  },
  status = { virtual_text = true },
  output = { open_on_run = true },
  quickfix = {
    open = function()
      local ok, trouble = pcall(require, "trouble")
      if ok then
        trouble.open { mode = "quickfix" }
      else
        vim.cmd "copen"
      end
    end,
  },
}
