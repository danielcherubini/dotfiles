local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local plugin_conf = require "configs.overrides"

local home = os.getenv "HOME"
local mason_path = home .. "/.local/share/nvim/mason"

local servers = plugin_conf.lspconfig

for _, server in ipairs(servers) do
  local serverOpts = {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }

  -- rustaceanvim handles rust_analyzer setup itself
  if server == "rust_analyzer" then
    vim.g.rustaceanvim = {
      tools = {},
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
      dap = {},
    }
    goto continue
  end

  if server == "jdtls" then
    serverOpts.filetypes = { "java", "groovy" }
    serverOpts.on_attach = function(client, bufnr)
      on_attach(client, bufnr)
      require("jdtls").setup_dap { hotcodereplace = "auto" }
    end
    serverOpts.init_options = {
      bundles = {
        vim.fn.expand(home .. "/dotfiles/java/com.microsoft.java.debug.plugin-0.52.0.jar"),
        vim.fn.expand(home .. "/dotfiles/java/lombok.jar"),
      },
    }

    local jdtls_path = mason_path .. "/packages/jdtls"
    local lombok_path = home .. "/dotfiles/java/lombok.jar"
    local workspace_path = home .. "/.cache/jdtls/workspace"

    serverOpts.cmd = {
      "java",
      "-javaagent:" .. lombok_path,
      "-Declipse.application=org.eclipse.jdt.ls.core.id1",
      "-Dosgi.bundles.defaultStartLevel=4",
      "-Declipse.product=org.eclipse.jdt.ls.core.product",
      "-Dlog.protocol=true",
      "-Dlog.level=ALL",
      "-Xms1g",
      "--add-modules=ALL-SYSTEM",
      "--add-opens",
      "java.base/java.util=ALL-UNNAMED",
      "--add-opens",
      "java.base/java.lang=ALL-UNNAMED",
      "-jar",
      vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar"),
      "-configuration",
      jdtls_path .. "/config_linux",
      "-data",
      workspace_path,
    }
  end

  if server == "pyright" then
    serverOpts.on_attach = function(client, _)
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

  if server == "clangd" then
    serverOpts.cmd = {
      "clangd",
      "--background-index",
      "--clang-tidy",
      "--header-insertion=iwyu",
      "--completion-style=detailed",
      "--function-arg-placeholders",
      "--fallback-style=llvm",
    }
    serverOpts.init_options = {
      usePlaceholders = true,
      completeUnimported = true,
      clangdFileStatus = true,
    }
    serverOpts.root_markers = { "compile_commands.json", ".clangd", ".git", "CMakeLists.txt" }
  end

  vim.lsp.config(server, serverOpts)
  vim.lsp.enable(server)
  ::continue::
end

require("sonarlint").setup {
  server = {
    cmd = {
      "sonarlint-language-server",
      "-stdio",
      "-analyzers",
      vim.fn.expand(mason_path .. "/share/sonarlint-analyzers/sonarjava.jar"),
    },
  },
  filetypes = { "java" },
}
