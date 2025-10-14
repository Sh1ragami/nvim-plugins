require("config.lazy")
require("config.terminal")

-- Always show absolute line numbers
vim.opt.number = true

-- Whitespace visualization
vim.opt.list = true
vim.opt.listchars = {
  space = "·",
  tab = "»·",
  trail = "•",
  extends = "⟩",
  precedes = "⟨",
  nbsp = "␣",
}

-- Default indentation: spaces, 2-width
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2

-- Filetype-specific indentation
local indent_group = vim.api.nvim_create_augroup("IndentSettings", { clear = true })
local function set_indent(ft, opts)
  vim.api.nvim_create_autocmd("FileType", {
    group = indent_group,
    pattern = ft,
    callback = function()
      if opts.expandtab ~= nil then vim.opt_local.expandtab = opts.expandtab end
      if opts.tabstop then vim.opt_local.tabstop = opts.tabstop end
      if opts.shiftwidth then vim.opt_local.shiftwidth = opts.shiftwidth end
      if opts.softtabstop then vim.opt_local.softtabstop = opts.softtabstop end
    end,
  })
end

-- 4 spaces: common in Python/Rust/C-family/Java
set_indent({ "python", "rust", "c", "cpp", "java" }, {
  expandtab = true,
  tabstop = 4,
  shiftwidth = 4,
  softtabstop = 4,
})

-- 2 spaces: JS/TS/JSON/YAML/HTML/CSS/Lua/etc.
set_indent({
  "lua",
  "javascript",
  "typescript",
  "javascriptreact",
  "typescriptreact",
  "json",
  "jsonc",
  "yaml",
  "html",
  "css",
  "scss",
  "markdown",
  "sh",
  "bash",
  "zsh",
  "toml",
  "terraform",
  "hcl",
  "ruby",
}, {
  expandtab = true,
  tabstop = 2,
  shiftwidth = 2,
  softtabstop = 2,
})

-- Tabs: Go and Makefile
set_indent({ "go" }, {
  expandtab = false,
  tabstop = 4,
  shiftwidth = 4,
  softtabstop = 4,
})
set_indent({ "make" }, {
  expandtab = false,
  tabstop = 8,
  shiftwidth = 8,
  softtabstop = 8,
})
