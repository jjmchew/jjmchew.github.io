# RB139 practice problems - answers

1

```ruby
# simple_game.rb
class SimpleGame
  def get_guess(input: $stdin)
    guess = nil
    loop do
      puts "Guess a number between 1 and 200 inclusive."
      guess = input.gets.chomp.to_i
      break if (1..200).cover?(guess)
      puts "Invalid guess.  Try again."
    end
    guess
  end
end
```

```ruby
# simple_game_test.rb
require 'minitest/autorun'
require_relative 'simple_game'

class SimpleGameTest < Minitest::Test
  def test_
end

---

