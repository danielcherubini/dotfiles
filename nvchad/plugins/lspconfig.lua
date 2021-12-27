local M = {}

M.setup_lsp = function(attach, capabilities)
  local lspconfig = require "lspconfig"


  -- lspconfig.rust_analyzer.setup {
  --   on_attach = function(client)
  --     require'completion'.on_attach(client)
  --     client.resolved_capabilities.document_formatting = false
  --     client.resolved_capabilities.document_range_formatting = false
  --   end,
  --   settings = {
  --     ["rust-analyzer"] = {
  --       assist = {
  --         importGranularity = "module",
  --         importPrefix = "by_self",
  --       },
  --       cargo = {
  --         loadOutDirsFromCheck = true
  --       },
  --       procMacro = {
  --      enable = true
  --       },
  --     }
  --   }
  -- }


  lspconfig.gopls.setup {}
end

return M
