# frozen_string_literal: true

# ***
# Question 1
puts 'Question 1:'
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
puts 'Question 3:'
# Replace the word "important" with "urgent" in this string (mutate the original string):
advice = String.new('Few things in life are as important as house training your pet dinosaur.')
p advice.gsub!('important', 'urgent')

# ***
# Question 4
puts 'Question 4:'
numbers = [1, 1, 1, 2, 3, 4, 5]

# What do the following method calls do (assume we reset numbers to the original array between method calls)?
numbers.delete_at(1)  # Delete the value at index 1 (second value)
numbers.delete(1)     # Delete all values matching 1
p numbers

# ***
# Question 5
puts 'Question 5:'
# Programmatically determine if 42 lies between 10 and 100.
p (10..100).cover?(42)
# Range#cover? can also declaratively evaluate whether a range fits within another:
p ('a'..'z').cover?(('c'..'m'))

# In this case, one could also just use use two comparisons:
min = 10
max = 100
find = 42
p min <= find && find <= max

# ***
# Question 6
puts 'Question 6:'
famous_words = String.new('seven years ago...').tap { |x| p x.object_id }
# Show two different ways to put the expected "Four score and " in front of it:
# Non-mutating
p "Four score and #{famous_words}"
p 'Four score and ' + famous_words

# Mutating
p(famous_words.prepend('Four score and ').tap { |x| p x.object_id })
famous_words = String.new('seven years ago...')
p(famous_words.insert(0, 'Four score and '))

# ***
# Question 7
puts 'Question 7:'
# If we build an array like this:
flintstones = %w[Fred Wilma]
flintstones << %w[Barney Betty]
flintstones << %w[BamBam Pebbles]
# We will end up with this "nested" array:
# ["Fred", "Wilma", ["Barney", "Betty"], ["BamBam", "Pebbles"]]

# Make that into an un-nested array:
p(flintstones.flatten!)
