-- Tab
vim.opt.tabstop = 2 -- Number of spaces a tab represents
vim.opt.shiftwidth = 2 -- Number of spaces for each indentation
vim.opt.expandtab = true -- Convert tabs to spaces
vim.opt.smartindent = true -- Automatically indent new lines

-- Search
vim.opt.ignorecase = true -- ignore case in search
vim.opt.smartcase = true -- ignore case unless search have capital letter
vim.opt.hlsearch = false -- disable highlight of last search

-- Long line
vim.opt.wrap = true -- wrap long line
vim.opt.breakindent = true -- preserve indent when using wrap

-- UI settings
vim.opt.showmode = false -- hide default show mode
vim.opt.number = true -- Enable line numbers
vim.opt.relativenumber = true -- Enable relative line numbers
vim.o.cursorline = true -- Highlight the current line
vim.o.termguicolors = true -- Enable 24-bit RGB colors (Color are better without)

-- disable mouse
vim.opt.mouse = ""

-- Syntax highlighting and filetype plugins
vim.cmd("syntax enable")
vim.cmd("filetype plugin indent on")

-- Disable useless provider
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0

-- text
vim.opt.conceallevel = 2 -- hide element like link in markdown to show only the usefull part unless the cursor go on it
