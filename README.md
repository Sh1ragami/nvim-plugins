## 個人用のneovim用の設定ファイル（随時追加）
 
 プラグインマネージャー
* lazy.nvim　https://github.com/folke/lazy.nvim

UI
* lualilne.nvim https://github.com/nvim-lualine/lualine.nvim
* tokyonight.nvim https://github.com/folke/tokyonight.nvim
* barbar https://github.com/romgrk/barbar.nvim

ターミナル
* toggleterm https://github.com/akinsho/toggleterm.nvim

ファイラー
* yazi.nvim　https://github.com/mikavilpas/yazi.nvim

補完
* coc.nvim https://github.com/neoclide/coc.nvim
* whichi-key.nvim https://github.com/machakann/vim-sandwich
* vim-sandwich https://github.com/folke/which-key.nvim

Git連携
* gitsigns https://github.com/lewis6991/gitsigns.nvim

```zsh
.
├── init.lua
├── lazy-lock.json
├── lua
│   ├── config
│   │   ├── lazy.lua
│   │   └── terminal.lua
│   └── plugins
│       ├── barbar.lua
│       ├── coc.lua
│       ├── commentary.lua
│       ├── gitsigns.lua
│       ├── lualine.lua
│       ├── nvim-tree.lua
│       ├── toggleterm.lua
│       ├── tokyonight.lua
│       └── yazi.lua
├── README.md
└── yazi
    └── yazi.toml-1760333156502277
```

