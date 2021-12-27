local M = {}

M.setup_lsp = function(attach, capabilities)
  local lspconfig = require "lspconfig"

  local servers = { "rust_analyzer", "gopls" }
  for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
      on_attach = function(client)
        client.resolved_capabilities.document_formatting = false
        client.resolved_capabilities.document_range_formatting = false
      end,
    }   
  end
end

return M
