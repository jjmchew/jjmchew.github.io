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
  - in a character class (within `[ ]`) **only** `^ \ - / [ ] . ` are special characters
    - you can use `^` or `-` as non-meta char (i.e., not special) if they are NOT the first character in the class 
  - e.g., `/\?/`
  - `:` and ` ` (space) have no special meaning in regex - function like other regular characters
    - note:  this may differ in specific programs (e.g., like Rubular: use `/[ ]/` vs `/ /` )
- `|` used to combine patterns (e.g., `/(cat|dog|rabbit)/` selects all instances of 'cat', 'dog', 'rabbit') 
- `\n` : line feed
- `\r` : carriage return
- `\t` : tab
- add `i` after regex (e.g, `/s/i`) for case-**in**sensitive matching
- add `g` after regex (e.g., `/s/g`) for 'global' matching (for JS)
- add `m` after regex (e.g., `/m`) for 'multiline' option to match newlines when using `.`
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
    - add `m` after regex (e.g., `/m`) for 'multiline' option to match newlines when using `.`
- `\s` matches whitespace characters (` ` space,`\t` tab, `\v` vertical tab, `\r` carriage return, `\n` line feed, `\f` form feed)
    - equivalent to `/[ \t\v\r\n\f]/`
- `\S` matches all non-whitespace characters
    - equivalent to `/[^ \t\v\r\n\f]/`
- `\d` any decimal digit (0-9)
- `\D` any character except Decimal digit
- `\h` any hexadecimal digit 0-9A-Fa-f (Ruby)
- `\H` any character except hexadecimal digit (Ruby)
- `\w` matches word characters: incl. a-z, A-Z, 0-9, _ 
- `\W` matches non-word characters (all except above)

## Anchors
- anchors fix regex match to `$`(end) and `^`(beginning) 
  - e.g., `/^cat/` ('cat' at start of *line*) vs `/cat$/` ('cat' at end of *line*)
- `\A` : ensure regex matches at beginning of *string* (doesn't seem to work for `\n`, `^` does)
- `\z` and `\Z` : ensure matches at end of *string* (doesn't seem to work for `\n`, `$` does)
  - `\z` always matches at end of *string* (after newline)
  - `\Z` matches up to, but NOT including the newline (before newline) at the end
  - use `\z` unless you need `\Z`
>
- `\b` : matches to word boundaries (words are sequences of word characters `\w`)
  - a boundary is b/w 2 char: 1 is a word char, one is not
  - `/\b[pattern]/` pattern begins at word boundary
  - `/[pattern]\b/` pattern ends at word boundary
- `\B` : matches to non-word boundaries (non-words are sequences of non-word characters `\W`)
- Note:  `\b` `\B` do not work in a character class `[ ]`
  - in brackets, it matches a backspace character
  - `/\B[pattern]/` pattern begins at non-word boundary
  - `/[pattern]\B/` pattern ends at non-word boundary

## Quantifiers
- `*` : match zero or more occurrences (of pattern to the left)
  - e.g. `\d\d\d\d*` matches 3 or more digits (note the `*` is 0 or more)
  - e.g., `/co*t/` matches 'ct', 'cot', 'coot', 'cooot'
  - note: `/x*/` will match between every character (0 x's)
- `+` : match 1 or more occurrences (of pattern to the left)
  - e.g. `\d\d\d+` also matches 3 or more digits
- `?` : matches once or not at all (i.e., 0 or 1 occurrence)

## Ranges
- `p{m}` : matches exactly `m` occurrences of pattern `p`
- `p{m,}` : matches `m` or more occurrences of `p`
- `p{m,n}` : matches `m` or more occurrences of `p`, but not more than `n`
>
- note:  quantifiers are **greedy** : will match the longest possible string available (and will not match a shorter one)
- adding `?` after pattern will return a **lazy** match (fewest number of characters possible)
  - e.g., `xabcbcbacy` tested against `/a[abc]*c/` will return `abcbcbac` and not `abc` or `abcbc`
  - using `/a[abc]*?c/` will match `abc` and `ac`
  - Note:  in Ruby, `gsub` will match (replace) every instance that fits pattern, but `string#match` will only match the first instance that fits
- remember:  once a character is 'consumed' in a match, it can't be used in another match
- `/x` at end of regEx in Ruby allows multi-line regex:
  - e.g.
  ```ruby
  /
    ^                  # Start of line
    (\d+,){2}          # 2 numbers at start
    (                  # followed by...
      (\d+,){3,}       #    at least 3 more numbers
    )?                 #    that are optional
    \d+                # followed by one last number
    $                  # end of line
  /x
  ```
- in Ruby:  can use `=~` for regex match 
  - e.g., `fetch_url(text) if text =~ /\Ahttps?:\/\/\S+\z/`
  - this is faster than using match
  - returns an **index** within string of where match occurs, or `nil` (`null` in JS)
- in Ruby:  can also use `String#scan` : global form of match, returns Array of all matching substrings

##### backreference
- Ruby:  `\#` : added at end of pattern is a reference to the #th 'capture group' in the regex
  - e.g., `/(['"]).+?\1/`
  - `( )` denote a 'group'
  ```ruby
  /
    (['"]) # single OR double quotes;  NOTE use of ()
    .+?    # 1 or more of any character except newline, lazy (shortest possible match)
    \1     # backreference to 1st capture group: single OR double quotes (whatever was originally matched)
  /
  ```
  - `\2`, `\3`, `\4`, etc match subsequent capture groups (reading from left to right)
  - when using capture groups with `"` (double quotes) and `sub` or `gsub`, need add an extra `\`
    - e.g.
    ```ruby
    text = %(We read "War of the Worlds".)
    puts text.sub(/(['"]).+\1/, '\1The Time Machine\1')
    # prints: We read "The Time Machine".
    # VS (note double quotes and extra \ )
    puts text.sub(/(['"]).+\1/, "\\1The Time Machine\\1")
    ```
- backreferences in JS use `$1`, `$2`, etc.









