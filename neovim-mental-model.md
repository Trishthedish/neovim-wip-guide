# A solid summary and mental model for withing with neovim

### **1. Modes Are Your Contexts**

Before anything, Vim/Neovim is **modal** — it works differently based on which mode you’re in.

| Mode         | Purpose                         | Enter with            | Example Use                      |
| ------------ | ------------------------------- | --------------------- | -------------------------------- |
| Normal       | Navigate and issue commands     | Press `Esc`           | `dd` to delete a line            |
| Insert       | Type like in a regular editor   | `i`, `a`, `o`, etc.   | Type out text                    |
| Visual       | Select text                     | `v`, `V`, or `Ctrl+v` | Highlight to yank/delete/etc.    |
| Command-line | Run commands                    | `:`                   | `:w`, `:q`, `:s/.../.../g`, etc. |
| Replace      | Replace text one char at a time | `R`                   | Type over existing characters    |

> **Mental model**: “First, what mode am I in?”  
> This affects what keys do.
---
### **2. Verbs + Motions = Action**

Most commands are built like **mini sentences**:

`<verb><motion>`


|Verb | Action|
|-----|-------|
|`d`  | delete|
|`y`  |yank (copy)|
|`c`  |change|
|`v`  |visually select|
|`g~` |toggle case|


|Motion|Movement unit|
|---|---|
|`w`|word forward|
|`b`|word backward|
|`e`|end of word|
|`0`|start of line|
|`$`|end of line|
|`}`|next paragraph|

> `dw` = **delete word**  
> `y$` = **yank to end of line**
---
### **3. Operators Are Repeatable**

You can combine _count + verb + motion_:

- `2dw` = delete 2 words
- `3yy` = yank 3 lines
- `5>>` = indent 5 lines
    
> Think in small blocks: **how much**, **what action**, **what area**
---
### **4. Registers Are Your Memory**

Neovim tracks yanks, deletions, macros, and more in registers.

- Yank goes to `"` (default register)
- `:registers` shows saved clips
- `"aY` saves to register `a`
- `@a` plays back macro from register `a`

> These are like clipboards you can name and replay.

---

### **5. Movement Is Navigation, Not Just Scrolling**

In Neovim, your cursor is your _lens_ — you move it like a microscope over code.

|Goal|Shortcut|
|---|---|
|Word-wise movement|`w`, `e`, `b`|
|Line-wise|`0`, `^`, `$`|
|Paragraph/Block|`{`, `}`|
|Jumping to match|`%`|
|Searching|`/term`, `n`|
|Files|`:e filename`|

> Practice: Pretend you're “stepping through” your code with purpose.

---

### **6. Visual Mode = Select Before Acting**

Just like clicking+dragging, but more precise.

|Action|Mode|Shortcut|
|---|---|---|
|Character|Visual|`v`|
|Line|Visual Line|`V`|
|Block|Visual Block|`Ctrl+v`|

Once selected:

- `d` = delete
- `y` = yank
- `>` = indent
- `:` = run command on selection

> Think of Visual as “mark before perform.”
---

### **7. Command-line Mode = Precise Power**

Starts with `:`

| Command        | Meaning                       |
| -------------- | ----------------------------- |
| `:w`           | Write (save)                  |
| `:q`           | Quit                          |
| `:wq`          | Save and quit                 |
| `:e filename`  | Open a new file               |
| `:s/foo/bar/g` | Substitute (search & replace) |