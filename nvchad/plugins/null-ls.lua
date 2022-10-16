local null_ls = require "null-ls"

local b = null_ls.builtins
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local sources = {
   -- Rust
   b.formatting.rustfmt.with({
    extra_args = function(params)
      local cargo_toml = params.root .. "/" .. "Cargo.toml"
      local fd = vim.loop.fs_open(cargo_toml, "r", 438)
      if not fd then
        return
      end
      local stat = vim.loop.fs_fstat(fd)
      local data = vim.loop.fs_read(fd, stat.size, 0)
      vim.loop.fs_close(fd)
      for _, line in ipairs(vim.split(data, "\n")) do
        local edition = line:match([[^edition%s*=%s*%"(%d+)%"]])
        -- regex maybe wrong.
        if edition then
          return { "--edition=" .. edition }
        end
      end
    end
  }),

   -- Go
   b.formatting.gofmt,
   b.formatting.goimports,

   -- Kotlin
   b.diagnostics.ktlint,
   b.formatting.ktlint,
}

null_ls.setup {
  debug = true,
  sources = sources,

  -- format on save
  on_attach = function(client, bufnr)
      if client.supports_method("textDocument/formatting") then
          vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
          vim.api.nvim_create_autocmd("BufWritePre", {
              group = augroup,
              buffer = bufnr,
              callback = function()
                  -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
                  vim.lsp.buf.formatting_sync()
              end,
          })
      end
  end,
}

