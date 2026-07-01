return {
  "j-hui/fidget.nvim",
  opts = {
    progress = {
      -- Drop new progress notifications while typing (insert mode) — works
      -- around pyright spamming an empty $/progress on every keystroke:
      -- https://github.com/microsoft/pyright/issues/11408
      suppress_on_insert = true,
    },
    -- Options for the notification window
    notification = {
      override_vim_notify = false,
      window = {
        winblend = 0, -- Make it solid so you can see it clearly
      },
    },
  },
}
