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


```ruby
=begin
Consider a character set consisting of letters, a space and a point.  

Words consist of one or more, but at most 20 letters.  

An input text consists of one or more words separated by one or more
spaces and terminated by 0 or more space terminating points.  

The output text is to be produced such that successive words are
separated by a single space with the last word being terminated by a single 
point.

Odd words are copied in reverse order while even words are merely echoed.
For example, the input string:

"whats the matter with kansas."
becomes
"whats eht matter htiw kansas."

BONUS POINTS: The characters must be read and printed out one at a tine.
=end
```


```ruby
# *Inside a preschool there are children, teachers, class assistants, a principal, janitors, and cafeteria workers. 
# *Both teachers and assistants can help a student with schoolwork and watch them on the playground. 
# *A teacher teaches and an assistant helps kids with any bathroom emergencies. 
# *Kids themselves can learn and play. 
# *A teacher and principle can supervise a class. 
# *Only the principal has the ability to expel a kid. 
# *Janitors have the ability to clean. 
# *Cafeteria workers have the ability to serve food. 
# # *Children, teachers, class assistants, principals, janitors and cafeteria workers all have the ability to eat lunch.

=begin 
Nouns: preschool, children, teachers, class assistants, principal, janitors, cafeteria workers, homework, playground, bathroom, lunch, class

verbs: help, watch, learn, play, supervise, expel, clean, serve, eat 

preschool has all the people
children: play,learn, eat
teachers: help, watch, teaches, supervise, eat
class assistants: help, watch, help(bathroom), eat
principals: supervise, expel, eat
Janitors: clean, eat
cafeteria workers: serve, eat

=end

module Helpable
  def help_with_work
  end
end

module Watchable
  def watch
  end
end

module Supervisable
  def supervise
  end
end

class Preschool 
  def eat 
  end
end

class Child < Class_of_children
  def play; end
  def learn; end
end

class Teachers < Preschool
  include Helpable
  
  def teach; end  
end

class Class_assistants < Preschool 
  include Helpable
  def help_with_bathroom
  end
end

class Principal < Preschool
  def expel; end
end

class Janitors < Preschool
  def clean; end 
end

class Cafeteria_workers < Preschool
  def serve; end 
end

#######################
module Preschool
  class Participant
    def eat(object); end
  end

  module Supervisable
    def supervise(object); end
  end

  module Helpable
    def help_with(object); end
  end

  class Child < Participant
    def learn; end

    def play(object); end
  end

  class Teacher < Participant
    include Supervisable
    include Helpable
    include Watchable
    
    def teach; end
  end

  class ClassAssistant < Participant
    include Helpable
    include Watchable
  end

  class Principal < Participant
    include Supervisable

    def expel; end
  end

  class Janitor < Participant
    def clean

    end
  end

  class Cafeteria_Worker < Participant
    def serve(object)

    end
  end

  class Homework

  end

  class Playground

  end

  class Bathroom

  end

  class Food

  end

  class Lunch < Food

  end

  class ClassofKids

  end

  
end
```