local nvlsp = require "nvchad.configs.lspconfig"
nvlsp.defaults()

local servers = {
  "html",
  "cssls",
  "bashls",
  "dockerls",
  "docker_compose_language_service",
  "marksman",
  "pyright",
  "ts_ls",
}

vim.lsp.enable(servers)

-- Extra keybindings on LSP attach
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local function opts(desc)
      return { buffer = bufnr, desc = "LSP " .. desc }
    end

    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts "Code Action")
    vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, opts "Rename Symbol")
    vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts "Line Diagnostics")
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts "Go to Implementation")
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts "Go to References")

    -- Toggle Inlay Hints (Neovim 0.10+)
    if vim.lsp.inlay_hint then
      vim.keymap.set("n", "<leader>ci", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = bufnr }, { bufnr = bufnr })
      end, opts "Toggle Inlay Hints")
    end
  end,
})

-- Diagnostic styling & icons
vim.diagnostic.config {
  virtual_text = {
    prefix = "●",
    spacing = 2,
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.INFO] = " ",
      [vim.diagnostic.severity.HINT] = "󰌵 ",
    },
  },
  float = {
    border = "rounded",
    source = "always",
  },
}

-- Configure Schemastore for JSON and YAML
local ok, schemastore = pcall(require, "schemastore")
if ok then
  vim.lsp.config("jsonls", {
    settings = {
      json = {
        schemas = schemastore.json.schemas(),
        validate = { enable = true },
      },
    },
  })

  vim.lsp.config("yamlls", {
    settings = {
      yaml = {
        schemaStore = {
          enable = false,
          url = "",
        },
        schemas = schemastore.yaml.schemas(),
      },
    },
  })
end

vim.lsp.enable { "jsonls", "yamlls" }
