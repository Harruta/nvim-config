return {
  { "williamboman/mason.nvim", config = true },
  { "williamboman/mason-lspconfig.nvim", dependencies = { "williamboman/mason.nvim" } },
  { "neovim/nvim-lspconfig" },
  { "hrsh7th/nvim-cmp", dependencies = { "hrsh7th/cmp-nvim-lsp" } },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },
  { "L3MON4D3/LuaSnip", dependencies = { "saadparwaiz1/cmp_luasnip" } },
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
  end,
}
