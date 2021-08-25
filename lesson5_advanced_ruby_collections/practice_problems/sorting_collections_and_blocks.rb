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
# For each of these collection objects demonstrate how you would reference the letter 'g'.
arr1 = ['a', 'b', ['c', %w[d e f g]]]
p arr1[2][1][3]

arr2 = [{ first: %w[a b c], second: %w[d e f] }, { third: %w[g h i] }]
p arr2[1][:third][0]

arr3 = [['abc'], ['def'], { third: ['ghi'] }]
p arr3[2][:third][0][0]

hsh1 = { 'a' => %w[d e], 'b' => %w[f g], 'c' => %w[h i] }
p hsh1['b'][1]

hsh2 = { first: { 'd' => 3 }, second: { 'e' => 2, 'f' => 1 }, third: { 'g' => 0 } }
p hsh2[:third].key(0)

# ***
puts "\n* Practice Problem 4 *"
# For each of these collection objects where the value 3 occurs, demonstrate how you would change this to 4.
arr1 = [1, [2, 3], 4]
arr1[1][1] = 4
p arr1

arr2 = [{ a: 1 }, { b: 2, c: [7, 6, 5], d: 4 }, 3]
arr2[2] = 4
p arr2

hsh1 = { first: [1, 2, [3]] }
hsh1[:first][2][0] = 4
p hsh1

hsh2 = { ['a'] => { a: ['1', :two, 3], b: 4 }, 'b' => 5 }
hsh2[['a']][:a][2] = 4
p hsh2

# ***
puts "\n* Practice Problem 5 *"
# Figure out the total age of just the male members of the family:
munsters = {
  'Herman' => { 'age' => 32, 'gender' => 'male' },
  'Lily' => { 'age' => 30, 'gender' => 'female' },
  'Grandpa' => { 'age' => 402, 'gender' => 'male' },
  'Eddie' => { 'age' => 10, 'gender' => 'male' },
  'Marilyn' => { 'age' => 23, 'gender' => 'female' }
}

p(munsters.select { |_, data| data['gender'] == 'male' }.values
  .inject(0) { |sum, data| sum + data['age'] })

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
