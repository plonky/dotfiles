return {
  'nvim-telescope/telescope.nvim',
  dependencies = { 'nvim-lua/plenary.nvim'},
  config = function()
    local telescope = require('telescope')
    telescope.setup({})

    local builtin = require('telescope.builtin')

    -- Keybindings
    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find files' })
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Live grep (search text)'})
    vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Find buffers' })
  end,
}
