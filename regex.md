# RegEx

- Regex for Ruby:  <https://ruby-doc.org/core-3.1.2/Regexp.html>
  - <https://rubular.com/>
>
- Regex for JS  <https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/RegExp>
  - <https://scriptular.com/>
- <https://regex101.com/>

>
- `/\b#{var}\b/` : search for a var (string) within strings
  - `\b` limits operation to complete words, not substrings (e.g., don't replace 'eight' in 'freight')

## Basics / matching
- always enclose regex in `/[regex here]/`
- to search for special characters, need to escape them with `\`
  - `$ ^ * + ? . ( ) [ ] { } | \ /`
  - in a character class (within `[ ]`) **only** `^ \ - [ ]` are special characters
    - you can use `^` or `-` as non-meta char (i.e., not special) if they are NOT the first character in the class 
  - e.g., `/\?/`
  - `:` and ` ` (space) have no special meaning in regex - function like other regular characters
    - note:  this may differ in specific programs (e.g., like Rubular: use `/[ ]/` vs `/ /` )
- `|` used to combine patterns (e.g., `/(cat|dog|rabbit)/` selects all instances of 'cat', 'dog', 'rabbit') 
- `\n` : line feed
- `\r` : carriage return
- `\t` : tab
- add `i` after regex (e.g, `/s/i`) for case-**in**sensitive matching
- note:  regex is NOT a variable or a string (in Ruby)
  - e.g.,:
  ```ruby
  def testsub(string, regex)
    p string
    p string.gsub!(regex, '=')
  end
  testsub('Kx BlacK kelly', /K/) # note regex provided without quotes
  ```
- e.g., matches 'blueberry' or 'blackberry' but not 'berry' : `/(blue|black)berry/`
- character classes:  list characters within square brackets
  - matches any occurrence of any characters between the brackets
  - e.g., `/[abc]/`, `/[Jj]ames/` matches 'James' or 'james'
  - `/[12345]/` matches 1, 2, 3, 4, or 5
  - `/[ab][12]/` matches a1 a2 b1 b2
  - can list ranges with `-`
    - e.g., `/[0-9]/` or `/[a-z]/` or `/[j-p]/`
    - e.g. hex digits are: `/[0-9A-Fa-f]/` (0-9, A-F, a-f, spaces don't count)
    - e.g., `/[A-Za-z]/`
    - warning:  don't mix upper and lower case into the same range (e.g., `[A-z]`), don't mix non-alphanumeric characters
  - `^` as first char in class creates a *negated* class (i.e., match everything except what's in the class)
    - e.g., `/[^y]/` matches any char except 'y' (including spaces, newlines, non-alphanumeric, etc.)
- `/./` matches all characters EXCEPT newlines
- `\s` matches whitespace characters (` ` space,`\t` tab, `\v` vertical tab, `\r` carriage return, `\n` line feed, `\f` form feed)
- `\S` matches all non-whitespace characters
- `\d` any decimal digit (0-9)
- `\D` any character except Decimal digit
- `\w` matches word characters: incl. a-z, A-Z, 0-9, _ 
- `\W` matches non-word characters (all except above)

## Anchors
- anchors fix regex match to `$`(end) and `^`(beginning) 
  - e.g., `/^cat/` ('cat' at start of line) vs `/cat$/` ('cat' at end of line)
- 


