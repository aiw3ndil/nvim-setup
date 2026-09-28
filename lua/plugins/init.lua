return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = require "configs.conform",
  },

  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- Mason & Automatic tool installer
  {
    "williamboman/mason.nvim",
    opts = {
      PATH = "prepend",
      ui = {
        border = "rounded",
        icons = {
          package_pending = " ",
          package_installed = " ",
          package_uninstalled = " ",
        },
      },
    },
  },

  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = {
        "lua_ls",
        "bashls",
        "dockerls",
        "docker_compose_language_service",
        "jsonls",
        "yamlls",
        "marksman",
        "pyright",
        "ts_ls",
        "html",
        "cssls",
      },
      automatic_installation = true,
    },
  },

  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "williamboman/mason.nvim" },
    event = "VeryLazy",
    opts = {
      ensure_installed = {
        -- LSP servers
        "lua-language-server",
        "bash-language-server",
        "dockerfile-language-server",
        "docker-compose-language-service",
        "json-lsp",
        "yaml-language-server",
        "marksman",
        "pyright",
        "typescript-language-server",
        "html-lsp",
        "css-lsp",

        -- Formatters & Linters
        "stylua",
        "shfmt",
        "shellcheck",
        "prettier",
        "ruff",

        -- Debuggers
        "debugpy",
      },
      auto_update = false,
      run_on_start = true,
      start_delay = 500,
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "bash",
        "dockerfile",
        "json",
        "yaml",
        "markdown",
        "markdown_inline",
        "python",
        "javascript",
        "typescript",
        "regex",
        "toml",
        "gitignore",
      },
      highlight = {
        enable = true,
        use_languagetree = true,
      },
      indent = {
        enable = true,
      },
    },
  },

  -- Schemas for JSON and YAML (Kubernetes, Compose, Workflows, package.json, etc.)
  {
    "b0o/schemastore.nvim",
    lazy = true,
  },

  -- Trouble: pretty diagnostics and quickfix lists
  {
    "folke/trouble.nvim",
    cmd = { "Trouble" },
    opts = {},
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / References (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },

  -- Todo comments: highlight and search TODO, NOTE, FIX, HACK
  {
    "folke/todo-comments.nvim",
    event = "User FilePost",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
    keys = {
      {
        "]t",
        function()
          require("todo-comments").jump_next()
        end,
        desc = "Next Todo Comment",
      },
      {
        "[t",
        function()
          require("todo-comments").jump_prev()
        end,
        desc = "Previous Todo Comment",
      },
      { "<leader>ft", "<cmd>TodoTelescope<cr>", desc = "Find TODOs" },
      { "<leader>xt", "<cmd>Trouble todo toggle<cr>", desc = "Todo (Trouble)" },
    },
  },

  -- Autoclose and autorename HTML/JSX tags
  {
    "windwp/nvim-ts-autotag",
    event = "User FilePost",
    opts = {},
  },

  -- Lazygit GUI inside Neovim
  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit GUI" },
    },
  },

  -- DAP (Debug Adapter Protocol)
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      { "rcarriga/nvim-dap-ui", dependencies = { "nvim-neotest/nvim-nio" } },
      { "theHamsta/nvim-dap-virtual-text" },
      { "jay-babu/mason-nvim-dap.nvim", dependencies = { "williamboman/mason.nvim" } },
      { "mfussenegger/nvim-dap-python" },
    },
    config = function()
      require "configs.dap"
    end,
  },

  -- Neotest (Unit test runner)
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-neotest/neotest-python",
    },
    config = function()
      require "configs.neotest"
    end,
  },

  -- Sticky headers for classes and functions
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "User FilePost",
    opts = {
      max_lines = 3,
      multiline_threshold = 1,
    },
  },

  -- Surround actions: add, delete, change quotes/delimiters
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    opts = {},
  },

  -- Project-wide search and replace
  {
    "MagicDuck/grug-far.nvim",
    cmd = "GrugFar",
    opts = { headerMaxWidth = 80 },
  },

  -- Git visual diffs and merge conflicts
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles", "DiffviewFileHistory" },
  },

  -- Sleek UI for input prompts and select menus
  {
    "stevearc/dressing.nvim",
    lazy = false,
    opts = {},
  },

  -- Auto-save and restore workspace sessions
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {},
  },
}
