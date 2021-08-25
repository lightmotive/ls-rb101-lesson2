# frozen_string_literal: true

# ***
puts "\n* Practice Problem 1 *"
# How would you order this array of number strings by descending numeric value?
arr = %w[10 11 9 7 8]

p arr.sort_by(&:to_i).reverse
# Enumerable#sort_by is more efficient than #sort with conversion because sort_by requires in fewer String#to_i calls.
# https://docs.ruby-lang.org/en/master/Enumerable.html#:~:text=this%20is%20exactly%20what%20sort_by%20does%20internally.

# ***
puts "\n* Practice Problem 2 *"
# How would you order this array of hashes based on the year of publication of each book, from the earliest
# to the latest?
books = [
  { title: 'One Hundred Years of Solitude', author: 'Gabriel Garcia Marquez', published: '1967' },
  { title: 'The Great Gatsby', author: 'F. Scott Fitzgerald', published: '1925' },
  { title: 'War and Peace', author: 'Leo Tolstoy', published: '1869' },
  { title: 'Ulysses', author: 'James Joyce', published: '1922' }
]

p(books.sort_by { |hash| hash[:published].to_i })
# While it's not necessary to convert the publish year to integer when looking at the sample data, we'll convert
# in case the data ever would contain a pre-1000 year.

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
