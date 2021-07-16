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
# Ben was tasked to write a simple ruby method to determine if an input string is an IP address representing
# dot-separated numbers. e.g. "10.4.5.11". He is not familiar with regular expressions. Alyssa supplied Ben
# with a method called is_an_ip_number? that determines if a string is a numeric string between 0 and 255 as
# required for IP numbers and asked Ben to use it.

# def dot_separated_ip_address?(input_string)
#   dot_separated_words = input_string.split(".")
#   while dot_separated_words.size > 0 do
#     word = dot_separated_words.pop
#     break unless is_an_ip_number?(word)
#   end
#   return true
# end

# Alyssa reviewed Ben's code and says "It's a good start, but you missed a few things. You're not returning
# a false condition, and you're not handling the case that there are more or fewer than 4 components to the
# IP address (e.g. "4.5.5" or "1.2.3.4.5" should be invalid)."
#
# Help Ben fix his code.

def dot_separated_ip_address?(input_string)
  dot_separated_words = input_string.split('.')
  return false if dot_separated_words.length != 4

  # rubocop:disable Style/WhileUntilModifier
  while dot_separated_words.size.positive?
    return false unless is_an_ip_number?(dot_separated_words.pop)
  end
  # rubocop:enable Style/WhileUntilModifier
  true
end
