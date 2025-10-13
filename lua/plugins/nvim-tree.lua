---@type LazySpec
return {
  "nvim-tree/nvim-tree.lua",
  cmd = { "NvimTreeToggle", "NvimTreeOpen", "NvimTreeClose", "NvimTreeFindFile" },
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Explorer: toggle" },
    { "<leader>E", "<cmd>NvimTreeFindFile<cr>",  desc = "Explorer: reveal current file" },
  },
  init = function()
    -- Disable netrw (recommended by nvim-tree)
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    -- Auto-open tree on startup on the left
    vim.api.nvim_create_autocmd("VimEnter", {
      callback = function()
        vim.schedule(function()
          local argc = vim.fn.argc()
          if argc == 0 then
            vim.cmd("NvimTreeOpen")
            return
          end

          local arg0 = vim.fn.argv(0)
          if arg0 and vim.fn.isdirectory(arg0) == 1 then
            vim.cmd("cd " .. vim.fn.fnameescape(arg0))
            vim.cmd("NvimTreeOpen")
          else
            -- Started with a file: open and reveal it
            vim.cmd("NvimTreeOpen")
            vim.cmd("NvimTreeFindFile")
          end
        end)
      end,
    })

    -- Ensure <leader>e toggles nvim-tree even if other plugins map it
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { silent = true, desc = "Explorer: toggle" })
        vim.keymap.set("n", "<leader>E", "<cmd>NvimTreeFindFile<cr>", { silent = true, desc = "Explorer: reveal current file" })
      end,
    })
  end,
  opts = {
    hijack_netrw = true,
    sync_root_with_cwd = true,
    respect_buf_cwd = true,
    view = {
      side = "left",
      width = 32,
      signcolumn = "yes",
    },
    renderer = {
      highlight_git = true,
      group_empty = true,
      indent_markers = { enable = true },
    },
    update_focused_file = {
      enable = true,
      update_root = true,
    },
    filters = {
      dotfiles = false,
      git_ignored = true,
    },
    actions = {
      open_file = { quit_on_open = false },
    },
    git = { enable = true, ignore = true },
  },
  config = function(_, opts)
    require("nvim-tree").setup(opts)
  end,
}
