local on_init = require("nvchad.configs.lspconfig").on_init
local on_attach = require("nvchad.configs.lspconfig").on_attach
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local plugin_conf = require "configs.overrides"

local servers = plugin_conf.lspconfig

for _, server in ipairs(servers) do
  local serverOpts = {
    -- on_attach = function(client, bufnr)
    --   client.server_capabilities.documentFormattingProvider = false
    --   client.server_capabilities.documentRangeFormattingProvider = false
    --   on_attach(client, bufnr)
    -- end,
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }
  if server == "rust_analyzer" then
    local ok_rt, rust_tools = pcall(require, "rust-tools")
    if not ok_rt then
      print "Failed to load rust tools, will set up `rust_analyzer` without `rust-tools`."
    else
      rust_tools.setup {
        server = serverOpts,
      }
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
