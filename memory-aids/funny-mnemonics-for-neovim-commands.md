# 🧠😂 Funny Mnemonics for Neovim Commands

_Laughing through the Vim pain, one keystroke at a time._

If you're learning Neovim (or its predecessor, Vim), you've probably mashed your keyboard a few times wondering why a single letter just wiped out your paragraph. 

Fear not — this guide is a lighthearted cheat sheet full of memorable, funny mnemonics to help those cryptic commands stick in your brain for good.

Whether you're trying to remember the difference between `dd` and `dw`, or just want to yell “**`Delete, Damn`**!” every time you clean up a line — this list is for you. 

>These memory hooks are designed to turn frustration into fun, and repetition into reflex.

---
## **✂️ Deletion & Change**

1. **`dd` → “Delete, Damn!”**
    
    - **d** = _delete_ operator (tells Neovim you want to remove text)
        
    - **d** = motion “to the whole line” (another `d` here acts like “line” in this context)
        
    - **Together:** delete the entire current line.
        
2. **`dw` → “Destroy Word”**
    
    - **d** = delete operator
        
    - **w** = motion “to the start of the next word”
        
    - **Together:** delete from your cursor up to (but not including) the first character of the next word.
        
3. **`cw` → “Change Word”**
    
    - **c** = change operator (delete then enter Insert mode)
        
    - **w** = motion “to next word”
        
    - **Together:** delete the word under the cursor and switch you into Insert mode so you can type a replacement.
        
4. **`x` → “eXcise a character”**
    
    - **x** = delete the character under the cursor
        
    - **No extra motion needed** – it’s a single-key command.
        

---

## **📝Yank & Paste**

5. **`yy` → “Yank, Yeah!”**
    
    - **y** = yank (copy) operator
        
    - **y** = motion “whole line”
        
    - **Together:** copy the entire current line into the unnamed register.
        
6. **`yw` → “Yank Word”**
    
    - **y** = yank operator
        
    - **w** = motion “to next word”
        
    - **Together:** copy from the cursor to the start of the next word.
        
7. **`p` → “Put it down”**
    
    - **p** = paste after the cursor (or after the cursor’s line, if it’s a linewise yank)
        
8. **`P` → “Paste Previously”**
    
    - **P** = paste before the cursor (or before the line)
        

---

## **⏪ Undo & Redo**

9. **`u` → “Undo the Universe”**
    
    - **u** = undo the last change
        
10. **`Ctrl+r` → “Replay Again”**
    
    - **Ctrl+r** = redo (replay the change you just undid)
        

---

## **🧭 Navigation**

11. **`/` → “Search Slash”**
    
    - **/** = start a forward search; type your text and press Enter
        
12. **`n` → “Next”**
    
    - **n** = jump to the _n_ext match of your last search (forward)
        
13. **`%` → “Match Maker”**
    
    - **%** = jump between matching pairs of `()`, `{}`, `[]`
        
14. **`gg` → “Go to Ground”**
    
    - **g** = prefix for an action
        
    - **g** = with no extra argument, “go to the first line of the file”
        
15. **`G` → “Go Down”**
    
    - **G** = without a number, “go to the last line of the file”
        

---

## **📏 Indentation**

16. **`>>` → “Shift Right”**
    
    - **>** = indent operator
        
    - **>** = motion “current line”
        
17. **`<<` → “Shift Left”**
    
    - **<** = unindent operator
        
    - **<** = motion “current line”
        

---

## **🎨 Visual Modes**

18. **`v` → “Visualize”**
    
    - **v** = enter character-wise Visual mode
        
19. **`V` → “Visual Line”**
    
    - **V** = enter line-wise Visual mode
        
20. **`Ctrl+v` → “Visual Block”**
    
    - **Ctrl+v** = enter block-wise Visual mode

---

💡 Got your own silly way to remember a command?  
Feel free to fork this file or share ideas — learning is better when it's weird and fun.