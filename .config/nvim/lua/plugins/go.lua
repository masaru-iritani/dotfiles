return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      gopls = {
        settings = {
          gopls = {
            hints = {
              assignVariableTypes = false,
              compositeLiteralTypes = false,
              compositeLiteralFields = false,
              parameterNames = false,
              rangeVariableTypes = false,
            },
          },
        },
      },
    },
  },
}
