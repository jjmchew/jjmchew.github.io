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
  - `b` : move back a word
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
  - `ctrl-o` : last edit location
  - `507G` : goes to line 507

#### tabs
  - `:tabe file1` : open a new tab, open 'file1'
  - `:tabf[ind] .` : open a new tab and the file explorer
    - `:Te` : open a file explorer window and open file in new tab (vim only, not nvim)
  - `:clo` : close tab / window
  - `gt` : next tab
  - `gT` : previous tab
  - `g<Tab>` : goto last opened tab
  - `2gt` : 2nd tab

#### windows
  - `:vs file1` : vertical split - opens 'file1'
  - `:sp file1` : horizontal split - opens 'file1'

  - `:vertical resize 120` : resize vertical width to '120'

  - `ctrl-w w` : switch windows (or can use `ctrl-w h` or `l`)
  - `ctrl-w r` : rotate windows (change position)
  - `ctrl-w >` : make current window 1 col bigger
  - `ctrl-w =` : make all windows the same width
  - `:clo` : close tab / window

  - `:Ve` : opens an interactive file explorer to create a vertical split
  - `:Se` : opens an interactive file explorer to create a horizontal split

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
  - `o` : 'open' (next) line, move to start of that line, and enter insert mode
    - `O` : open (previous) line (i.e., start a line ABOVE cursor)
  - `caw` : 'change a word'

  - `r` then character to replace with : 'replaces' the current character with a new one
  - `R` : enter 'Replace' mode - overwrites the character under the cursor

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

  - `>>` : indent current line (need to set shiftwidth - see commands)
    - `4>>` : indents the next 4 lines


### search
  - `/foo` : searches (fwd) for 'foo'
  - `?foo` : searches (bkwd) for 'foo'
  - `/` : type search terms [press enter]
  - `n` : next occurence
  - `N` : previous occurence
  - `zz` : centre the screen on current occurrence
  - `:noh` : stop highlighting search terms, use this after searching

  - `%` : finds matching brackets (goes back and forth b/w the pair)

  - `f`{char} : searches for the next instance of {char}
  - `;` : repeats the last search

  - `*` : searches for the word under the cursor


### recordings
  - `q` + [letter] : allows you to record keypresses into a register denoted by [letter]
    - press `q` again to stop recording
    - press `@` + [letter] : 'replay' keystrokes

### commenting / uncommenting blocks
- `ctrl-v` to select multiple lines
- `:norm i#` (for ruby) or `:norm //` (for javascript)

- `:norm x` (to remove 1 char) or `:norm xx` (to remove 2 chars) (uncomment)

- `:norm` runs vim commands at each line in the specified range


### definitions
- `gd` or `gD` : "go to definitions" - opens source code defining the symbol under the cursor


---

## : commands
  - `:` : type this first, then
    - `q` : quit
    - `q!` : quit without saving
    - `wq` : write then quit

  - `:s/old/new/g` : substitutes 'old' for 'new' on the entire line
    - `:1,20s/old/new/g` : substitutes all occurences between lines 1 and 20
    - `:%s/old/new/g` : change every occurence in the whole file
    - `:%s/old/new/gc` : find every occurence in the whole file, prompt to change
    - `&` repeats the last `:s` command

  - `:! [shell command]` : lets you execute shell commands and return to file editor

  - `@:` : repeat the last ':' command

## Settings
  - `:set number` : show line numbers (absolute)
    - `:set nu!` : toggle show absolute line numbers
    - `:set nonumber` : hide line numbers
  - `:set relativenumber` : show relative line numbers
    - `:set rnu!` : toggle relative line numbers 

  - `:set list` : display eol characters
  - `:set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<` : show eol, tab, trailing spaces, ?, ?

  - `:set tabstop=2` : set width of tab character
  - `:set shiftwidth=2` : set width of `>>` command
  - `:set expandtab` : use spaces instead of tab character

  - `:set hlsearch` : enable highlighting of search terms
  - `:set scrolloff=999` : (or `so=999`) keeps cursor in the centre of the screen (default is so=0)

  - `:highlight Comment ctermfg=darkgrey` : changes color of comments to dark grey instead of blue
  - `:hi LineNr ctermfg=darkgrey` : changes color of line numbers (hi is short for highlight)
  - `:set bg=dark` or `:set bg=light` : changes VIM terminal to dark or light (adjusts color scheme for contrast)
  - `:colorscheme <tab>` : will allow pressing tab to cycle through color schemes available in vim

  - `:set foldmethod=indent` : folds all code based on indent
  - `:set foldmethod=marker` : folds code based on set fold markers
      - highlight w/ C-v and set marker with `zf`

    - `zo` : open immediate fold under cursor
    - `zO` : open ALL nested folds under cursor

    - `zc` : close immediate fold under cursor
    - `zC` : close ALL nested folds under cursor

  - `:set wrap` : to visually display long lines with wrap



### backup nvim config
- mv ~/.config/nvim{,.bak}

- mv ~/.local/share/nvim{,.bak}
- mv ~/.local/state/nvim{,.bak}
- mv ~/.cache/nvim{,.bak}


### Alternate NVIM config
- installed LazyVim into `~/.config/LazyVim`
  - ran `alias nvl='NVIM_APPNAME="LazyVim" nvim'`
    - run `nvim-lazy` to use LazyVim config stored in `~/.config/LazyVim`












# Additional Resources:
- https://medium.com/@shaikzahid0712/the-neovim-series-32163eb1f5d0
- Auto Pairs:  https://medium.com/@shaikzahid0713/auto-pairs-for-neovim-60f20ae94387
- disable `cmp` autocompletion:  https://www.reddit.com/r/neovim/comments/rh0ohq/nvimcmp_temporarily_disable_autocompletion/

- Using VIM for note-taking and syncing with web / phone:  https://jamesbvaughan.com/markdown-pandoc-notes/

