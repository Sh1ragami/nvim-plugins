---@type LazySpec
return {
  "neoclide/coc.nvim",
  branch = "release",
  event = { "VeryLazy" },
  init = function()
    vim.g.coc_disable_startup_warning = 1
    -- Auto-install common extensions (includes Rust)
    vim.g.coc_global_extensions = {
      "coc-rust-analyzer",
      "coc-json",
      "coc-tsserver",
      "coc-pyright",
      "coc-html",
      "coc-css",
      "coc-lua",
      "coc-sh",
      "coc-yaml",
    }
  end,
  config = function()
    -- Basic options
    vim.opt.backup = false
    vim.opt.writebackup = false
    vim.opt.updatetime = 300
    vim.opt.signcolumn = "yes"

    local keyset = vim.keymap.set

    -- Autocomplete helpers
    function _G.check_back_space()
      local col = vim.fn.col('.') - 1
      return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
    end

    local imap_opts = { silent = true, noremap = true, expr = true, replace_keycodes = false }
    keyset("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', imap_opts)
    keyset("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], imap_opts)
    keyset("i", "<CR>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], imap_opts)
    keyset("i", "<c-j>", "<Plug>(coc-snippets-expand-jump)")
    keyset("i", "<c-space>", "coc#refresh()", { silent = true, expr = true })

    -- Diagnostics navigation
    keyset("n", "[g", "<Plug>(coc-diagnostic-prev)", { silent = true })
    keyset("n", "]g", "<Plug>(coc-diagnostic-next)", { silent = true })

    -- GoTo navigation
    keyset("n", "gd", "<Plug>(coc-definition)", { silent = true })
    keyset("n", "gy", "<Plug>(coc-type-definition)", { silent = true })
    keyset("n", "gi", "<Plug>(coc-implementation)", { silent = true })
    keyset("n", "gr", "<Plug>(coc-references)", { silent = true })

    -- Hover docs
    function _G.show_docs()
      local cw = vim.fn.expand('<cword>')
      if vim.fn.index({ 'vim', 'help' }, vim.bo.filetype) >= 0 then
        vim.cmd('h ' .. cw)
      elseif vim.api.nvim_eval('coc#rpc#ready()') == 1 then
        vim.fn.CocActionAsync('doHover')
      else
        vim.cmd('!' .. vim.o.keywordprg .. ' ' .. cw)
      end
    end
    keyset("n", "K", '<CMD>lua _G.show_docs()<CR>', { silent = true })

    -- Highlight symbol under cursor on hold
    local group = vim.api.nvim_create_augroup("CocGroup", { clear = true })
    vim.api.nvim_create_autocmd("CursorHold", {
      group = group,
      command = "silent call CocActionAsync('highlight')",
      desc = "Highlight symbol under cursor on CursorHold",
    })

    -- Rename / Format
    keyset("n", "<leader>rn", "<Plug>(coc-rename)", { silent = true })
    keyset("x", "<leader>f", "<Plug>(coc-format-selected)", { silent = true })
    keyset("n", "<leader>f", "<Plug>(coc-format-selected)", { silent = true })

    -- Formatexpr for some filetypes
    vim.api.nvim_create_autocmd("FileType", {
      group = group,
      pattern = "typescript,json",
      command = "setl formatexpr=CocAction('formatSelected')",
    })

    -- Code actions / quickfix
    local nopts = { silent = true, nowait = true }
    keyset("x", "<leader>a", "<Plug>(coc-codeaction-selected)", nopts)
    keyset("n", "<leader>a", "<Plug>(coc-codeaction-selected)", nopts)
    keyset("n", "<leader>ac", "<Plug>(coc-codeaction-cursor)", nopts)
    keyset("n", "<leader>as", "<Plug>(coc-codeaction-source)", nopts)
    keyset("n", "<leader>qf", "<Plug>(coc-fix-current)", nopts)

    -- Refactor actions
    keyset("n", "<leader>re", "<Plug>(coc-codeaction-refactor)", { silent = true })
    keyset("x", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })
    keyset("n", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })

    -- CodeLens
    keyset("n", "<leader>cl", "<Plug>(coc-codelens-action)", nopts)

    -- Text objects
    keyset("x", "if", "<Plug>(coc-funcobj-i)", nopts)
    keyset("o", "if", "<Plug>(coc-funcobj-i)", nopts)
    keyset("x", "af", "<Plug>(coc-funcobj-a)", nopts)
    keyset("o", "af", "<Plug>(coc-funcobj-a)", nopts)
    keyset("x", "ic", "<Plug>(coc-classobj-i)", nopts)
    keyset("o", "ic", "<Plug>(coc-classobj-i)", nopts)
    keyset("x", "ac", "<Plug>(coc-classobj-a)", nopts)
    keyset("o", "ac", "<Plug>(coc-classobj-a)", nopts)

    -- Float window scrolling
    local eopts = { silent = true, nowait = true, expr = true }
    keyset("n", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', eopts)
    keyset("n", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', eopts)
    keyset("i", "<C-f>", 'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(1)<cr>" : "<Right>"', eopts)
    keyset("i", "<C-b>", 'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(0)<cr>" : "<Left>"', eopts)
    keyset("v", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', eopts)
    keyset("v", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', eopts)

    -- Range select
    keyset("n", "<C-s>", "<Plug>(coc-range-select)", { silent = true })
    keyset("x", "<C-s>", "<Plug>(coc-range-select)", { silent = true })

    -- User commands
    vim.api.nvim_create_user_command("Format", "call CocAction('format')", {})
    vim.api.nvim_create_user_command("Fold", "call CocAction('fold', <f-args>)", { nargs = '?' })
    vim.api.nvim_create_user_command("OR", "call CocActionAsync('runCommand', 'editor.action.organizeImport')", {})

    -- Statusline support (lualine may override this)
    pcall(function()
      vim.opt.statusline:prepend("%{coc#status()}%{get(b:,'coc_current_function','')}")
    end)

    -- CocList mappings
    local lopts = { silent = true, nowait = true }
    keyset("n", "<space>a", ":<C-u>CocList diagnostics<cr>", lopts)
    -- Reserve <leader>e for file explorer; move Coc extensions list to <leader>ce
    keyset("n", "<space>ce", ":<C-u>CocList extensions<cr>", lopts)
    keyset("n", "<space>c", ":<C-u>CocList commands<cr>", lopts)
    keyset("n", "<space>o", ":<C-u>CocList outline<cr>", lopts)
    keyset("n", "<space>s", ":<C-u>CocList -I symbols<cr>", lopts)
    keyset("n", "<space>j", ":<C-u>CocNext<cr>", lopts)
    keyset("n", "<space>k", ":<C-u>CocPrev<cr>", lopts)
    keyset("n", "<space>p", ":<C-u>CocListResume<cr>", lopts)
  end,
}
