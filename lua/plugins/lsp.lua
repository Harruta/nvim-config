-- plugins/lsp.lua
return {
  { "williamboman/mason.nvim", config = true },
  { "williamboman/mason-lspconfig.nvim", dependencies = { "williamboman/mason.nvim" } },
  { "neovim/nvim-lspconfig" },
  { "jose-elias-alvarez/null-ls.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
  config = function()
    -- Diagnostics configuration
    vim.diagnostic.config({
      virtual_text = {
        prefix = "●",
        severity = vim.diagnostic.severity.ERROR,
        spacing = 4,
      },
      signs = {
        active = true,
        values = {
          { name = "DiagnosticSignError", text = "" },
          { name = "DiagnosticSignWarn", text = "" },
          { name = "DiagnosticSignInfo", text = "" },
          { name = "DiagnosticSignHint", text = "" },
        },
      },
      underline = {
        severity = vim.diagnostic.severity.ERROR,
      },
      update_in_insert = true,
      severity_sort = true,
      float = {
        border = "rounded",
      },
    })

    -- Mason-LSPconfig: Ensure LSP servers are installed
    require("mason-lspconfig").setup({
      ensure_installed = { "tsserver", "lua_ls" }, -- Install LSPs for JS/TS and Lua
      automatic_installation = true,
    })

    -- LSP server configurations
    local lspconfig = require("lspconfig")
    local servers = {
      tsserver = {
        filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "tsx" },
      },
      lua_ls = {
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" }, -- Recognize 'vim' global for Neovim configs
            },
          },
        },
      },
    }

    for server, config in pairs(servers) do
      config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
      lspconfig[server].setup(config)
    end

    -- null-ls for additional diagnostics/formatting
    local null_ls = require("null-ls")
    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.prettier, -- For JS/TS formatting
        null_ls.builtins.diagnostics.eslint_d, -- For JS/TS linting
      },
    })
  end,
}
