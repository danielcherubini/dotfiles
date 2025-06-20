local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    go = { "gofmt" },
    rust = { "rustfmt" },
    css = { "prettierd" },
    html = { "prettierd", "prettier" },
    javascript = { "prettierd", "prettier" },
    typescript = { "prettierd", "prettier" },
    json = { "prettierd", "prettier" },
    python = { "ruff_fix", "isort", "black" },
    java = { "prettierd", "prettier" },
    markdown = { "prettierd" },
    sql = { "sql_formatter", "sqlfluff" },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

require("conform").setup(options)
