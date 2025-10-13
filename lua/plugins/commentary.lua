---@type LazySpec
return {
  "tpope/vim-commentary",
  -- Lazy-load when using its default mappings
  keys = {
    { "gc", mode = { "n", "x" }, desc = "Commentary toggle (operator)" },
    { "gcc", mode = "n", desc = "Commentary line toggle" },
  },
}

