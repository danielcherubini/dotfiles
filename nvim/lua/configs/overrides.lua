local M = {}

-- overriding default plugin configs!
M.treesitter = {
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
    "cpp",
    "go",
    "rust",
    "kotlin",
    "groovy",
    "python",
    "bash",
    "sql",
    "cmake",
  },
}

M.nvimtree = {
  git = {
    enable = true,
  },
}

M.mason = {
  pkgs = {
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
    "checkstyle",
    "google-java-format",
    "prettier",
    "groovy-language-server",
    "gradle-language-server",
    "pyright",
    "ruff",
    "ty",
    "isort",
    "bash-language-server",
    "sonarlint-language-server",
    "clang-format",
  },
}

M.lspconfig = {
  "lua_ls",
  "rust_analyzer",
  "gopls",
  "jdtls",
  "yamlls",
  "eslint",
  "html",
  "ts_ls",
  "kotlin_language_server",
  "groovyls",
  "ty",
  -- "pyright",
  "bashls",
  "clangd", -- Added for ESP32/C++ development
}

M.cmp = function()
  local cmp = require "cmp"
  return {
    mapping = {
      ["<Up>"] = cmp.mapping.select_prev_item(),
      ["<Down>"] = cmp.mapping.select_next_item(),
      ["<S-Tab>"] = cmp.config.disable,
    },
  }
end

return M
