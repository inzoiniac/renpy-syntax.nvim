# renpy-syntax.nvim

Syntax Highlighting for [Ren'Py](https://www.renpy.org/) in Neovim  

---

## English (US)

### Features

- Syntax highlighting for Ren'Py core keywords (`label`, `jump`, `menu`, etc.)
- Support for screen language components (`vbox`, `textbutton`, `input`, etc.)
- Embedded Python highlighting in `init python:` and `python:` blocks
- ATL (Animation and Transformation Language) support
- Automatically detects `.rpy` files and sets `filetype=renpy`

---

## Português (Brazilian Portuguese)

### Funcionalidades

- Realce para comandos Ren'Py (`label`, `jump`, `menu`, etc.)
- Destaque de elementos `screen`, `style`, `vbox`, `textbutton`, entre outros
- Suporte a blocos `init python:` e `python:` com highlight Python embutido
- Suporte à linguagem ATL (Animation and Transformation Language)
- Detecção automática de arquivos `.rpy` (define `filetype=renpy`)

### Installation/Instalação

#### With/Com Lazy.nvim

If you're using/Usando o [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{
  "inzoiniac/renpy-syntax.nvim",
  lazy = false,
}
```

#### Without plugin manager/Sem um gerenciador de plugins

1. Clone this repository/Clone esse repositório:

```bash
git clone https://github.com/inzoiniac/renpy-syntax.nvim ~/.config/nvim/pack/plugins/start/renpy-syntax
```

2. Restart Neovim/Reinicie o Neovim — `.rpy` detection and syntax will work automatically/a detecção e syntax vai funcionar automaticamente

---

## Plugin Structure/Estrutura do Plugin

```
renpy-syntax.nvim/
├── README.md
├── LICENSE
├── init.lua
├── ftdetect/
│   └── renpy.vim
└── syntax/
    └── renpy.vim
```

---

## License/Licença (MIT)

MIT License

Copyright (c) 2025 inzoiniac

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the “Software”), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

> The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

**THE SOFTWARE IS PROVIDED “AS IS”**, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
