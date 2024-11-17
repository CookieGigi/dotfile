return {
	 "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSUpdateSync" },
    opts = {
      ensure_installed = {
        "bash",
        "diff",
        "html",
        "css",
        "gitcommit",
        "json",
        "json5",
        "lua",
        "luadoc",
        "markdown",
        "vim",
        "c_sharp",
        "comment",
        "dockerfile",
        "gitignore",
        "javascript",
        "python",
        "regex",
        "rust",
        "sql",
        "typescript",
        "tsx",
        "toml",
        "yaml",

      },
      sync_install = false,
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = {
        enable = true,
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.install").prefer_git = true
      require("nvim-treesitter.configs").setup(opts)
    end,
}
