vim.g.mapleader = " "
vim.g.maplocalleader = "\\"


local o = vim.o

o.expandtab = true
o.smartindent = true
o.tabstop = 2
o.shiftwidth = 2
o.number = true
o.numberwidth = 2
o.signcolumn = "yes:1"

require("config.lazy")
require("mason").setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
  },
})

require("mason-lspconfig").setup({
  ensure_installed = {
    "lua_ls",
    "gopls",
    "ts_ls",
  },
})

require("mason-lspconfig").setup_handlers({
  function(server_name)
    require("lspconfig")[server_name].setup({})
  end,

  ["lua_ls"] = function()
    require("lspconfig").lua_ls.setup({
      capabilities = require('cmp_nvim_lsp').default_capabilities(),
      settings = {
        Lua = {
          diagnostics = {
            globals = {
              "vim",
              "require",
            },
          },
          workspace = {
            -- Make the server aware of Neovim runtime files
            library = vim.api.nvim_get_runtime_file("", true),
          },
        },
      },
    })
  end,

  ["gopls"] = function()
    require("lspconfig").gopls.setup({
      capabilities = require('cmp_nvim_lsp').default_capabilities(),
      settings = {
        gopls = {
          usePlaceholders = true,
        }
      }
    })
  end
})

require("nvim-treesitter.configs").setup({
  -- A list of parser names, or "all" (the listed parsers MUST always be installed)
  ensure_installed = {
    "c",
    "lua",
    "vim",
    "vimdoc",
    "query",
    "markdown",
    "markdown_inline",
    "go",
    "typescript",
    "json",
    "tsx",
    "javascript",
    "sql",
    "css",
    "html",
  },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = true,
  auto_install = false,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },

  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["af"] = "@call.outer",
        ["if"] = "@call.inner",

        ["aF"] = "@function.outer",
        ["iF"] = "@function.inner",

        ["aa"] = "@parameter.outer",
        ["ia"] = "@parameter.inner",

        ["ac"] = "@conditional.outer",
        ["ic"] = "@conditional.inner",
      }
    }  
  }
})

require("neo-tree").setup({
  window = {
    width = 30,
    auto_expand_width = true,
  },
  event_handlers = {
    {
      event = "file_open_requested",
      handler = function()
        require("neo-tree.command").execute({ action = "close" })
      end,
    },
  },
})

require("luasnip.loaders.from_lua").load({paths = "~/.config/nvim/LuaSnip/"})

require('lualine').setup({
  options = {
    globalstatus = true,
  },
  sections = {
    lualine_b = {},
    lualine_x = {
      "lsp_progress",
      "diagnostics"
    }
  },
})

require("keymaps")
