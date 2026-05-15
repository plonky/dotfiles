return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    local configs = require("nvim-treesitter.configs")
    
    configs.setup({
      ensure_installed = { "c", "lua", "vim", "python", "javascript", "html", "kotlin", "rust", "bash", "regex",
      "markdown", "markdown_inline"},
      highlight = { enable = true },
      indent = { enable = true },
    })
  end,
}
