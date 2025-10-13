---@type LazySpec
return {
  "romgrk/barbar.nvim",
  version = "^1.0.0",
  event = "VeryLazy",
  dependencies = {
    "lewis6991/gitsigns.nvim",         -- optional: git status
    "nvim-tree/nvim-web-devicons",     -- optional: file icons
  },
  init = function()
    -- Let lazy.nvim call setup with opts; disable auto-setup
    vim.g.barbar_auto_setup = false
  end,
  keys = {
    -- Navigate
    { "<S-h>", "<Cmd>BufferPrevious<CR>", desc = "Buffer: previous" },
    { "<S-l>", "<Cmd>BufferNext<CR>",     desc = "Buffer: next" },

    -- Re-order
    { "<leader>b<", "<Cmd>BufferMovePrevious<CR>", desc = "Buffer: move left" },
    { "<leader>b>", "<Cmd>BufferMoveNext<CR>",     desc = "Buffer: move right" },

    -- Goto buffer by number
    { "<leader>b1", "<Cmd>BufferGoto 1<CR>", desc = "Buffer: goto 1" },
    { "<leader>b2", "<Cmd>BufferGoto 2<CR>", desc = "Buffer: goto 2" },
    { "<leader>b3", "<Cmd>BufferGoto 3<CR>", desc = "Buffer: goto 3" },
    { "<leader>b4", "<Cmd>BufferGoto 4<CR>", desc = "Buffer: goto 4" },
    { "<leader>b5", "<Cmd>BufferGoto 5<CR>", desc = "Buffer: goto 5" },
    { "<leader>b6", "<Cmd>BufferGoto 6<CR>", desc = "Buffer: goto 6" },
    { "<leader>b7", "<Cmd>BufferGoto 7<CR>", desc = "Buffer: goto 7" },
    { "<leader>b8", "<Cmd>BufferGoto 8<CR>", desc = "Buffer: goto 8" },
    { "<leader>b9", "<Cmd>BufferGoto 9<CR>", desc = "Buffer: goto 9" },
    { "<leader>b0", "<Cmd>BufferLast<CR>",  desc = "Buffer: goto last" },

    -- Actions
    { "<leader>bp", "<Cmd>BufferPin<CR>",   desc = "Buffer: pin" },
    { "<leader>bd", "<Cmd>BufferClose<CR>", desc = "Buffer: close" },
    { "<leader>bs", "<Cmd>BufferPick<CR>",  desc = "Buffer: pick" },
  },
  opts = {
    -- Keep tabline aligned when NvimTree is open
    sidebar_filetypes = { NvimTree = true },
  },
  config = function(_, opts)
    require("barbar").setup(opts)
  end,
}
