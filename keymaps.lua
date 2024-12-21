-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- MOVEMENT

-- basic movement enhancements
map({ "n", "v" }, "H", "^") -- move to start of line
map({ "n", "v" }, "L", "$") -- move to end of line
map({ "n", "v" }, "<M-H>", "H") -- move to top of screen
map({ "n", "v" }, "<M-L>", "L") -- move to bottom of screen

-- centered scrolling
map("n", "<C-u>", "<C-u>zz") -- half page up centered
map("n", "<C-d>", "<C-d>zz") -- half page down centered
map("n", "n", "nzzzv") -- next search result centered
map("n", "N", "Nzzzv") -- previous search result centered

-- jump navigation
map("n", "<M-q>", "<C-o>") -- jump back
map("n", "<M-d>", "<C-i>") -- jump forward

-- insert mode remaps
map("i", "<C-a>", "<C-o>I") -- start of line
map("i", "<C-e>", "<C-o>A") -- end of line

map("i", "<C-.>", vim.lsp.buf.signature_help, { desc = "Signature Help" })
map("i", "<C-,>", "<C-j>")

map("i", "<C-k>", "<up>")
map("i", "<C-j>", "<down>")
map("i", "<C-h>", "<left>")
map("i", "<C-l>", "<right>")

-- EDITING

-- basic editing
map("n", "<CR>", "ciw") -- change inner word
map("i", "kj", "<ESC>l") -- exit insert mode
map("i", "<M-d>", "<space><Esc>ce") -- delete in front of cursor

-- CLIPBOARD

map({ "n", "x" }, "<leader>p", [["0p]]) -- paste from yank register
map("n", "<leader>yc", "yy<cmd>normal gcc<CR>p") -- duplicate and comment
map("v", "<leader>yc", "ygvgc`>p") -- duplicate and comment (visual)

-- SEARCH & REPLACE

map("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]]) -- search and replace
map("v", "/", '"fy/\\V<C-R>f<CR>') -- search and replace in vis

-- COMMAND MODE

map("n", ";", ":", { desc = "CMD enter command mode" })
map("n", ":", ";", { desc = "repeat find" })
map("c", "<M-e>", "<Up>") -- command history up
map("c", "<M-f>", "<Down>") -- command history down

-- TERMINAL
map("t", "<C-[>", "<C-\\><C-n>") -- exit terminal mode
map("t", "<C-q>", "<C-\\><C-n>:q<CR>") -- quit terminal window

-- Move Lines
map("n", "<M-j>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
map("n", "<M-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
map("i", "<M-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
map("i", "<M-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
map("v", "<M-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })
map("v", "<M-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })

-- buffers

map("n", "<S-Tab>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "<Tab>", "<cmd>bnext<cr>", { desc = "Next Buffer" })

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- commenting
map("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Below" })
map("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Above" })

-- new file
map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

map("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Location List" })
map("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Quickfix List" })

map("n", "[q", vim.cmd.cprev, { desc = "Previous Quickfix" })
map("n", "]q", vim.cmd.cnext, { desc = "Next Quickfix" })

-- formatting (lint file)
map({ "n", "v" }, "<leader>cf", function()
  LazyVim.format({ force = true })
end, { desc = "Format" })

-- diagnostic
local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
map("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
map("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
map("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
map("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
map("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
map("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })

-- quit
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit All" })

-- floating terminal
map("n", "<M-/>", function()
  Snacks.terminal()
end, { desc = "Terminal (cwd)" })
map("n", "<leader>ft", function()
  Snacks.terminal(nil, { cwd = LazyVim.root() })
end, { desc = "Terminal (Root Dir)" })
map("n", "<c-/>", function()
  Snacks.terminal(nil, { cwd = LazyVim.root() })
end, { desc = "Terminal (Root Dir)" })
map("n", "<c-_>", function()
  Snacks.terminal(nil, { cwd = LazyVim.root() })
end, { desc = "which_key_ignore" })

-- Terminal Mappings
map("t", "<M-/>", "<cmd>close<cr>", { desc = "Hide Terminal" })
map("t", "<c-_>", "<cmd>close<cr>", { desc = "which_key_ignore" })

-- windows
map("n", "<leader>w", "<c-w>", { desc = "Windows", remap = true })
map("n", "<leader>-", "<C-W>s", { desc = "Split Window Below", remap = true })
map("n", "<leader>|", "<C-W>v", { desc = "Split Window Right", remap = true })
map("n", "<leader>wd", "<C-W>c", { desc = "Delete Window", remap = true })

-- oil + file management
map("n", "-", "<cmd>Oil<cr>") -- open parent directory
map("n", "<leader>sd", function() -- set working directory
  vim.cmd("cd " .. vim.fn.expand("%:p:h"))
end)

-- inc-rename
map("n", "<leader>rn", function()
  return ":IncRename " .. vim.fn.expand("<cword>")
end, { expr = true })

-- Lua
vim.keymap.set("n", "x", require("substitute").operator, { noremap = true })
vim.keymap.set("n", "xx", require("substitute").line, { noremap = true })
vim.keymap.set("n", "X", require("substitute").eol, { noremap = true })
vim.keymap.set("x", "x", require("substitute").visual, { noremap = true })
