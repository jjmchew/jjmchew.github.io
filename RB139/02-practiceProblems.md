# RB139 personal practice problems

1. Modify the following method definition and create a (Minitest) test file to automate the testing of both valid and invalid user input.
    ```ruby
    class SimpleGame
      def get_guess
        guess = nil
        loop do
          puts "Guess a number between 1 and 200 inclusive."
          guess = gets.chomp.to_i
          break if (1..200).cover?(guess)
          puts "Invalid guess.  Try again."
        end
        guess
      end
    end
    ```

2. How do `procs` and `blocks` differ?  Provide a code example of each being used.

3. Create a test file to test the output of the following code:
    ```ruby
    def complicated_output(*array)
      puts "Let me introduce:"
      array.each_with_index { |element, idx| puts " #{idx} >> #{element} << " }
      puts "========="
    end

    complicated_output("Chris", "Pat", "Tyler")
    ```

4. What are the various uses of `&`?

5. What does the following code output, and why?  What 1 line can be changed to create the (assumed) desired output?
    ```ruby
    def my_method(string, &chunk)
      proc { "you said #{string} and >#{chunk}<" }
    end

    var = my_method("hello") { "goodbye" }

    p var.call
    ```

6. What does the following code output, and why?
    ```ruby
    def make_greeting(name, &phrase)
      "#{name}, #{phrase}"
    end

    p make_greeting("Joe")
    ```

7. What is "unit testing" and why is it useful?

8. 