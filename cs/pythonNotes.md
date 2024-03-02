# Python notes

## Installing Pyenv
- https://medium.com/@therazmatrix/how-to-install-and-use-pyenv-in-ubuntu-22-04-fa7c28ca0b67

1. `sudo apt update`
2. `curl https://pyenv.run | bash`

  Message after running above:
    WARNING: seems you still have not added 'pyenv' to the load path.

    > Load pyenv automatically by appending
    > the following to
    > ~/.bash_profile if it exists, otherwise ~/.profile (for login shells)
    > and ~/.bashrc (for interactive shells) :

    export PYENV_ROOT="$HOME/.pyenv"
    [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"

    > Restart your shell for the changes to take effect.
    > Load pyenv-virtualenv automatically by adding
    > the following to ~/.bashrc:

    eval "$(pyenv virtualenv-init -)"

3. restart Ubuntu
4. `pyenv --version` should work
5. install additional packages (e.g., bzip2) (I had to do this since running the install line below didn't work)
```
sudo apt install build-essential libssl-dev zlib1g-dev \ 
libbz2-dev libreadline-dev libsqlite3-dev curl \
libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
```
6. `pyenv install 3.12.2` (latest version according to python.org)
7. `pyenv global 3.12.2` (to set latest version to the "global" version [vs local])
8. `python` or `python3` or `python file.py`

## Syntax notes
https://docs.python.org/3/library/stdtypes.html

- in Python everything is an object (`type()` gives the class/type of the object)

- in REPL:
  - e.g., `mystring = 'hello'`
  - then type `mystring.` and then hit tab to display all methods on string type

- strings
  - can be `'` or `"`
  - escape characters with `\`;  e.g., `'this isn\'t good'`
  - to reverse a string, use slice: `reversed_string = "hello"[::-1]` (assigns `'olleh'`)

- multi-line strings:  `"""` to start and end
  - or use `\n` (newline, linux) `\r` (carriage return), `\t` (tab), `\\` escaped slash
  - note:  windows newline is `\r\n`

- lists (arrays)
  - can use negative indices to count from end
  - out-of-bound indexes raise an error (either positive or negative)

- numbers
  - can write numbers with `_` as separators:  e.g., `2_928_933`

- None <class 'NoneType'>


