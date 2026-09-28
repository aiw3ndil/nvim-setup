-- Compatibility & warning guard for legacy Neovim (< 0.11)
if vim.fn.has "nvim-0.11" == 0 then
  vim.lsp.config = vim.lsp.config or function() end
  vim.lsp.enable = vim.lsp.enable or function() end

  vim.schedule(function()
    local local_nvim = vim.fn.expand "~/.local/bin/nvim"
    local notice = "⚠️  Estás ejecutando Neovim antiguo ("
      .. tostring(vim.version())
      .. " en "
      .. vim.v.progpath
      .. ").\n"
      .. "NvChad y nvim-lspconfig requieren Neovim 0.11+.\n"
    if vim.fn.executable(local_nvim) == 1 then
      notice = notice .. "Por favor ejecuta Neovim actualizado: " .. local_nvim .. " (v0.12.5)"
    end
    vim.notify(notice, vim.log.levels.WARN, { title = "Neovim Outdated" })
  end)
end

vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "autocmds"
require "mappings"
