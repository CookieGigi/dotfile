-- define common options
local opts = {
	noremap = true, -- non-recursive
	silent = true, -- do not show message
}

-- Leader key
vim.g.mapleader = " " -- Space as the leader key

-----------------
-- Normal mode --
-----------------

-- Better window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", opts)
vim.keymap.set("n", "<C-j>", "<C-w>j", opts)
vim.keymap.set("n", "<C-k>", "<C-w>k", opts)
vim.keymap.set("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
-- delta: 2 lines
vim.keymap.set("n", "<C-Up>", ":resize -2<CR>", opts)
vim.keymap.set("n", "<C-Down>", ":resize +2<CR>", opts)
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", opts)
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Save keybind
vim.api.nvim_set_keymap("n", "<C-s>", ":w<CR>", { noremap = true, silent = true, desc = "Save" }) -- add command write on <leader>w in normal mode

-- Select all
vim.keymap.set("n", "<leader>a", ":keepjumps normal! ggVG<cr>") -- select all

-----------------
-- Visual mode --
-----------------

-- use < and > to indent multiple lines
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-----------------
-- Insert mode --
-----------------

-- Save keybind
vim.api.nvim_set_keymap("i", "<C-s>", "<Esc>:w<CR>", { noremap = true, silent = true, desc = "Save" }) -- add command write on <leader>w in normal mode

-- telescope
--  TODO : Use which key-map to name properly category
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Search all files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Search open buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Search for nvim or plugin help" })
vim.keymap.set("n", "<leader>fc", builtin.grep_string, { desc = "Search for string under cursor" })
vim.keymap.set("n", "<leader>fo", builtin.oldfiles, { desc = "Search in file history" })
vim.keymap.set("n", "<leader>ft", builtin.treesitter, { desc = "Search tree-sitter" })

-- Trouble
vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })
vim.keymap.set(
	"n",
	"<leader>xX",
	"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
	{ desc = "Buffer Diagnostics (Trouble)" }
)
vim.keymap.set("n", "<leader>xs", "<cmd>Trouble symbols toggle focus=false<cr>", { desc = "Symbols (Trouble)" })
vim.keymap.set(
	"n",
	"<leader>xl",
	"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
	{ desc = "Symbols (Trouble)" }
)
vim.keymap.set("n", "<leader>xL", "<cmd>Trouble loclist toggle<cr>", { desc = "Location List (Trouble)" })
vim.keymap.set("n", "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", { desc = "Quickfix List (Trouble)" })
vim.keymap.set(
	"n",
	"<leader>xT",
	"<cmd>Trouble todo filter = {tag = {TODO,FIX,FIXME}}<cr>",
	{ desc = "Todo List (Trouble)" }
)

-- rustaceanvim
local bufnr = vim.api.nvim_get_current_buf()
vim.keymap.set("n", "<leader>c", function()
	vim.cmd.RustLsp("codeAction") -- supports rust-analyzer's grouping
	-- or vim.lsp.buf.codeAction() if you don't want grouping.
end, { silent = true, buffer = bufnr })

-- lazygit
vim.keymap.set("n", "<leader>gg", "<cmd>LazyGit<cr>", { desc = "LazyGit" })
-- reload config
function _G.ReloadConfig()
  for name,_ in pairs(package.loaded) do
    if name:match('^user') and not name:match('nvim-tree') then
      package.loaded[name] = nil
    end
  end

  dofile(vim.env.MYVIMRC)
  vim.notify("Nvim configuration reloaded!", vim.log.levels.INFO)
end


vim.api.nvim_set_keymap('n', '<Leader>sv', '<Cmd>lua ReloadConfig()<CR>', { silent = true, noremap = true })
vim.cmd('command! ReloadConfig lua ReloadConfig()')
