local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    go = { "gofmt" },
    rust = { "rustfmt" },
    css = { "prettierd" },
    html = { "prettierd", "prettier" },
    javascript = { "prettierd", "prettier" },
    json = { "prettierd" },
    python = { "ruff_fix", "ruff_format" },
    java = { "prettierd", "prettier" },
    markdown = { "prettierd" },
    sql = { "sql_formatter", "sqlfluff" },
    c = { "clang_format" },
    cpp = { "clang_format" },
  },

  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

return options
