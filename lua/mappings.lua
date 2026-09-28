require "nvchad.mappings"

local map = vim.keymap.set

-- Command mode shortcut
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>", { desc = "Exit insert mode" })

-- Better navigation and centering
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center" })
map("n", "n", "nzzzv", { desc = "Next search result and center" })
map("n", "N", "Nzzzv", { desc = "Prev search result and center" })

-- Move selected lines up and down in visual mode
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line up" })

-- Save & Quit shortcuts
map({ "n", "i", "v" }, "<C-s>", "<cmd>w<CR>", { desc = "Save file" })
map("n", "<leader>qq", "<cmd>qa<CR>", { desc = "Quit all" })

-- Splits management
map("n", "<leader>sv", "<cmd>vsplit<CR>", { desc = "Split window vertically" })
map("n", "<leader>sh", "<cmd>split<CR>", { desc = "Split window horizontally" })
map("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
map("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

-- Quick diagnostics toggle
map("n", "<leader>d[", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
map("n", "<leader>d]", vim.diagnostic.goto_next, { desc = "Next diagnostic" })

-- ============================================================================
-- DAP (Debugging) Keymaps
-- ============================================================================
map("n", "<F5>", function()
  require("dap").continue()
end, { desc = "DAP Continue / Start" })

map("n", "<F10>", function()
  require("dap").step_over()
end, { desc = "DAP Step Over" })

map("n", "<F11>", function()
  require("dap").step_into()
end, { desc = "DAP Step Into" })

map("n", "<F12>", function()
  require("dap").step_out()
end, { desc = "DAP Step Out" })

map("n", "<leader>dc", function()
  require("dap").continue()
end, { desc = "DAP Continue / Start" })

map("n", "<leader>do", function()
  require("dap").step_over()
end, { desc = "DAP Step Over" })

map("n", "<leader>di", function()
  require("dap").step_into()
end, { desc = "DAP Step Into" })

map("n", "<leader>dO", function()
  require("dap").step_out()
end, { desc = "DAP Step Out" })

map("n", "<leader>db", function()
  require("dap").toggle_breakpoint()
end, { desc = "DAP Toggle Breakpoint" })

map("n", "<leader>dB", function()
  require("dap").set_breakpoint(vim.fn.input "Breakpoint condition: ")
end, { desc = "DAP Conditional Breakpoint" })

map("n", "<leader>du", function()
  require("dapui").toggle()
end, { desc = "DAP Toggle UI" })

map("n", "<leader>dr", function()
  require("dap").repl.toggle()
end, { desc = "DAP Toggle REPL" })

map("n", "<leader>dl", function()
  require("dap").run_last()
end, { desc = "DAP Run Last" })

map("n", "<leader>dq", function()
  require("dap").terminate()
  require("dapui").close()
end, { desc = "DAP Terminate Session" })

map({ "n", "v" }, "<leader>dh", function()
  require("dap.ui.widgets").hover()
end, { desc = "DAP Hover Evaluate" })

-- ============================================================================
-- Neotest Keymaps
-- ============================================================================
map("n", "<leader>tr", function()
  require("neotest").run.run()
end, { desc = "Test Run Nearest" })

map("n", "<leader>tf", function()
  require("neotest").run.run(vim.fn.expand "%")
end, { desc = "Test Run File" })

map("n", "<leader>td", function()
  require("neotest").run.run { strategy = "dap" }
end, { desc = "Test Debug Nearest (DAP)" })

map("n", "<leader>ts", function()
  require("neotest").summary.toggle()
end, { desc = "Test Toggle Summary" })

map("n", "<leader>to", function()
  require("neotest").output.open { enter = true }
end, { desc = "Test Open Output" })

map("n", "<leader>tO", function()
  require("neotest").output_panel.toggle()
end, { desc = "Test Output Panel" })

map("n", "<leader>tS", function()
  require("neotest").run.stop()
end, { desc = "Test Stop" })

-- ============================================================================
-- Search & Replace Across Project (Grug-Far)
-- ============================================================================
map({ "n", "v" }, "<leader>sr", function()
  local grug = require "grug-far"
  local ext = vim.bo.buftype == "" and vim.fn.expand "%:e"
  grug.open {
    transient = true,
    prefills = {
      filesFilter = ext and ext ~= "" and "*." .. ext or nil,
    },
  }
end, { desc = "Search & Replace in Project" })

map("n", "<leader>sw", function()
  local grug = require "grug-far"
  grug.open {
    transient = true,
    prefills = {
      search = vim.fn.expand "<cword>",
    },
  }
end, { desc = "Search Word in Project" })

-- ============================================================================
-- Git Diffview
-- ============================================================================
map("n", "<leader>gd", "<cmd>DiffviewOpen<CR>", { desc = "Git Diffview Open" })
map("n", "<leader>gh", "<cmd>DiffviewFileHistory %<CR>", { desc = "Git Current File History" })
map("n", "<leader>gH", "<cmd>DiffviewFileHistory<CR>", { desc = "Git Branch History" })
map("n", "<leader>gq", "<cmd>DiffviewClose<CR>", { desc = "Git Diffview Close" })

-- ============================================================================
-- Sessions (Persistence)
-- ============================================================================
map("n", "<leader>qs", function()
  require("persistence").load()
end, { desc = "Restore Directory Session" })

map("n", "<leader>ql", function()
  require("persistence").load { last = true }
end, { desc = "Restore Last Session" })

map("n", "<leader>qd", function()
  require("persistence").stop()
end, { desc = "Don't Save Session on Exit" })

-- ============================================================================
-- Which-Key Group Labels
-- ============================================================================
local ok_wk, wk = pcall(require, "which-key")
if ok_wk then
  wk.add {
    { "<leader>c", group = "Code & LSP" },
    { "<leader>d", group = "Debug (DAP)" },
    { "<leader>t", group = "Test (Neotest)" },
    { "<leader>s", group = "Splits & Search" },
    { "<leader>g", group = "Git" },
    { "<leader>q", group = "Session & Quit" },
    { "<leader>x", group = "Diagnostics / Trouble" },
    { "<leader>f", group = "Find (Telescope)" },
  }
end

-- ============================================================================
-- File Explorer Aliases (:E, :Ex, :Explore)
-- ============================================================================
local function open_explorer(opts)
  local path = (opts.args and opts.args ~= "") and opts.args or nil
  require("nvim-tree.api").tree.open { path = path }
end

vim.api.nvim_create_user_command("E", open_explorer, { nargs = "?", complete = "dir", desc = "Open file explorer (NvimTree)" })
vim.api.nvim_create_user_command("Ex", open_explorer, { nargs = "?", complete = "dir", desc = "Open file explorer (NvimTree)" })
vim.api.nvim_create_user_command("Explore", open_explorer, { nargs = "?", complete = "dir", desc = "Open file explorer (NvimTree)" })
