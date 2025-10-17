return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.servers = opts.servers or {}
      opts.servers.clangd = opts.servers.clangd or {}
      opts.servers.clangd.cmd = {
        "/opt/homebrew/opt/llvm/bin/clangd", -- Homebrew’s clangd
        "--query-driver=/opt/homebrew/bin/g++-15",
      }
    end,
  },
}
