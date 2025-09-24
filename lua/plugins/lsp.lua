return {
  { "williamboman/mason.nvim", config = true },
  { "williamboman/mason-lspconfig.nvim", dependencies = { "williamboman/mason.nvim" } },
  { "neovim/nvim-lspconfig" },
  { "hrsh7th/nvim-cmp", dependencies = { "hrsh7th/cmp-nvim-lsp" } },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },
  { "L3MON4D3/LuaSnip", dependencies = { "saadparwaiz1/cmp_luasnip" } },
  config = function()
    local mason_lspconfig = require("mason-lspconfig")
    mason_lspconfig.setup({
      ensure_installed = { "typescript-language-server" }, -- Node.js LSP
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
