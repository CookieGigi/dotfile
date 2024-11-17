-- define common options
local opts = {
	noremap = true, -- non-recursive
	silent = true, -- do not show message
}

-- Helper --
local wk = require("which-key")
local keymap = function(mode, lhs, rhs, opts)
  opts = opts or {noremap = true, silent = true}
  wk.add({mode= { mode }, {lhs, rhs, noremap = opts.noremap, silent = opts.silent, desc=opts.desc, group=opts.group, hidden=opts.hidden } })
  --vim.keymap.set(mode, lhs, rhs, opts)
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
Map.mode.n("<C-h>", "<C-w>h", { noremap = true, silent = true, desc = "Move to left window" })
Map.mode.n("<C-j>", "<C-w>j", { noremap = true, silent = true, desc = "Move to top window" })
Map.mode.n("<C-k>", "<C-w>k", { noremap = true, silent = true, desc = "Move to bottom window" })
Map.mode.n("<C-l>", "<C-w>l", { noremap = true, silent = true, desc = "Move to right window" })

-- Resize with arrows
-- delta: 2 lines
Map.mode.n("<C-Up>", ":resize -2<CR>", { noremap = true, silent = true, desc = "Reduce vertical size" })
Map.mode.n("<C-Down>", ":resize +2<CR>", { noremap = true, silent = true, desc = "Increase vertical size" })
Map.mode.n("<C-Left>", ":vertical resize -2<CR>", { noremap = true, silent = true, desc = "Reduce horizontal size" })
Map.mode.n("<C-Right>", ":vertical resize +2<CR>", { noremap = true, silent = true, desc = "Increase horizontal size" })

-- Navigate buffers
Map.mode.n("<S-l>", ":bnext<CR>", { noremap = true, silent = true, desc = "Next buffer" })
Map.mode.n("<S-h>", ":bprevious<CR>", { noremap = true, silent = true, desc = "Previous buffer" })

-- Save keybind
Map.mode.n("<C-s>", ":w<CR>", { noremap = true, silent = true, desc = "Save" }) -- add command write on <leader>w in normal mode

-- Explorer--
Map.leader.n("e", ":Explore<CR>", { noremap = true, silent = true, desc = "Open explorer" })

-- System clipboard
Map.leader.n("y", '"+y', {noremap = true, silent = true, desc="Copy selection"})

-- Which-key
Map.leader.n("?",
function()
  require("which-key").show({global = true})
end,
{ noremap = true, silent = true, desc = "Open keys mappings" }) 

-- Telescope
local builtin = require("telescope.builtin")
Map.leader.n("f", "", {group = "Search"})
Map.leader.n("ff", "<cmd>Telescope find_files find_command=rg,--ignore,--hidden,--files prompt_prefix=🔍<cr>", { desc = "Search all files" })
Map.leader.n("fg", builtin.live_grep, { desc = "Live grep" })
Map.leader.n("fb", builtin.buffers, { desc = "Search open buffers" })
Map.leader.n("fh", builtin.help_tags, { desc = "Search for nvim or plugin help" })
Map.leader.n("fc", builtin.grep_string, { desc = "Search for string under cursor" })
Map.leader.n("fo", builtin.oldfiles, { desc = "Search in file history" })
Map.leader.n("ft", builtin.treesitter, { desc = "Search tree-sitter" })



-----------------
-- Visual mode --
-----------------

-- use < and > to indent multiple lines
Map.mode.v("<", "<gv", { noremap = true, silent = true, desc = "Unindent" })
Map.mode.v(">", ">gv", { noremap = true, silent = true, desc = "Indent" })

-- Move text up and down
Map.mode.v("<A-j>", ":m '>+1<CR>gv=gv", { silent = true, noremap = true, desc="Move text down"})
Map.mode.v("<A-k>", ":m '<-2<CR>gv=gv", { silent = true, noremap = true, desc="Move text up" })
Map.mode.v("p", '"_dP')

-- System clipboard
Map.leader.v("y", '"+y', {noremap = true, silent = true, desc="Copy selection"})

-- Which-key
Map.leader.v("?",
function()
  require("which-key").show({global = true})
end,
{ noremap = true, silent = true, desc = "Open keys mappings" }) 

-----------------
-- Insert mode --
-----------------

-- Save keybind
Map.mode.i("<C-s>", "<Esc>:w<CR>", { noremap = true, silent = true, desc = "Save" }) -- add command write on <leader>w in normal mode

return Map
