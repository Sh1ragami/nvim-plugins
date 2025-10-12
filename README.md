## 個人用のneovim用の設定ファイル（随時追加）
 
 プラグインマネージャー
* lazy.nvim　https://github.com/folke/lazy.nvim

UI
* lualilne.nvim　https://github.com/nvim-lualine/lualine.nvim
* tokyonight.nvim https://github.com/folke/tokyonight.nvim

ファイラー
* yazi.nvim　https://github.com/mikavilpas/yazi.nvim

補完
* coc.nvim　https://github.com/neoclide/coc.nvim

```zsh
.
├── init.lua
├── lazy-lock.json
└── lua
    ├── config
    │   └── lazy.lua
    └── plugins
        ├── coc.lua
        ├── lualine.lua
        ├── tokyonight.lua
        └── yazi.lua
```
