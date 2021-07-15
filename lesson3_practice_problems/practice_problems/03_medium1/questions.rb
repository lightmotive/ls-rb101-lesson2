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
  while divisor.positive?
    factors << number / divisor if (number % divisor).zero?
    divisor -= 1
  end
  factors
end

p factors(9)
p factors(0)
p factors(-9)
# The purpose of (number % divisor) is to find divisors that divide into number with no remainder.
#   Factors are whole numbers that are multiplied together to produce another number.
#   Ref: https://www.calculatorsoup.com/calculators/math/factors.php
# The purpose of the last line in the factors method: return the array of factors.
#   Without it, the loop's result would return, which would be nil because break doesn't include an argument.

# ***
puts "\n* Question 4 *"
# Is there a difference between these two methods other than the operator used to add an element to the buffer?
def rolling_buffer1(buffer, max_buffer_size, new_element)
  buffer << new_element
  buffer.shift if buffer.size > max_buffer_size
  buffer
end

def rolling_buffer2(input_array, max_buffer_size, new_element)
  buffer = input_array + [new_element]
  buffer.shift if buffer.size > max_buffer_size
  buffer
end

# Yes, there are two significant differences:
# - 1 will add whole arrays if new_element is an array;
#     2 will concatenate elements if new_element is an array.
# - 1 will mutate the argument passed to the buffer parameter, returning the mutated buffer;
#     2 will create a new buffer object, leaving input_array unchanged and returning the new buffer.

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
