# frozen_string_literal: true

# ***
puts '* Question 1 *'

ages = { 'Herman' => 32, 'Lily' => 30, 'Grandpa' => 402, 'Eddie' => 10 }
# Check if "Spot" is present:
p ages.include?('Spot')
# Bonus: What are two other hash methods that would work just as well for this solution?
p ages.key?('Spot')
p ages.member?('Spot')

# ***
puts '* Question 2 *'

munsters_description = 'The Munsters are creepy in a good way.'
# Convert the string in the following ways (code will be executed on original munsters_description above):
# "tHE mUNSTERS ARE CREEPY IN A GOOD WAY."
p munsters_description.swapcase
# "The munsters are creepy in a good way."
p munsters_description.capitalize
# "the munsters are creepy in a good way."
p munsters_description.downcase
# "THE MUNSTERS ARE CREEPY IN A GOOD WAY."
p munsters_description.upcase

# ***
puts '* Question 3 *'
# We have most of the Munster family in our age hash. Add ages for Marilyn and Spot to the existing hash:
additional_ages = { 'Marilyn' => 22, 'Spot' => 237 }

ages.merge!(additional_ages)
p ages

# ***
puts '* Question 4 *'
# Check if the name "Dino" appears in the string below:
advice = String.new('Few things in life are as important as house training your pet dinosaur.')
p advice.include?('Dino') # Find any sub-string
p advice.match?(/\bDino\b/) # Find a separate word
p advice.match?(/Dino/i) # Find a case-insensitive match

# ***
puts '* Question 5 *'
# Show an easier way to write this array:
# flintstones = ["Fred", "Barney", "Wilma", "Betty", "BamBam", "Pebbles"]
flintstones = %w[Fred Barney Wilma Betty BamBam Pebbles]
p flintstones

# ***
puts '* Question 6 *'
# How can we add the family pet "Dino" to our usual array:
p(flintstones << 'Dino')
# Alternative: flintstones.push('Dino')

# ***
puts '* Question 7 *'
# How can we add multiple items to our array? (Dino and Hoppy)
flintstones.push('Dino', 'Hoppy')
# Array#push alias: #append
# Alternative method: flintstones.concat(%w[Dino Hoppy])
p flintstones.uniq! # ...because Dino was added in exercise 6

# ***
puts '* Question 8 *'
# Shorten the advice variable contents as follows:
# Make the return value "Few things in life are as important as ". But leave the advice variable as "house training your pet dinosaur.".
advice_prefix = advice.slice!('Few things in life are as important as ')
p advice_prefix
puts "#{advice_prefix}#{advice}"

# ***
puts '* Question 9 *'
# ...

# ***
puts '* Question 10 *'
# ...
