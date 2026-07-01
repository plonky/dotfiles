return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  build = ":TSUpdate",
  opts = {
    ensure_installed = {
      "c",
      "lua",
      "vim",
      "python",
      "javascript",
      "html",
      "kotlin",
      "rust",
      "bash",
      "regex",
      "markdown",
      "markdown_inline"
    },
    auto_install = true,
  },
}
