-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.lazyvim_completion_engine = "blink.cmp"

-- Or create a new file: ~/.config/nvim/lua/plugins/completion.lua
return {
  {
    "LazyVim/LazyVim",
    opts = {
      completion_engine = "blink.cmp",
    },
  },
}
