return {
  {
    "catppuccin/nvim",
    lazy = false,
    name = "catppuccin",
    config = function()
      require("catppuccin").setup({
        flavour = "mocha", -- latte, frappe, macchiato, mocha
      })
    end,
  },
  -- {
  --   "gambhirsharma/vesper.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   name = "vesper",
  -- },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
