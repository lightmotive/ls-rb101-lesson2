# frozen_string_literal: true

# ***
puts "\n* Question 1 *"
# Write a one-line program that prints "The Flintstones Rock!" 10 times with each subsequent line
# indented 1 space to the right:
10.times { |idx| puts "#{' ' * idx}The Flintstones Rock!" }

# ***
puts "\n* Question 2 *"
# The result of the following statement would be an error:
# puts "the value of 40 + 2 is " + (40 + 2)
# Why is that and what are two possible ways to fix it?
#   The cause: (40 + 2) evaluates to an integer;
#   Ruby doesn't implicitly convert different types of operands with the + operator--good for safety.
# Solutions: explicitly convert (40 + 2) to a string or use string interpolation
puts 'the value of 40 + 2 is ' + (40 + 2).to_s
puts "the value of 40 + 2 is #{40 + 2}"

# ***
puts "\n* Question 3 *"
# How can you make this work without using begin/end/until?
# Note that we're not looking to find the factors for 0 or negative numbers, but we just want to handle it gracefully 
# instead of raising an exception or going into an infinite loop.

def factors(number)
  divisor = number
  factors = []
  loop do
    factors << number / divisor if number % divisor == 0
    divisor -= 1
    break if divisor.zero?
  end
  factors
end

p factors(9)

# ***
puts "\n* Question 4 *"
# ...

# ***
puts "\n* Question 5 *"
# ...

# ***
puts "\n* Question 6 *"
# ...

# ***
puts "\n* Question 7 *"
# ...

# ***
puts "\n* Question 8 *"
# ...

# ***
puts "\n* Question 9 *"
# ...

# ***
puts "\n* Question 10 *"
# ...
