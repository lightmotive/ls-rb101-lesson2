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
# ...

# ***
puts "\n* Question 3 *"
# ...

# ***
puts "\n* Question 4 *"
# ...
