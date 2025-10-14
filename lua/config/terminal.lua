local group = vim.api.nvim_create_augroup("UserTerminal", { clear = true })

vim.api.nvim_create_autocmd("TermOpen", {
  group = group,
  pattern = "*",
  callback = function()
    -- Show numbers in terminal buffers as well
    vim.opt_local.number = true
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = "no"

    vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { buffer = 0, silent = true })
    vim.keymap.set("n", "<Esc>", function()
      vim.cmd("startinsert")
    end, { buffer = 0, silent = true })

    vim.cmd("startinsert")
  end,
})
