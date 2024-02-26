A very fast lua based configuration that locates within a single file and is just over 300 lines long.

## Plugins:

- [neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim)
- [treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
- [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)
- [neoformat](https://github.com/sbdchd/neoformat)
- [mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim)
- [mason.nvim](https://github.com/williamboman/mason.nvim)
- [outline.nvim](https://github.com/hedyhli/outline.nvim)
- [cmp-buffer](https://github.com/hrsh7th/cmp-buffer)
- [cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp)
- [cmp_luasnip](https://github.com/saadparwaiz1/cmp_luasnip)
- [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)
- [LuaSnip](https://github.com/L3MON4D3/LuaSnip)
- [tokyonight](https://github.com/folke/tokyonight)
- [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)
- [whichkey.nvim](https://github.com/folke/which-key.nvim)
- [toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim)
- [noice.nvim](https://github.com/folke/noice.nvim)
- [flash.nvim](https://github.com/folke/flash.nvim)
- [nvim-surround](https://github.com/kylechui/nvim-surround)
- [indent-blankline](https://github.com/lukas-reineke/indent-blankline.nvim)
- [mini.pairs](https://github.com/echasnovski/mini.pairs)
- [mini.animate](https://github.com/echasnovski/mini.animate)
- [mini.ai](https://github.com/echasnovski/mini.ai)
- [mini.comment](https://github.com/echasnovski/mini.comment)

## Benefits 

### Speed   
This configuration is made with lazy loading in mind and the choice of plugins allows it to be faster then other neovim configs.


My Neovim Config;
```
Measured: 100 times

Total Average: 6.287100 msec
Total Max:     13.046000 msec
Total Min:     5.058000 msec
```

Lazyvim:
```
Measured: 100 times

Total Average: 13.860500 msec
Total Max:     22.746000 msec
Total Min:     12.615000 msec
```

Lunarvim:
```
Measured: 100 times

Total Average: 37.706570 msec
Total Max:     43.358000 msec
Total Min:     35.332000 msec
```

NvChad:
```
Measured: 100 times

Total Average: 10.074140 msec
Total Max:     14.388000 msec
Total Min:     8.980000 msec
```

### Simplicity
This config is just over 300 lines long is contained within a single file.
Making it easier to expand upon to make your own config.


## Setup configuration

### Prerequisites
To use this configuration, you will need:
 - git 
 - [Neovim 0.9 or above](https://neovim.io)
 - [ripgrep(Used for telescope)](https://github.com/BurntSushi/ripgrep)

### Download 

To start, simply clone the repo into your neovim config:
``` bash
$ git clone https://github.com/SmallMing6675/nvim.git ~/.config/ #change this to the place for your own neovim config
```
after cloning the repo, run `nvim` in your terminal to startup neovim. 
This will install lazy, the plugins required and some LSP servers.

### Install LSP servers, formatters and linters
running `:Mason` allows you to install anything you want, this is a couple of examples I usually install:
 - clangd (C/C++)
 - rust-analyzer (Rust)
 - stylua (Lua)
 - autoflake (Python)
