return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        eslint = {},

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
      },
      setup = {
        eslint = function()
          require("lazyvim.util").lsp.on_attach(function(client)
            if client.name == "eslint" then
              client.server_capabilities.documentFormattingProvider = true
            elseif client.name == "tsserver" then
              client.server_capabilities.documentFormattingProvider = false
            end
          end)
        end,
      },
    },
  },
}
