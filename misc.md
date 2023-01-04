# Misc notes

- `\\wsl$` to access Ubuntu files in windows explorer ('network drive')
- in Ubuntu use `clear` to clear previous input from screen
  - in Ruby can use `system("clear") || system('cls')`
- UUIDs:  <https://www.rfc-editor.org/rfc/rfc4122> or use `SecureRandom#uuid` in Ruby standard library
- CoderPad Sandbox : <https://app.coderpad.io/sandbox>
- practice markdown editor:  <https://jbt.github.io/markdown-editor/>
- https://jsinibardy.com/first-weeks-software-engineer#introduction
- <mobti.me>
- <https://replit.com/>
- https://dmitryzuev.com/dev/pass-arguments-to-ruby-modules/


## Coding reminders for me
- don't add arguments to defs unless needed (don't plan too far ahead)
- decide / differentiate back-end 'data key' from 'display' characters (e.g., `'spock'` vs `'Spock'`) - *need to be consistent* (don't mix data key with display characters - always convert.  Don't get lazy - it will cause issues)
- run code through rubocop prior to submission
  - but don't make code more complicated by chasing rubocop errors (e.g., 'method too long') - take the time to think about how to make methods more sensible
- don't forget - loop iterators start from 0 unless otherwise defined
- when using hashes, be careful of string vs symbol
- in Ruby methods, just assigning an array parameter to a new variable doesn't create another version (also need to make a change to it at the same time)
- don't forget closing `end` for `if` blocks
- double-check methods, remember `.any?` returns true/false
  - use if `?` is generally a true/false
- be careful with `sort` - it's non-destructive.  To view outcome of running `sort`, need to assign it to a new var to inspect that var

## Assessment notes
- make sure to read the question and *answer the question* first.  Explanations are only necessary to explain the answer for the question asked


##### Regex
- when matching strings (e.g., regex exercises), double-check matching of capitals vs lowercase
- double-check which characters need to be escaped (e.g., in character classes)

## Are you (Launch School) assessment-ready?
- have you read all of the material more than once?  (including linked blog post and articles)
- have you answered all practice problems at *least* once?
- have you practiced summarizing the material in your own words?
- have you gotten 100% on every quiz?  (not necessarily the first time - if you go back, would you get 100%)
- can you confidently discuss *every* topic on the study guide? (express concepts with clarity and precision)
- have you gone through the material a final time and not learned anything new?
- for interviews: have you practiced answering coding questions in front of people?

## Live coding feedback:
- need to communicate more - not just talk out loud (i.e., don't just mutter to myself)
- don't hack and slash - don't just 'try things' : work to understand the problem (e.g., with code if debugging) and act with intent
- should know my methods pretty cold
- are we allowed to look up methods?  (e.g., each_with_index, each_index? )
