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
    "go",
    "rust",
    "kotlin",
    "groovy",
  },
}

M.nvimtree = {
  git = {
    enable = true,
  },
}

M.mason = {
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
    "checkstyle",
    "google-java-format",
    "prettier",
    "groovy-language-server",
    "gradle-language-server",
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
  "groovyls",
}

M.cmp = function()
  local cmp = require "cmp"
  return {
    mapping = {
      ["<Up>"] = cmp.mapping.select_prev_item(),
      ["<Down>"] = cmp.mapping.select_next_item(),
    },
  }
end

return M
