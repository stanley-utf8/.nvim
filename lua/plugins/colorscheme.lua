return {
  -- First item
  -- {
  --   "catppuccin/nvim",
  --   lazy = false,
  --   name = "catppuccin",
  --   config = function()
  --     require("catppuccin").setup({
  --       flavour = "mocha", -- latte, frappe, macchiato, mocha
  --     })
  --   end,
  -- },
  -- Second item
  {
    "gambhirsharma/vesper.nvim",
    lazy = false,
    priority = 1000,
    name = "vesper",
  },
  -- Third item
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "vesper",
    },
  },
}
