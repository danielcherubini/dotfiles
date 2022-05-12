local M = {}

M.setup_lsp = function(attach, capabilities)
  local lspconfig = require "lspconfig"
  local servers = {
    "eslint",
    "jsonls",
    "rust_analyzer",
    "sumneko_lua",
    "gopls",
    "tsserver",
    "yamlls",
  }

  for _, server in ipairs(servers) do
    local serverOpts = {
      on_attach = function(client, bufnr)
        client.resolved_capabilities.document_formatting = false
        client.resolved_capabilities.document_range_formatting = false
        attach(client, bufnr)
      end,
      capabilities = capabilities,
    }
    if server == "rust_analyzer" then
      local ok_rt, rust_tools = pcall(require, "rust-tools")
      if not ok_rt then
        print("Failed to load rust tools, will set up `rust_analyzer` without `rust-tools`.")
      else
        rust_tools.setup({
          server = serverOpts,
        })
        -- We don't want to call lspconfig.rust_analyzer.setup() when using
        -- rust-tools. See
        -- * https://github.com/simrat39/rust-tools.nvim/issues/183
        -- * https://github.com/simrat39/rust-tools.nvim/issues/177
        goto continue
      end
    end

    lspconfig[server].setup(serverOpts)
    ::continue::
  end
end

return M
