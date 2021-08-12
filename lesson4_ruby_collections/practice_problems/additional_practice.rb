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
# ...

# ***
puts "\n* Problem 9 *"
# ...

# ***
puts "\n* Problem 10 *"
# ...
