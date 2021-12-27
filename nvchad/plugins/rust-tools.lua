local rust_tools = require "rust-tools"

local M = {}

M.setup = function()
  rust_tools.setup {
    tools = {
      hover_actions = {
        auto_focus = true,
      },
    -- all the opts to send to nvim-lspconfig
    -- these override the defaults set by rust-tools.nvim
    -- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
    },
    server = {
        -- on_attach is a callback called when the language server attachs to the buffer
        on_attach = function(client)
          require'completion'.on_attach(client)
          client.resolved_capabilities.document_formatting = false
          client.resolved_capabilities.document_range_formatting = false
        end,
        settings = {
            -- to enable rust-analyzer settings visit:
            -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
            ["rust-analyzer"] = {
                checkOnSave = {
                    command = "clippy"
                },
            }
        }
    },
  }
end

return M
