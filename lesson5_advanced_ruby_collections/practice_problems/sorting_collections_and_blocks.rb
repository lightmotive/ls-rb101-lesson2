# frozen_string_literal: true

# ***
puts "\n* Practice Problem 1 *"
# How would you order this array of number strings by descending numeric value?
arr = %w[10 11 9 7 8]

p arr.sort_by(&:to_i).reverse
# Enumerable#sort_by is more efficient than #sort with conversion because it results in fewer String#to_i calls.
# https://docs.ruby-lang.org/en/master/Enumerable.html#:~:text=this%20is%20exactly%20what%20sort_by%20does%20internally.

# ***
puts "\n* Practice Problem 2 *"
# ...

# ***
puts "\n* Practice Problem 3 *"
# ...

# ***
puts "\n* Practice Problem 4 *"
# ...

# ***
puts "\n* Practice Problem 5 *"
# ...

# ***
puts "\n* Practice Problem 6 *"
# ...

# ***
puts "\n* Practice Problem 7 *"
# ...

# ***
puts "\n* Practice Problem 8 *"
# ...

# ***
puts "\n* Practice Problem 9 *"
# ...

# ***
puts "\n* Practice Problem 10 *"
# ...

# ***
puts "\n* Practice Problem 11 *"
# ...

# ***
puts "\n* Practice Problem 12 *"
# ...

# ***
puts "\n* Practice Problem 13 *"
# ...

# ***
puts "\n* Practice Problem 14 *"
# ...

# ***
puts "\n* Practice Problem 15 *"
# ...

# ***
puts "\n* Practice Problem 16 *"
# ...
