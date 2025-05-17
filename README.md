# 🛠️ nvim-wip-guide

A beginner-friendly, work-in-progress guide to learning Neovim — especially for folks switching over from VS Code.

This repo is my personal Neovim learning journey. It includes:
- My actual working config (`nvim/`)
- Visuals, memory aids, and mental models
- Honest notes on things I'm still figuring out
- Tips and funny mnemonics to help make sense of the Vim/neovim universe

---

## 🚀 Why I Made This

Switching to Neovim can feel overwhelming — especially coming from GUI-based editors like VS Code. I made this guide as:
- A way to teach myself how Neovim *really* works
- A reference for friends who ask “how do I get started with Neovim?”
- A living document to help others avoid the same confusion I went through

---
### 🧠 How Neovim Thinks — My Mental Model

Before you get into configs and plugins, it's super helpful to understand how Neovim expects you to think.
Unlike other editors, Neovim is modal, built around the idea of combining small, powerful commands in flexible ways.

👉 Check out [`neovim-mental-model.md`](/neovim-mental-model.md) for the full breakdown of:

- Why modes are your primary context
- How `verbs` + `motions` = action
- What `registers` and `operators` really do
- How to think in repeatable, composable commands

This mental model is what helped everything else finally click for me.

---

## 🗂️ File Structure Overview
Before diving into the code, here's a quick look at how this project is organized.

This layout mirrors how I’ve structured my personal Neovim setup, along with supporting notes, visual aids, and mnemonic helpers to make things easier to learn and remember.

➡️ For a deeper breakdown of the `nvim/` folder and how each file fits into the configuration, check out  
👉 [`neovim-file-structure.md`](./neovim-file-structure.md)

```bash
├── neovim-learnings/
│   ├── README.md # ← you're here!
│   ├── neovim-mental-model.md # How I think about Neovim under the hood
│   ├── neovim-file-structure.md # A practical guide to organizing your Neovim config files
│   ├── memory-aids/
│   │   └── mnemonic-devices-for-common-commands.md
│   
│   ├── visual-aids/
│   │   ├── mental-model-sketch.jpg  # TODO: Figure out how to add image to folder
│   │   └── printable-neovim-cheatsheet.md # TODO: Add copy of printable sheet you created for yourself.
│
│   ├── nvim/
│   │   ├── init.lua                    # Entry point for my config
│   │   └── lua/
│   │       └── trish/
│   │           ├── options             # Neovim settings and toggles
│   │           ├── keymaps             # My personal key bindings
│   │           └── plugins             # Plugin setup and configs
