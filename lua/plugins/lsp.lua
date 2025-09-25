return {
  { "williamboman/mason.nvim", config = true },
  { "williamboman/mason-lspconfig.nvim", dependencies = { "williamboman/mason.nvim" } },
  { "neovim/nvim-lspconfig" },
  { "hrsh7th/nvim-cmp", dependencies = { "hrsh7th/cmp-nvim-lsp" } },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },
  { "L3MON4D3/LuaSnip", dependencies = { "saadparwaiz1/cmp_luasnip" } },
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  config = function()
    -- Treesitter for JS/TS syntax
    require("nvim-treesitter.configs").setup({
      ensure_installed = { "javascript", "typescript" },
      highlight = { enable = true },
    })

    -- Diagnostics configuration
    vim.diagnostic.config({
      virtual_text = {
        prefix = "●", -- Icon for errors
        severity = vim.diagnostic.severity.ERROR, -- Only show errors
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
      underline = true, -- Underline errors in code
      update_in_insert = false,
      severity_sort = true,
    })

    local mason_lspconfig = require("mason-lspconfig")
    mason_lspconfig.setup({
      ensure_installed = { "typescript-language-server" },
    })
    mason_lspconfig.setup_handlers({
      function(server_name)
        require("lspconfig")[server_name].setup({
          capabilities = require("cmp_nvim_lsp").default_capabilities(),
        })
      end,
    })

    -- Basic LSP keymaps
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local bufmap = function(keys, func, desc)
          vim.keymap.set("n", keys, func, { buffer = args.buf, desc = desc })
        end
        bufmap("gd", vim.lsp.buf.definition, "Goto Definition")
        bufmap("K", vim.lsp.buf.hover, "Hover")
        bufmap("<leader>ca", vim.lsp.buf.code_action, "Code Action")
        bufmap("<leader>e", vim.diagnostic.open_float, "Show Diagnostics")
      end,
    })

    -- Completion setup
    local cmp = require("cmp")
    cmp.setup({
      snippet = { expand = function(args) require("luasnip").lsp_expand(args.body) end },
      mapping = cmp.mapping.preset.insert({
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
      }, {
        { name = "buffer" },
        { name = "path" },
      }),
    })
  end,
}
