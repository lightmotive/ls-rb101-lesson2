# frozen_string_literal: true

# ***
puts '
* Question 1 *'
# Write a one-line program that prints "The Flintstones Rock!" 10 times with each subsequent line indented 1 space to the right:
def print_message_art(message)
  right_just_width = message.length
  10.times do
    puts message.rjust(right_just_width)
    right_just_width += 1
  end
end

print_message_art('The Flintstones Rock!')

# ***
puts '
* Question 2 *'
# ...

# ***
puts '
* Question 3 *'
# ...

# ***
puts '
* Question 4 *'
# ...

# ***
puts '
* Question 5 *'
# ...

# ***
puts '
* Question 6 *'
# ...

# ***
puts '
* Question 7 *'
# ...

# ***
puts '
* Question 8 *'
# ...

# ***
puts '
* Question 9 *'
# ...
