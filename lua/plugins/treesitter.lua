return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = { "javascript", "typescript", "tsx", "lua", "markdown" }, -- Parsers for JS/TS/TSX/Lua/Markdown files
      auto_install = true, -- Auto-install missing parsers
      highlight = {
        enable = true,
        disable = function(lang, buf)
          local max_filesize = 100 * 1024 -- Disable for large files > 100 KB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end
        end,
        additional_vim_regex_highlighting = false, -- Avoid conflicts with LSP
      },
      incremental_selection = { enable = true }, -- Optional: Better selection with v
      textobjects = { enable = true }, -- Optional: Better text objects (e.g., functions)
    })

    -- Custom highlight for syntax errors (@error capture)
    vim.api.nvim_set_hl(0, "@error", { fg = "#FF0000", bg = nil, undercurl = true }) -- Red text with squiggle underline
  end,
}
