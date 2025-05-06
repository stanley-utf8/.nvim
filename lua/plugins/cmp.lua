return {
  {
    "saghen/blink.cmp",
    opts = {
      keymap = {
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<C-j>"] = { "select_next", "fallback" },
        ["<C-s>"] = { "select_and_accept", "fallback" },
        ["<A-e>"] = { "hide", "fallback" },
        ["<Tab>"] = { "select_and_accept" },
        ["<Tab>"] = {
          function(cmp)
            if cmp.snippet_active() then
              return cmp.accept()
            else
              return cmp.select_and_accept()
            end
          end,
          "snippet_forward",
          "fallback",
        },
        ["<S-Tab>"] = { "snippet_backward", "fallback" },
        ["<C-b>"] = { "scroll_documentation_up", "fallback" },
        ["<C-f>"] = { "scroll_documentation_down", "fallback" },
        ["<C-S-D>"] = { "show", "show_documentation", "hide_documentation" },
        ["<CR>"] = {},
      },
      cmdline = {
        keymap = {
          ["<C-k>"] = { "select_prev", "fallback" },
          ["<C-j>"] = { "select_next", "fallback" },
          ["<C-s>"] = { "select_and_accept" },
        },
        sources = { "lsp", "path", "snippets", "buffer" },
      },

      completion = {
        list = {
          selection = { auto_insert = true },
        },
        ghost_text = {
          enabled = false,
        },
        menu = {
          draw = {
            -- columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind" } },
          },
        },
      },
    },
  },
  {
    "hrsh7th/nvim-cmp",
    event = "VeryLazy", -- Change event to CmdlineEnter
    enabled = true,
    dependencies = {
      "hrsh7th/cmp-cmdline", -- Add cmdline source
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
    },
    opts = function()
      local cmp = require("cmp")
      return {
        enabled = function()
          -- Only enable in cmdline
          local ctx = require("cmp.config.context")
          return vim.api.nvim_get_mode().mode == "c"
        end,
        completion = {
          completeopt = "menu,menuone,noinsert",
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-e>"] = cmp.mapping(function()
            return vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-o>A", true, true, true), "n", true)
          end),

          ["<C-s>"] = cmp.mapping({
            c = cmp.mapping.confirm({ select = true }),
          }),

          ["<Tab>"] = cmp.mapping({
            c = cmp.mapping.confirm({ select = true }),
          }),

          ["<C-d>"] = cmp.mapping({
            c = cmp.mapping.select_next_item({
              -- behavior = cmp.SelectBehavior.Insert,
              behavior = cmp.SelectBehavior.Select,
            }),
          }),
          ["<C-q>"] = cmp.mapping({
            c = cmp.mapping.select_prev_item({
              -- behavior = cmp.SelectBehavior.Insert,
              behavior = cmp.SelectBehavior.Select,
            }),
          }),
          ["<C-j>"] = cmp.mapping({
            c = cmp.mapping.select_next_item({
              -- behavior = cmp.SelectBehavior.Insert,
              behavior = cmp.SelectBehavior.Select,
            }),
          }),
          ["<C-k>"] = cmp.mapping({
            c = cmp.mapping.select_prev_item({
              -- behavior = cmp.SelectBehavior.Insert,
              behavior = cmp.SelectBehavior.Select,
            }),
          }),

          ["<M-j>"] = cmp.mapping({
            c = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          }),
          ["<M-k>"] = cmp.mapping({
            c = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          }),
        }),
      }
    end,
    config = function(_, opts)
      local cmp = require("cmp")
      cmp.setup(opts)

      -- Setup for search
      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline({
          ["<C-q>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-d>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-s>"] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Insert }),
          ["<Tab>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = {
          { name = "buffer" },
        },
      })

      -- Setup for commands
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline({
          ["<C-q>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-d>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-s>"] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Insert }),
          ["<Tab>"] = cmp.mapping.confirm({ select = true }),
        }),

        sources = cmp.config.sources({
          { name = "path" },
          { name = "cmdline" },
        }),
      })
    end,
  },
}
