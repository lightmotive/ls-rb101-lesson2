# frozen_string_literal: true

# ***
# Question 1
# What would you expect the code below to print out?

numbers = [1, 2, 2, 3]
numbers.uniq
# That creates a new array with unique values from numbers array. However, it isn't assigned to anything...
p numbers
# Outputs the original numbers array, which Array#uniq didn't mutate.

# ***
# Question 2
# Describe the difference between ! and ? in Ruby.
#   - !: commonly called a bang in programming. In Ruby (and some other languages):
#     - It negates whatever it prefixes. By convention, methods suffixed with it are caller-mutating "bang methods".
#   - ?: multiple programming languages (e.g., JavaScript) use this for ternary conditional expressions. In Ruby:
#     - Ruby conventions dictate that ?-suffixed methods will always return a boolean value.
#     - Also used with ternary conditional expressions.

# Explain what would happen in the following scenarios:
# 1. what is != and where should you use it?
#   - "not equal" operator. Use it to evaluate whether the left and right operands are not equal.
# 2. put ! before something, like !user_name
#   - Negates the truthy value of user_name. One could use it to determine whether the value is nil,
#     but that wouldn't clearly communicate the code's intent.
# 3. put ! after something, like words.uniq!
#   - Ruby convention indicating that the method will mutate the caller.
# 4. put ? before something
#   - Acts as a ternary conditional expression separator: [expression - truthy or falsey] ? [if true] : [if false]
# 5. put ? after something
#   - Ruby convention indicating that the method will return a boolean value.
# 6. put !! before something, like !!user_name
#   - Double-negation, which can convert truthy and falsey values into booleans.

# ***
# Question 3
# Replace the word "important" with "urgent" in this string (mutate the original string):
advice = 'Few things in life are as important as house training your pet dinosaur.'
p advice.gsub!('important', 'urgent')
