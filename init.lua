-- init.lua
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Basic options
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.background = "dark"

-- Force transparent background (for terminal 0.9 opacity)
vim.api.nvim_set_hl(0, "Normal", { bg = nil, ctermbg = nil })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = nil, ctermbg = nil })
vim.api.nvim_set_hl(0, "NonText", { bg = nil, ctermbg = nil })
vim.api.nvim_set_hl(0, "SignColumn", { bg = nil, ctermbg = nil })
vim.api.nvim_set_hl(0, "LineNr", { bg = nil, ctermbg = nil })
vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = nil, ctermbg = nil })
vim.api.nvim_set_hl(0, "VertSplit", { bg = nil, ctermbg = nil })
vim.api.nvim_set_hl(0, "StatusLine", { bg = nil, ctermbg = nil })
vim.api.nvim_set_hl(0, "StatusLineNC", { bg = nil, ctermbg = nil })

-- Load plugins
require("lazy").setup("plugins")

-- Set a minimal theme (rose-pine for transparency)
vim.cmd("colorscheme rose-pine")
