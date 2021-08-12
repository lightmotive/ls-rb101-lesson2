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
# ...

# ***
puts "\n* Problem 7 *"
# ...

# ***
puts "\n* Problem 8 *"
# ...

# ***
puts "\n* Problem 9 *"
# ...

# ***
puts "\n* Problem 10 *"
# ...
