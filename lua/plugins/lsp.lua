-- ~/.config/nvim/lua/plugins/lsp.lua
return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- Find and remove the <c-k> keybinding
      for i, key in ipairs(keys) do
        if key[1] == "<c-k>" then
          table.remove(keys, i)
          break
        end
      end
      return opts
    end,
  },
}
