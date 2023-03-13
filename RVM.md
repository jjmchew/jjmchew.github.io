# RVM notes

- `ruby -v` to check which version of Ruby is being used

### Gemsets
See current gemset
- `rvm gemset name` (see current gemset)\
(my default gemset so far is `lsrb100`)
- `rvm gemset list` (to list all gemsets)

Using gemsets
- `rvm 2.7.5@lsrb100` or `rvm use 2.7.5@lsrb100`
- `gem install rubocop --version 0.86.0` (example of installing gems to gemset)
- `gem list` to see 'local gems'

Set ruby version for projects
- at command line, in project directory `rvm --ruby-version use 2.2.2`  [source](https://launchschool.com/books/core_ruby_tools/read/ruby_version_managers)
- to set default version in all other folders:
  ```
  cd ~
  rvm --ruby-version default
  ```
  




