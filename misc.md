# Misc notes

- `\\wsl$` to access Ubuntu files in windows explorer ('network drive')
- in Ubuntu use `clear` to clear previous input from screen
  - in Ruby can use `system("clear") || system('cls')`

## Coding reminders for me
- don't add arguments to defs unless needed (don't plan too far ahead)
- decide / differentiate back-end 'data key' from 'display' characters (e.g., `'spock'` vs `'Spock'`) - *need to be consistent* (don't mix data key with display characters - always convert.  Don't get lazy - it will cause issues)
- run code through rubocop prior to submission
  - but don't make code more complicated by chasing rubocop errors (e.g., 'method too long') - take the time to think about how to make methods more sensible
- don't forget - loop iterators start from 0 unless otherwise defined
- when using hashes, be careful of string vs symbol
- in Ruby methods, just assigning an array parameter to a new variable doesn't create another version (also need to make a change to it at the same time)
