# frozen_string_literal: true

# ***
puts "\n* Problem 1 *"
flintstones = %w[Fred Barney Wilma Betty Pebbles BamBam]
# Turn this array into a hash where the names are the keys and the values are the positions in the array.

flintstones_hash = {}
flintstones.each_with_index { |name, idx| flintstones_hash[name] = idx }
p flintstones_hash

# ***
puts "\n* Problem 2 *"
# Add up all of the ages from the Munster family hash:
ages = { 'Herman' => 32, 'Lily' => 30, 'Grandpa' => 5843, 'Eddie' => 10, 'Marilyn' => 22, 'Spot' => 237 }
p ages.values.sum

# ***
puts "\n* Problem 3 *"
ages = { 'Herman' => 32, 'Lily' => 30, 'Grandpa' => 402, 'Eddie' => 10 }
ages.delete_if { |_, age| age >= 100 }
p ages

# ***
puts "\n* Problem 4 *"
# Pick out the minimum age from our current Munster family hash:
ages = { 'Herman' => 32, 'Lily' => 30, 'Grandpa' => 5843, 'Eddie' => 10, 'Marilyn' => 22, 'Spot' => 237 }
p ages.values.min

# ***
puts "\n* Problem 5 *"
# Find the index of the first name that starts with "Be"
flintstones = %w[Fred Barney Wilma Betty BamBam Pebbles]
p(flintstones.index { |name| name.start_with?('Be') })

# ***
puts "\n* Problem 6 *"
# Amend this array so that the names are all shortened to just the first three characters:
flintstones = %w[Fred Barney Wilma Betty BamBam Pebbles]
p(flintstones.map! { |name| name[0, 3] })

# ***
puts "\n* Problem 7 *"
# Create a hash that expresses the frequency with which each letter occurs in this string:
statement = 'The Flintstones Rock'

char_occurrences = Hash.new(0)
statement.delete('^A-Za-z').chars.each do |char|
  char_occurrences[char] += 1
end

p(char_occurrences.sort_by { |_, value| value }.reverse.to_h)

# ***
puts "\n* Problem 8 *"
# What happens when we modify an array while we are iterating over it?

# Ruby docs and source code show that Array#each iterates by index/position and explicitly states that it allows
# array modification during iteration.

# What would be output by this code?
numbers = [1, 2, 3, 4]
numbers.each do |number|
  p number
  numbers.shift(1)
end
# Output:
# 1
# 3
# Walkthrough:
# Iteration 1:
#   - #each index is 0; the element at that position is 1, so "p number" outputs 1.
#   - numbers.shift(1) removes the first element of the array, so it becomes [2, 3, 4].
# Iteration 2:
#   - #each index is 1; the element at that position is 3, so "p number" outputs 3.
#   - numbers.shift(1) removes the first element of the array, so it becomes [3, 4].
#   - Ruby stops iterating at this point. Looking at the source code...
#     - for (i=0; i<RARRAY_LEN(ary); i++) { ...
#     - ...one can see that Ruby checks the array length with each loop. At the next pass, i will be 2 (i++), which is
#       equal to RARRAY_LEN(ary). Therefore, the for loop exits.
#   - In other words, Ruby source iterates on a reference to the array, not a copy of it, so changes affect iteration.

# What would be output by this code?
numbers = [1, 2, 3, 4]
numbers.each do |number|
  p number
  numbers.pop(1)
end
# Output:
# 1
# 2
# The walkthrough/explanation would be similar, except that the elements are removed from the end of the array.

# ***
puts "\n* Problem 9 *"
# Write your own version of the rails titleize implementation.

# A simplified titleize. A more robust implementation would not upcase certain words/positions and would be localized.
def titleize(string)
  string.split.map(&:capitalize).join(' ')
end

p titleize('the flintstones rock')

# ***
puts "\n* Problem 10 *"
# ...
