local on_init = require("nvchad.configs.lspconfig").on_init
local on_attach = require("nvchad.configs.lspconfig").on_attach
local capabilities = require("nvchad.configs.lspconfig").capabilities
local init_options = require("nvchad.configs.lspconfig").init_options

local lspconfig = require "lspconfig"
local plugin_conf = require "configs.overrides"

local home = os.getenv "HOME"
local mason_path = home .. "/.local/share/nvim/mason"

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
    init_options = init_options,
  }
  -- if server == "rust_analyzer" then
  --   local ok_rt, rust_tools = pcall(require, "rust-tools")
  --   if not ok_rt then
  --     print "Failed to load rust tools, will set up `rust_analyzer` without `rust-tools`."
  --   else
  --     rust_tools.setup {
  --       server = serverOpts,
  --     }
  --     -- We don't want to call lspconfig.rust_analyzer.setup() when using
  --     -- rust-tools. See
  --     -- * https://github.com/simrat39/rust-tools.nvim/issues/183
  --     -- * https://github.com/simrat39/rust-tools.nvim/issues/177
  --     goto continue
  --   end
  -- end:want
  if server == "rust_analyzer" then
    vim.g.rustaceanvim = {
      -- Plugin configuration
      tools = {},
      -- LSP configuration
      server = {
        on_attach = on_attach,
        default_settings = {
          ["rust-analyzer"] = {
            displayInlayHints = true,
            inlayHints = {
              enable = true,
            },
          },
        },
      },
      -- DAP configuration
      dap = {},
    }
    -- serverOpts.settings = {
    --   ["rust-analyzer"] = {
    --     displayInlayHints = true,
    --     inlayHints = {
    --       enable = true,
    --     },
    --   },
    -- }
    -- goto continue
  end

  if server == "jdtls" then
    -- serverOpts.filetypes = { "java", "groovy" }
    serverOpts.on_attach = function(client, bufnr)
      on_attach(client, bufnr)

      require("jdtls").setup_dap { hotcodereplace = "auto" }
    end
    serverOpts.init_options = {
      bundles = {
        home .. "/.local/share/java/com.microsoft.java.debug.plugin-0.52.0.jar",
        home .. "/.local/share/java/lombok.jar",
        -- home .. "/.local/share/java/groovy-language-server-all.jar",
      },
    }
  end

  if server == "groovyls" then
    serverOpts.cmd = { "groovy-language-server" }
    -- serverOpts.settings = {
    --   groovy = {
    --     classpath = {
    --       "/lib",
    --       "/build/libs",
    --       "/web/build/libs",
    --     },
    --   },
    -- }
  end

  if server == "pyright" then
    serverOpts.on_attach = function(client, _)
      -- Disable all capabilities except hoverProvider
      -- client.server_capabilities.completionProvider = false
      -- client.server_capabilities.definitionProvider = false
      -- client.server_capabilities.typeDefinitionProvider = false
      -- client.server_capabilities.implementationProvider = false
      -- client.server_capabilities.referencesProvider = false
      -- client.server_capabilities.documentSymbolProvider = false
      -- client.server_capabilities.workspaceSymbolProvider = false
      -- client.server_capabilities.codeActionProvider = false
      -- client.server_capabilities.documentFormattingProvider = false
      -- client.server_capabilities.documentRangeFormattingProvider = false
      -- client.server_capabilities.renameProvider = false
      -- client.server_capabilities.signatureHelpProvider = false
      -- client.server_capabilities.documentHighlightProvider = false
      -- client.server_capabilities.foldingRangeProvider = false
      -- client.server_capabilities.semanticTokensProvider = false
      -- client.server_capabilities.declarationProvider = false
      -- client.server_capabilities.callHierarchyProvider = false
      -- client.server_capabilities.diagnosticProvider = false

      -- Enable hoverProvider
      client.server_capabilities.hoverProvider = true
    end
    serverOpts.capabilities = (function()
      capabilities.textDocument.publishDiagnostics.tagSupport.valueSet = { 2 }
      return capabilities
    end)()
    serverOpts.settings = {
      python = {
        analysis = {
          ignore = { "*" },
        },
      },
    }
  end

  if server == "ruff" then
    serverOpts.on_attach = function(client, _)
      if client.name == "ruff" then
        -- disable hover in favor of pyright
        client.server_capabilities.hoverProvider = false
        client.server_capabilities.diagnosticProvider = {
          interFileDependencies = false,
          workspaceDiagnostics = true,
        }
      end
    end

    serverOpts.settings = {
      configurationPreference = "filesystemFirst",
    }
  end

  lspconfig[server].setup(serverOpts)
  ::continue::
end

require("sonarlint").setup {
  server = {
    cmd = {
      "sonarlint-language-server",
      "-stdio",
      "-analyzers",
      vim.fn.expand(mason_path .. "/share/sonarlint-analyzers/sonarpython.jar"),
      vim.fn.expand(mason_path .. "/share/sonarlint-analyzers/sonarcfamily.jar"),
      vim.fn.expand(mason_path .. "/share/sonarlint-analyzers/sonarjava.jar"),
    },
  },
  filetypes = {
    -- Tested and working
    "cpp",
    "java",
  },
}

-- require("lspsaga").setup {}
