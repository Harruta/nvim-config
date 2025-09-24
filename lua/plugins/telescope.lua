return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  cmd = "Telescope",
  keys = {
    { "<leader>ff", "<cmd>Telescope find_files<cr>" },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>" },
    { "<leader>fb", "<cmd>Telescope buffers<cr>" },
  },
  opts = {
    defaults = {
      winblend = 0, -- Transparent windows
      layout_strategy = "horizontal",
      layout_config = { prompt_position = "top" },
    },
  },
}
