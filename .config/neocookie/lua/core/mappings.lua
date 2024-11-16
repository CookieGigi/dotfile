-- define common options
local opts = {
	noremap = true, -- non-recursive
	silent = true, -- do not show message
}

-- Helper --
local keymap = function(mode, lhs, rhs, opts)
  vim.keymap.set(mode, lhs, rhs, opts)
end

local keymap_leader = function(mode, suffix, rhs, opts)
  keymap(mode, "<leader>" .. suffix, rhs, opts)
end

local function close_floating()
  for _, win in pairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_get_config(win).relative == "win" then
      vim.api.nvim_win_close(win, false)
    end
  end
end

local create_mode_table = function(fn)
  return {
    n = function(lhs, rhs, opts)
      fn("n", lhs, rhs, opts)
    end,
    i = function(lhs, rhs, opts)
      fn("i", lhs, rhs, opts)
    end,
    v = function(lhs, rhs, opts)
      fn("v", lhs, rhs, opts)
    end,
    x = function(lhs, rhs, opts)
      fn("x", lhs, rhs, opts)
    end,
    t = function(lhs, rhs, opts)
      fn("t", lhs, rhs, opts)
    end,
    c = function(lhs, rhs, opts)
      fn("c", lhs, rhs, opts)
    end,
  }
end
-- Helper --

local Map = {
  mode = create_mode_table(keymap),
  leader = create_mode_table(keymap_leader),
  OnLspAttach = nil,
}

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",


-- Leader key
vim.g.mapleader = " " -- Space as the leader key

-----------------
-- Normal mode --
-----------------

-- Better window navigation
Map.mode.n("<C-h>", "<C-w>h", opts)
Map.mode.n("<C-j>", "<C-w>j", opts)
Map.mode.n("<C-k>", "<C-w>k", opts)
Map.mode.n("<C-l>", "<C-w>l", opts)

-- Resize with arrows
-- delta: 2 lines
Map.mode.n("<C-Up>", ":resize -2<CR>", opts)
Map.mode.n("<C-Down>", ":resize +2<CR>", opts)
Map.mode.n("<C-Left>", ":vertical resize -2<CR>", opts)
Map.mode.n("<C-Right>", ":vertical resize +2<CR>", opts)

-- Save keybind
Map.mode.n("<C-s>", ":w<CR>", { noremap = true, silent = true, desc = "Save" }) -- add command write on <leader>w in normal mode

-----------------
-- Visual mode --
-----------------

-- use < and > to indent multiple lines
Map.mode.v("<", "<gv", opts)
Map.mode.v(">", ">gv", opts)

-----------------
-- Insert mode --
-----------------

-- Save keybind
Map.mode.i("<C-s>", "<Esc>:w<CR>", { noremap = true, silent = true, desc = "Save" }) -- add command write on <leader>w in normal mode


