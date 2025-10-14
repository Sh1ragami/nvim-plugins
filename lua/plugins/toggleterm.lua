return {
  'akinsho/toggleterm.nvim',
  version = "*",
  opts = {
    direction = 'float',
  },
  config = function(_, opts)
    require('toggleterm').setup(opts)
    vim.keymap.set('n', "<leader>t", '<cmd>ToggleTerm<cr>', {
      desc = 'Toggle terminal'
    })
  end
}
