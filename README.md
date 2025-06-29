# renpy-syntax.nvim

Syntax Highlighting for [Ren'Py](https://www.renpy.org/) in Neovim  
Realce de Sintaxe para Ren'Py no Neovim

---

## English (US) / Português (Brasil)

### Features / Funcionalidades

- Syntax highlighting for Ren'Py core keywords / Realce de comandos principais (`label`, `jump`, `menu`, etc.)
- Screen language elements / Elementos visuais de `screen language` (`vbox`, `textbutton`, `input`, etc.)
- Embedded Python highlighting / Suporte a blocos `init python:` e `python:` com highlight de Python
- ATL (Animation and Transformation Language) support / Suporte à linguagem ATL
- Indentation rules based on official Ren'Py style / Regras de indentação seguindo o estilo oficial do Ren'Py
- Filetype detection for `.rpy` / Detecção automática de arquivos `.rpy` (`filetype=renpy`)
- Optional completion source for [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) / Autocompletar opcional com `nvim-cmp`

---

## Installation / Instalação

### With Lazy.nvim / Com Lazy.nvim

Add this to your plugin list / Adicione isto à sua lista de plugins:

```lua
{
  "inzoiniac/renpy-syntax.nvim",
  config = function()
    require("renpy-syntax").setup()
  end,
}
```

### Wihtout plugin manager/Sem gerenciador de plugins

Clone the repository / Clone o repositório:

```
git clone https://github.com/inzoiniac/renpy-syntax.nvim ~/.config/nvim/pack/plugins/start/renpy-syntax
```

Restart Neovim / Reinicie o Neovim

## Plugin Structure/Estrutura do Plugin

```
renpy-syntax.nvim/
├── indent/
│   └── renpy.vim             # Auto indentation rules / Regras de indentação automática
├── lua/
│   └── renpy-syntax/
│       ├── init.lua          # Setup module / Módulo principal de setup
│       └── rpy_cmp.lua       # Optional nvim-cmp source / Source opcional para nvim-cmp
├── syntax/
│   └── renpy.vim             # Highlight definitions / Regras de syntax highlight
├── LICENSE
└── README.md

```

## Optional: Autocompletion with nvim-cmp/Opcional: Autocompletar com nvim-cmp

If you already use ```nvim-cmp```, the plugin will auto-register itsel.
Se você já usa ```nvim-cmp```, o plugin se registrará automaticamente.

Example config/Exemplo de configuração:

```
{
  "hrsh7th/nvim-cmp",
  opts = function(_, opts)
    local cmp = require("cmp")
    opts.sources = cmp.config.sources(vim.list_extend(opts.sources, {
      { name = "renpy" },
    }))
  end,
}

```
