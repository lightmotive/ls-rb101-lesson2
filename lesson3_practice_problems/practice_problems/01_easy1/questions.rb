# frozen_string_literal: true

# Question 1
# What would you expect the code below to print out?

numbers = [1, 2, 2, 3]
numbers.uniq
# That creates a new array with unique values from numbers array. However, it isn't assigned to anything...
puts numbers
# Outputs the original numbers array, which Array#uniq didn't mutate.
