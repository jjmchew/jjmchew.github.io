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
- RuboCop ABC (Assignment Branch Condition) Size errors:  https://launchschool.com/lessons/dfff5f6b/assignments/e1ba7b4b
- Ruby exceptions:  https://launchschool.medium.com/getting-started-with-ruby-exceptions-d6318975b8d1

- `echo $0` to see which terminal you're using (i.e., bash vs zsh)

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

## interesting articles / links
- https://medium.com/@jasonherngwang/using-jit-learning-to-build-an-app-during-launch-schools-capstone-prep-2a67e2023454
- https://ethanweiner.medium.com/adjusting-learning-during-the-transition-from-core-to-capstone-3efdd6d24650
- https://vim-adventures.com
- The Coding Career Handbook : https://www.learninpublic.org/
- https://medium.com/@abmrodger/spiegel-im-spiegel-in-ruby-9ad13fb30cad
- https://www.reddit.com/r/launchschool/comments/klxl2t/a_full_week_of_content_on_study_habits_tools_and/
- https://www.youtube.com/watch?v=U-wvbwnYC7Y


## Notes from Tyler Frye on studying
On top of the A+ check list, I'd highly recommend checking out the podcast I link below (and others, they're great). But this one in particular is a recording of a SPOT session from Jake, the guy who created the Checklist.
Some things you'll want to do and in no particular order...
Go through the course content again and if you learn ANYTHING new, no matter how small it is, go over everything again. Because if there's one small thing you've missed, there's probably more.
Do ALL of the exercises at least once. Save exercises you struggle with, when you first start LS for the day, work through the ones you've been struggling with until you don't have to look at any solutions or help to solve them. Keep solving them every day or couple days until they become trivial. By the time you're assessment ready, any exercise chosen at random should be trivial for you to solve.
Focus on the material provided, don't get caught up in rabbit holes. Playing around and developing deep understanding is a must, but don't let yourself fall too deep outside of the presented content.
If you haven't taken Barbara Oakley's Learning How to Learn course on Coursera AND read the companion book "A Mind for Numbers" DO BOTH OF THOSE. They are HUGE in terms of learning how to learn. The first podcast from Season 3 was with her. She's great.
When you're starting to feel comfortable, go through every quiz and make sure you can 100% all of them.
Write things in your own words. Be able to speak openly and easily about topics and to be able to write a paragraph explaining an individual topic. A lot of explaining involved in the assessments, make sure you can discuss concepts easily in both written and spoken form WITHOUT notes/references.
Utilize the SPOT Wiki for practice problems. Be able to answer all of them with ease.
Find study techniques that work for you, put some effort into learning what exists and what works for you. It's okay if you don't enjoy one technique or the other, play around with what's out there, find what works and what YOU personally find the value in. There's no one-size-fits-all here
Utilize Code Review for projects. You may think you have a good understanding of something, but might learn something valuable from someone more knowledgeable than you looking at your code.
Know your study limits. Push your limits in terms of time invested per day. How many hours can you go without needing a break and still maintaining QUALITY studying? How many hours can you go per day total with breaks and still be learning actively, not getting bogged down. There's no need to be pushing yourself to these limits every day, or even regularly unless you're trying to race to graduation, but the better you know yourself in this way, the more studious you're able to be.
Attend SPOT and TA Lead Study Sessions. Even if you've already been to a couple for your course, if there's free spots. GO. This is one of the few places students can have "collisions". We don't have hallways.
STUDY WITH OTHERS. Utilize GatherTown. Studying with other students is 100% the biggest boon of the LS Community. Reach out to people from your Study Groups, DM other people who are working on the same assessment as you, ask in these study-group channels. Not everyone will bite, but people WILL. Working with others, studying concepts together, having to 'teach' each other in preparation will all solidify your own knowledge and very easily point out the holes in your mental model. By going back and forth with others you stand to gain much stronger mental models, accuracy and precision with your language and knowledge than just by studying alone. Everyone looks at things differently, the perspective of other people is invaluable. You will be surprised how much 'less prepared' you might feel after spending one hour talking about concepts with another student, this is a good thing. Adding on to this, this step is basically necessary if you want to feel prepared for Interview assessments, but I recommend doing it all the time, for both types and just in general. I used to be very much a 'study alone and by myself' person. But now, I would put THIS on the top of the list as #1 most important study tool. S-Tier study tactic.
And finally, to actually answer your original question.. 'how long should I be studying to prepare for the assessments?' That's a tough question to answer, because the answer is different for everybody for each assessment. It's not something you can so much measure yourself in hours until after it's completed so my advice and what I personally do...
Prepare until you feel like there's nothing you could possibly do that would prepare you further for the assessment. That may feel like it will never come, but it will, and you will know the feeling once you get there. When you have done everything I've listed above, everything on the A+ Checklist, etc etc. You will know. When the concepts, ideas, code and everything else is so ingrained in your mind and fingers that someone asking you ANY given question seems totally trivial and a waste of your time to even be thinking about at this point, you're ready to take the assessments. This may be a BIT extreme, but hopefully you get the point. There's no rush or time limit for when you have to take the assessment, and personally I believe that you should never take the assessment until you feel 100% as if there's nothing more you could do to further prepare. I know that's not necessarily the answer you're looking for, but if you want to A+ every assessment, it's the mindset you will want to adopt. Remember, we are on the Slow Path to Mastery. If you need to finish LS in a time frame, put more hours in per week (if possible) to more quickly achieve mastery but don't burn yourself out.
Sorry for the big wall of text, but I hope you can take some value from this post. These are things that I've learned to adopt in my time at LS and I used to be quite the opposite of 'studious.' I've posted relevant links below. Thanks for reading
Learning How to Learn
Transforming at Launch School (Think this is essentially the same as the video posted above)
Jake's A+ Checklist: https://medium.com/@jakedevar111/there-are-many-ways-to-study-for-an-assessment-however-this-is-the-best-way-that-i-have-found-for-ed85cea4ffba
The SPOT Wiki
Join The SPOT Slack Channel
Launch School Podcast with Barbara Oakley : https://podcast.launchschool.com/oakley

### Versions
- Announced on June 6, 2023:
  - We're pleased to announce that we've updated the Ruby courses, books, and exercises for use with Ruby 3.2 and Rubocop 1.51.0. (The older recommendations were Ruby 2.7 and Rubocop 0.86.0).