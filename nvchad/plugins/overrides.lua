local M = {}

-- overriding default plugin configs!
M.treesitter = {
  override_options = {
    ensure_installed = {
      "lua",
      "vim",
      "html",
      "css",
      "javascript",
      "java",
      "json",
      "toml",
      "markdown",
      "c",
      "go",
      "rust",
      "kotlin",
    },
  },
}

M.nvimtree = {
  override_options = {
    git = {
      enable = true,
    },
  },
}

M.mason = {
  override_options = {
    ensure_installed = {
      "lua-language-server",
      "stylua",
      "rust-analyzer",
      "gopls",
      "goimports",
      "jdtls",
      "json-lsp",
      "yaml-language-server",
      "eslint-lsp",
      "html-lsp",
      "typescript-language-server",
      "shfmt",
      "shellcheck",
      "kotlin-language-server",
      "ktlint",
    },
  },
}

M.lspconfig = {
  "lua_ls",
  "rust_analyzer",
  "gopls",
  "jdtls",
  "jsonls",
  "yamlls",
  "eslint",
  "html",
  "tsserver",
  "kotlin_language_server",
}

M.cmp = {
  override_options = function()
    local cmp = require "cmp"
    return {
      mapping = {
        ["<Up>"] = cmp.mapping.select_prev_item(),
        ["<Down>"] = cmp.mapping.select_next_item(),
      },
    }
  end,
}

return M
