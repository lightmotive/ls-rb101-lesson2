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
# What's wrong with this code?
# The problem: the limit variable is not accessible inside the fib method, which creates a new scope.
# The fix: pass limit to the method as an argument.
def fib(first_num, second_num, limit)
  while first_num + second_num < limit
    sum = first_num + second_num
    first_num = second_num
    second_num = sum
  end
  sum
end

result = fib(0, 1, 15)
puts "result is #{result}"

# ***
puts "\n* Question 6 *"
# What is the output of the following code?

answer = 42

def mess_with_it(some_number)
  some_number += 8
end

new_answer = mess_with_it(answer)

p answer - 8
# The output would be 34 (42 - 8); numbers are immutable in Ruby.
# Also, mess_with_it wouldn't mutate any other types of values because assignments like that never mutate variables.
# (Indexed assignments are different.)

# ***
puts "\n* Question 7 *"
# One day Spot was playing with the Munster family's home computer and he wrote a small program to mess with their
# demographic data:
munsters = {
  'Herman' => { 'age' => 32, 'gender' => 'male' },
  'Lily' => { 'age' => 30, 'gender' => 'female' },
  'Grandpa' => { 'age' => 402, 'gender' => 'male' },
  'Eddie' => { 'age' => 10, 'gender' => 'male' },
  'Marilyn' => { 'age' => 23, 'gender' => 'female' }
}

def mess_with_demographics(demo_hash)
  demo_hash.values.each do |family_member|
    family_member['age'] += 42
    family_member['gender'] = 'other'
  end
end

# After writing that method, he typed the following...and before Grandpa could stop him,
# he hit the Enter key with his tail:
mess_with_demographics(munsters)

# Did the family's data get ransacked? Why or why not?
#   Yes! mess_with_demographics loops through each value, a Hash object, and uses indexed assignment, which is mutating.
p munsters

# ***
puts "\n* Question 8 *"

def rps(fist1, fist2)
  if fist1 == 'rock'
    fist2 == 'paper' ? 'paper' : 'rock'
  elsif fist1 == 'paper'
    fist2 == 'scissors' ? 'scissors' : 'paper'
  else
    fist2 == 'rock' ? 'rock' : 'scissors'
  end
end

# What is the result of the following call?
puts rps(rps(rps('rock', 'paper'), rps('rock', 'scissors')), 'rock')

# Ruby uses strict evaluation, which means arguments are evaluated and converted to objects
# before passing them to methods. So, let's break it down like Ruby would:
# rps(rps(rps('rock', 'paper'), rps('rock', 'scissors')), 'rock')
# rps(rps('paper', rps('rock', 'scissors')), 'rock')
# rps(rps('paper', 'rock'), 'rock')
# rps('paper', 'rock')
# paper

# ***
puts "\n* Question 9 *"
# ...

# ***
puts "\n* Question 10 *"
# ...
