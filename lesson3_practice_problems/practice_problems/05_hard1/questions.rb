# frozen_string_literal: true

# ***
puts "\n* Question 1 *"
# What do you expect to happen when the greeting variable is referenced in the last line of the code below?

# rubocop:disable Style/IfUnlessModifier
if false
  greeting = 'hello world'
end
# rubocop:enable Style/IfUnlessModifier

p greeting
# => nil

# Control statements don't create new scopes, so variables initialized within are accessible outside.
# Ruby initializes the value to nil, and since the control expression condition is always false, greeting is never set.
# The same behavior applies to all control expressions, e.g.:
# rubocop:disable Style/WhileUntilModifier
while false
  greeting2 = 'false'
end
# rubocop:enable Style/WhileUntilModifier

p greeting2

# ***
puts "\n* Question 2 *"
# What is the result of the last line in the code below?

greetings = { a: 'hi' }
informal_greeting = greetings[:a]
informal_greeting << ' there'

puts informal_greeting #  => "hi there"
puts greetings # => { :a => 'hi there' }
# Reason: String#<< mutates the object to which informal_greeting points, which is the same string object stored
# in greetings[:a].

# ***
puts "\n* Question 3 *"
# What will be printed by each of the code groups?

# A)
# def mess_with_vars(one, two, three)
#   one = two
#   two = three
#   three = one
# end
#
# one = "one"
# two = "two"
# three = "three"
#
# mess_with_vars(one, two, three)
#
# puts "one is: #{one}"     # one is: one
# puts "two is: #{two}"     # two is: two
# puts "three is: #{three}" # three is: three

# Explanation for all outputs: methods create a new variable scope, and assignments never mutate variables.

# B)
# def mess_with_vars(one, two, three)
#   one = "two"
#   two = "three"
#   three = "one"
# end
#
# one = "one"
# two = "two"
# three = "three"
#
# mess_with_vars(one, two, three)
#
# puts "one is: #{one}"
# puts "two is: #{two}"
# puts "three is: #{three}"

# B has the same output for the same reasons.

# C)
# def mess_with_vars(one, two, three)
#   one.gsub!("one","two")
#   two.gsub!("two","three")
#   three.gsub!("three","one")
# end
#
# one = "one"
# two = "two"
# three = "three"
#
# mess_with_vars(one, two, three)
#
# puts "one is: #{one}"     # one is: two
# puts "two is: #{two}"     # two is: three
# puts "three is: #{three}" # three is: one

# Explanation for all outputs: String#gsub! mutates the caller; arguments passed to methods point to objects,
# so mutating parameter variables within methods mutates the associated passed argument.

# ***
puts "\n* Question 4 *"
# ...
