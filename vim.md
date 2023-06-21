# Vim notes

- `vim [filename]` : start-up vim, load or create a [filename]
- `vim -p file1 file2` : start-up vim in tab mode with 2 files loaded

---

## commands (command mode)
  - `esc` to enter command mode
  - `.` : repeat the last command

### navigate (motion / movement)
  - use arrow keys or `h`: left, `k`: up, `j`: down, `l`: right to navigate
  - `$` : move to end of line (including last character)
  - `w` : move to start of (next) word (excluding first character)
  - `e` : move to end of (current or next) word (including last character)
  - `0` : move to start of a line
  - `8e` : move to 8th (next) word, end of word
  - `ctrl-f` : forward a page
  - `ctrl-b` : backward a page
  - `{` : beginning of current paragraph
  - `}` : end of current paragraph
  - `[[` : first line of file
  - `]]` : last line of file
  - `ctrl-i` : next edit location
  - `ctrl-o' : last edit location

#### tabs
  - `:tabe file1` : open a new tab, open 'file1'
  - `:clo` : close tab / window
  - `gt` : next tab
  - `gT` : previous tab
  - `2gt` : 2nd tab

#### windows
  - `:vs file1` : vertical split - opens 'file1'
  - `:sp file1` : horizontal split - opens 'file1'


  - `ctrl-w w` : switch windows (or can use `ctrl-w h` or `l`)
  - `ctrl-w r` : rotate windows (change position)
  - `ctrl-w >` : make current window 1 col bigger
  - `:clo` : close tab / window

### edit
  - `u` : undo last command
  - `U` : return line to original state
  - `CTRL - r` : redo

  - `x` : delete character
  - `i` : enter 'insert mode' to enter text BEFORE cursor
  - `a` : enter 'insert mode' to enter text AFTER cursor
  - `I` : enter 'insert mode' to enter text at FRONT of the line
  - `A` : enter 'insert mode' to enter text at END of the line
  - `dw` : delete word
  - `d$` : delete from cursor to end of line
  - `de` : delete from cursot to end of word
  - `d3w` : delete next 3 words
  - `dd` : delete whole line
    - `ddp` : 'move' a line down (delete line, then put after cursor)
    - `ddkP` : 'move' a line up (delete line, move, then put before cursor) 
  - `2dd` : 2 x delete line (i.e., delete 2 lines)
  - `o` : insert (next) line, move to start of that line, and enter insert mode
  - `caw` : 'change a word'

  - `r` then character to replace with : 'replaces' the current character with a new one

  - `y` : yank (copy)
    - `yy` : copy current line (w/ newline character)
    - `y$` : copy everything from cursor to end of line
    - `y^` : cut everything from cursor to start of line
    - `yiw` : copy current word
    - `yw` : copy to start of next word
    - `y%` : copy to matching character (supported pairs are `()`, `{}`, `[]`)
  - `p` : put (paste)

  - `v` : visual mode (to select)
  - `V` : select by line
  - `ctrl-v` : visual block mode

### search
  - `/foo` : searches for 'foo'
  - `/` : type search terms [press enter]
  - `n` : next occurence
  - `N` : previous occurence


---

## : commands
  - `:` : type this first, then
    - `q` : quit
    - `q!` : quit without saving
    - `wq` : write then quit
