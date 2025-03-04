-- Lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
	{ "nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons" } },
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
	},
	{ "nvim-lua/plenary.nvim" },
	{ "nvim-treesitter/nvim-treesitter" },
	{ "nvim-telescope/telescope.nvim", branch = "0.1.x" },
	{ "neovim/nvim-lspconfig" },
	{ "hrsh7th/nvim-cmp" },
	{ "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-nvim-lsp-signature-help"},
  { "hrsh7th/cmp-path"},
	{ "VonHeikemen/lsp-zero.nvim", branch = "v3.x" },
	{ "hrsh7th/cmp-buffer" },
	{ "L3MON4D3/LuaSnip" },
	{ "echasnovski/mini.nvim", branch = "stable" },
	{
		"folke/trouble.nvim",
		opt = {},
		cmd = "Trouble",
	},
	{
		"mrcjkb/rustaceanvim",
		version = "^4", -- Recommended
		lazy = false, -- This plugin is already lazy
	},
	{
		"kdheepak/lazygit.nvim",
		cmd = {
			"LazyGit",
			"LazyGitConfig",
			"LazyGitCurrentFile",
			"LazyGitFilter",
			"LazyGitFilterCurrentFile",
		},
		-- optional for floating window border decoration
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		-- setting the keybinding for LazyGit with 'keys' is recommended in
		-- order to load the plugin when the command is run for the first time
		keys = {
			{ "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
		},
	},
  { "prettier/vim-prettier"}
})

-- catppuccin

require("catppuccin").setup({
	integrations = {
		which_key = true,
		treesitter = true,
		telescope = {
			enabled = true,
		},
	},
})

-- lualine
require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = "catppuccin",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = {
			statusline = {},
			winbar = {},
		},
		ignore_focus = {},
		always_divide_middle = true,
		globalstatus = false,
		refresh = {
			statusline = 1000,
			tabline = 1000,
			winbar = 1000,
		},
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = { "filename" },
		lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	winbar = {},
	inactive_winbar = {},
	extensions = {},
})

-- which-key
require("which-key").setup({})

-- treesitter
require("nvim-treesitter.configs").setup({
	highlight = { enable = true },
	auto_install = true,
	ensure_installed = { "lua", "vim", "vimdoc", "json" },
})

-- lsp-zero
local lsp_zero = require("lsp-zero")

-- only if a lsp is active
lsp_zero.on_attach(function(client, bufnr)
	-- See :help lsp-zero-keybindings
	lsp_zero.default_keymaps({ buffer = bufnr, preserve_mappings = false })
end)


-- -- nextjs
-- local on_attach = function(client, bufnr)
--   -- Enable completion triggered by <c-x><c-o>
--   vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
--
--   -- Mappings to magical LSP functions!
--   local bufopts = { noremap=true, silent=true, buffer=bufnr }
--   vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
--   vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
--   vim.keymap.set('n', 'gk', vim.lsp.buf.hover, bufopts)
--   vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
--   vim.keymap.set('n', 'gK', vim.lsp.buf.signature_help, bufopts)
--   vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
--   vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
--   vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
--   vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
--   vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
-- end
--
-- local capabilities = require('cmp_nvim_lsp').default_capabilities()
--
-- local lspconfig = require('lspconfig')
-- local servers = { 'tailwindcss', 'tsserver', 'jsonls', 'eslint' }
-- for _, lsp in pairs(servers) do
--   lspconfig[lsp].setup {
--     on_attach = on_attach,
--     capabilites = capabilities,
--   }
-- end
--
-- lspconfig.cssls.setup {
--   on_attach = on_attach,
--   capabilities = capabilities
-- }
--
-- lspconfig.html.setup {
--   on_attach = on_attach,
--   capabilities = capabilities
-- }


-- cmp

local cmp = require("cmp")
local cmp_action = lsp_zero.cmp_action()

cmp.setup({
	sources = {
		{ name = "nvim_lsp" },
		{ name = "buffer" },
    { name = "nvim_lsp_signature_help"},
    { name = "path"},
	},
	formatting = lsp_zero.cmp_format({ details = true }),
	mapping = cmp.mapping.preset.insert({
		["<CR>"] = cmp.mapping.confirm({ select = false }),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-f>"] = cmp_action.luasnip_jump_forward(),
		["<C-b>"] = cmp_action.luasnip_jump_backward(),
		["<C-u>"] = cmp.mapping.scroll_docs(-4),
		["<C-d>"] = cmp.mapping.scroll_docs(4),
	}),
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
})

-- mini
-- comment line
require("mini.comment").setup({})
-- highlight word under cursor
require("mini.cursorword").setup({})


-- trouble
require("trouble").setup({})

-- autofmt
local bufnr = vim.api.nvim_get_current_buf()
local format_sync_grp = vim.api.nvim_create_augroup("RustaceanFormat", {})
vim.api.nvim_create_autocmd("BufWritePre", {
	buffer = bufnr,
	callback = function()
		vim.lsp.buf.format()
	end,
	group = format_sync_grp,
})


-- telescope
require("telescope").setup({
  defaults={
    file_ignore_patterns = {
       "node_modules", "build", "dist", "%.lock", "^.git/"
   },
  }
})

