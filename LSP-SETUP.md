# Environment Setup Guide

Reproduce this dev environment on a new machine.
Tested on Arch Linux, Neovim 0.11+, Node 25+.

## 1. System Packages (pacman)

```bash
sudo pacman -S clang lua-language-server picocom python-pyserial python-pipx
```

| Package | Purpose |
|---------|---------|
| `clang` | C/C++ compiler + `clangd` LSP |
| `lua-language-server` | Lua LSP (for neovim config) |
| `picocom` | Lightweight serial monitor |
| `python-pyserial` | Serial lib (PlatformIO dependency) |
| `python-pipx` | Isolated Python CLI tool installer |

## 2. Node.js + npm Global Packages

Install nvm, then:

```bash
nvm install --lts   # or nvm install 25
```

```bash
npm i -g typescript \
        typescript-language-server \
        @vue/language-server \
        @vue/typescript-plugin \
        vscode-langservers-extracted \
        yaml-language-server \
        emmet-ls
```

| Package | Purpose |
|---------|---------|
| `typescript` | TS compiler, provides `tsdk` path for LSPs |
| `typescript-language-server` | TS/JS LSP (`ts_ls`) |
| `@vue/language-server` | Vue LSP (Volar / `vue_ls`) |
| `@vue/typescript-plugin` | TS plugin loaded by `ts_ls` for `.vue` file support |
| `vscode-langservers-extracted` | JSON, HTML, CSS, ESLint LSPs |
| `yaml-language-server` | YAML LSP |
| `emmet-ls` | Emmet abbreviation completions |

## 3. PlatformIO (via pipx)

```bash
pipx install platformio
```

## 4. Arduino CLI

```bash
# Install arduino-cli (check https://arduino.github.io/arduino-cli/ for latest method)
# On Arch: yay -S arduino-cli  OR  install from GitHub releases

# Add ESP32 board manager URL
arduino-cli config add board_manager.additional_urls \
  https://espressif.github.io/arduino-esp32/package_esp32_index.json

# Install board cores
arduino-cli core update-index
arduino-cli core install arduino:avr
arduino-cli core install esp32:esp32
```

## 5. Serial Access (Linux)

```bash
sudo usermod -aG uucp $USER
# Log out and back in for group change to take effect
```

## 6. Treesitter Parsers

Open neovim and run:

```vim
:TSInstall vue typescript tsx javascript html css scss json json5 yaml lua rust c cpp bash markdown markdown_inline vimdoc toml comment regex
```

## 7. Mason Packages

Mason auto-installs these on first launch via `mason-tool-installer` (configured in `lua/custom/plugins/lsp.lua`):

- stylua, json-lsp, yaml-language-server, html-lsp, lua-language-server, rust-analyzer, typescript-language-server, vue-language-server, clangd

If they don't auto-install, run `:Mason` and install manually.

---

## How the LSP Config Works

**Single source of truth**: `lua/custom/plugins/lsp.lua`

The `init.lua` lspconfig block is intentionally empty — all LSP setup lives in the custom plugin file to avoid lazy.nvim's config function merging issues.

### Vue 3 + TypeScript (Hybrid Mode)

This is the trickiest setup. Two servers cooperate:

1. **`vue_ls`** (Volar) — handles `<template>` and `<style>` regions
2. **`ts_ls`** — handles `<script>` TypeScript via `@vue/typescript-plugin`

Key details:

- `ts_ls` loads `@vue/typescript-plugin` with `location` pointing to `@vue/language-server` (NOT `@vue/typescript-plugin`) and `configNamespace = "typescript"`
- `vue_ls` runs in **hybrid mode** (default in Volar 2+, takeover mode is deprecated)
- **Workaround**: `vue_ls` in hybrid mode hangs on TS-related requests (hover, definition, references) in `<script>` — never responds, blocking Neovim. An `LspAttach` autocmd disables these capabilities on `vue_ls`, letting `ts_ls` handle them exclusively. Template/style features (completions, diagnostics, formatting) remain active on `vue_ls`.

### tsdk Resolution

The config dynamically finds TypeScript:
1. Project-local: `$CWD/node_modules/typescript/lib`
2. Global nvm: resolved from `node` executable path

### Vue Language Server Path Resolution

Searched in order:
1. Project-local: `$CWD/node_modules/@vue/language-server`
2. Mason: `~/.local/share/nvim/mason/packages/vue-language-server/node_modules/@vue/language-server`
3. npm global: `$(npm root -g)/@vue/language-server`

---

## Quick Verify Checklist

After setup, open a `.vue` file and check:

- [ ] `:LspInfo` shows both `ts_ls` and `vue_ls` attached
- [ ] `K` (hover) works in `<script>` — shows TypeScript type info
- [ ] `grd` (go to definition) works in `<script>`
- [ ] `zc` folds work (treesitter foldexpr)
- [ ] Diagnostics show for type errors in `<script>`
- [ ] Completions work in `<template>` (HTML tags, component props)
