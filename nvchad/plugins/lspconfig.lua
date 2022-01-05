local M = {}

M.setup_lsp = function(attach, capabilities)
   local lsp_installer = require "nvim-lsp-installer"

   lsp_installer.on_server_ready(function(server)
      local opts = {
         on_attach = function(client, bufnr)
           client.resolved_capabilities.document_formatting = false
           client.resolved_capabilities.document_range_formatting = false
           attach(client, bufnr)
         end,
         capabilities = capabilities,
         flags = {
            debounce_text_changes = 150,
         },
         settings = {},
      }

      if server.name == "rust_analyzer" then
        require("rust-tools").setup {
          server = vim.tbl_deep_extend("force", server:get_default_options(), opts, {
            ["rust-analyzer"] = {
              experimental = {
                procAttrMacros = true,
              },
              checkOnSave = {
                command = "clippy",
              },
            },
          }),
        }
        server:attach_buffers()
      else
        server:setup(opts)
        vim.cmd [[ do User LspAttachBuffers ]]
      end
   end)
end

return M
