# Neovim File Structure

**One suggested way to organize your Neovim config files*

```
~/.config/nvim/
├── init.lua                 # 🎬 Entry point to load all configs
└── lua/
    └── trish/
        ├── options.lua      # ⚙️ Editor settings (line numbers, tabs)
        ├── keymaps.lua     # 🎹 Custom key bindings & shortcuts
        └── plugins.lua     # 🔌 Plugin manager and plugin list
```

This is the file structure most commonly used in modern Neovim setups, 
especially when configuring Neovim with **Lua** (which is now the recommended approach). 
It follows the standard used by popular community configs like 
[LunarVim](https://www.lunarvim.org/), 
[NvChad](https://nvchad.com/), and many GitHub examples.

The key idea is to keep things organized by separating:
- your editor settings,
- your key mappings, and
- your plugins list.

This structure also works smoothly with Neovim's built-in Lua runtime loader, which looks for files inside 
`~/.config/nvim/lua/`.

---

### 🧩 **What Goes In Each File?**

| 📁 **File / Folder**    | 📝 **Purpose**                                                                                                |
| ----------------------- | ------------------------------------------------------------------------------------------------------------- |
| `init.lua`              | 🧠 Your "main file" — loads and kicks off all other configs.                                                  |
| `lua/`                  | 🐉 Lua scripts folder — where you organize your Lua configs.                                                  |
| `lua/trish/`            | 💼 Your personal config namespace — keeps your custom files tidy and separate from plugins or core Lua stuff. |
| `lua/trish/options.lua` | 🛠️ Editor options & settings (line numbers, mouse, tabs, etc.).                                              |
| `lua/trish/keymaps.lua` | 🎹 Your custom keybindings & shortcuts.                                                                       |
| `lua/trish/plugins.lua` | 🔌 Plugin manager & list of plugins you want to load.                                                         |
---

### Why add the `trish/` folder inside `lua/`?

- The `lua/` folder is the root for Lua code in your Neovim config.
- By creating your own namespace folder (`trish/`), you **avoid clutter** and **prevent naming conflicts** with plugins or other Lua modules.
- It also makes your config modular and easier to maintain or share.