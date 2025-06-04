local utils = require("utils")
local lsp = require("lspconfig")
-- local rell_lsp_path = "~/.vscode/extensions/chromaway.rell-language-extension-0.6.7-darwin-arm64/server/"

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = {
        enabled = false,
      },
      servers = {
        cssls = {},

        sqlls = {},

        eslint = {
          settings = {
            workingDirectories = { mode = "auto" },
            experimental = {
              -- allows to use flat config format
              -- useFlatConfig = true,
            },
          },
        },

        ts_ls = {
          enabled = false,
        },

        yamlls = {},

        -- rell = {
        --   cmd = {
        --     rell_lsp_path .. "minimal-jre/bin/java",
        --     "-Duser.language=en",
        --     "-Duser.region=US",
        --     "-jar",
        --     rell_lsp_path .. "rell-language-server-0.4.9.jar",
        --   },
        --   filetypes = { "rell" },
        --   root_dir = lsp.util.root_pattern(".git", ".rell_format"),
        -- },

        denols = {
          filetypes = { "typescript", "typescriptreact" },
          root_dir = function(...)
            return lsp.util.root_pattern("deno.jsonc", "deno.json")(...)
          end,
        },

        svelte = {
          settings = {
            svelte = {
              filetypes = { "typescript", "javascript", "svelte", "html", "css" },
              plugin = {
                svelte = {
                  compilerWarnings = {
                    ["a11y-click-events-have-key-events"] = "ignore",
                    ["a11y-no-static-element-interactions"] = "ignore",
                    ["a11y-no-noninteractive-tabindex"] = "ignore",
                  },
                },
              },
            },
          },
        },

        graphql = {
          settings = {
            filetypes = { "graphql", "typescript", "typescriptreact" },
          },
        },

        solidity_ls_nomicfoundation = {
          settings = {
            cmd = { "nomicfoundation-solidity-language-server", "--stdio" },
            filetypes = { "solidity" },
            single_file_support = true,
          },
        },

        pyright = {
          -- capabilities = (function()
          --   local capabilities = vim.lsp.protocol.make_client_capabilities()
          --   capabilities.textDocument.publishDiagnostics.tagSupport.valueSet = { 2 }
          --   return capabilities
          -- end)(),
          settings = {
            python = {
              analysis = {
                --   autoSearchPaths = true,
                --   diagnosticMode = "openFilesOnly",
                --   useLibraryCodeForTypes = true,
                diagnosticSeverityOverrides = {
                  reportUnusedVariable = "warning",
                },
                --   typeCheckingMode = "off",
              },
              pythonPath = utils.get_venv(),
            },
          },
        },

        ruff_lsp = {
          init_options = { settings = { args = { "--ignore=F403", "--ignore=F405" } } },
        },

        prismals = {},
        --
        -- jedi_language_server = {},
      },
      setup = {
        rust_analyzer = function()
          return true
        end,

        -- eslint = function()
        --   require("lazyvim.util").lsp.on_attach(function(client)
        --     if client.name == "eslint" then
        --       client.server_capabilities.documentFormattingProvider = true
        --     elseif client.name == "tsserver" then
        --       client.server_capabilities.documentFormattingProvider = false
        --     end
        --   end)
        -- end,

        ruff_lsp = function()
          require("lazyvim.util").lsp.on_attach(function(client, _)
            if client.name == "ruff_lsp" then
              -- Disable hover in favor of Pyright
              client.server_capabilities.hoverProvider = false
            end
          end)
        end,

        -- pyright = function()
        --   require("lazyvim.util").lsp.on_attach(function(client, _)
        --     if client.name == "pyright" then
        --       -- disable hover in favor of jedi-language-server
        --       client.server_capabilities.hoverProvider = false
        --     end
        --   end)
        -- end,
      },
    },
  },
}
