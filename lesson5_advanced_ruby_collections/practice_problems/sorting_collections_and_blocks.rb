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
# Print out the name, age and gender of each family member, e.g., "(Name) is a (age)-year-old (male or female)."
munsters.each { |name, data| puts "#{name} is a #{data['age']}-year-old #{data['gender']}." }

# ***
puts "\n* Practice Problem 7 *"
# Given this code, what would be the final values of a and b? Try to work this out without running the code.
a = 2
b = [5, 8]
arr = [a, b] # => [2, [5, 8]]

arr[0] += 2  # => [4, [5, 8]]
arr[1][0] -= a # a = 2; arr[1][0] = 5; use indexed assignment to change value at that position to 5 - 2
# => [4, [3, 8]]

# ***
puts "\n* Practice Problem 8 *"
# Using the each method, write some code to output all of the vowels from the strings.
hsh = { first: %w[the quick], second: %w[brown fox], third: ['jumped'], fourth: %w[over the lazy dog] }

hsh.each_value do |words|
  words.each do |word|
    word.scan(/[aeiou]/i) { |char| puts char }
  end
end

# ***
puts "\n* Practice Problem 9 *"
# Given this data structure, return a new array of the same structure but with the sub arrays being ordered
# (alphabetically or numerically as appropriate) in descending order.
arr = [%w[b c a], [2, 1, 3], %w[blue black green]]

new_arr = arr.map(&:sort)
p new_arr

# ***
puts "\n* Practice Problem 10 *"
# Given the following data structure and without modifying the original array, use the map method to return a new array
# identical in structure to the original but where the value of each integer is incremented by 1.
arr_hsh = [{ a: 1 }, { b: 2, c: 3 }, { d: 4, e: 5, f: 6 }]

arr_hsh2 = arr_hsh.map { |hsh| hsh.transform_values { |value| value + 1 } }
p arr_hsh2

# ***
puts "\n* Practice Problem 11 *"
# Given the following data structure use a combination of methods, including either the select or reject method, to
# return a new array identical in structure to the original but containing only the integers that are multiples of 3.
arr = [[2], [3, 5, 7], [9], [11, 13, 15]]

multiples_of_three = arr.map { |e| e.select { |n| (n % 3).zero? } }
p multiples_of_three

# ***
puts "\n* Practice Problem 12 *"
# Given the following data structure, and without using the Array#to_h method, write some code that will return a hash
# where the key is the first item in each sub array and the value is the second item.
arr = [[:a, 1], %w[b two], ['sea', { c: 3 }], [{ a: 1, b: 2, c: 3, d: 4 }, 'D']]
# expected return value: {:a=>1, "b"=>"two", "sea"=>{:c=>3}, {:a=>1, :b=>2, :c=>3, :d=>4}=>"D"}

hsh = arr.each_with_object({}) { |sub_arr, hsh| hsh[sub_arr[0]] = sub_arr[1] }
p hsh

# ***
puts "\n* Practice Problem 13 *"
# Given the following data structure, return a new array containing the same sub-arrays as the original but ordered
# logically by only taking into consideration the odd numbers they contain.
arr = [[1, 6, 7], [1, 4, 9], [1, 8, 3]]
# Expected result: [[1, 8, 3], [1, 6, 7], [1, 4, 9]]

p(arr.sort_by { |sub_arr| sub_arr.select(&:odd?) })

# ***
puts "\n* Practice Problem 14 *"
# Given this data structure write some code to return an array containing the colors of the fruits and the sizes of the
# vegetables. The sizes should be uppercase and the colors should be capitalized.
hsh = {
  'grape' => { type: 'fruit', colors: %w[red green], size: 'small' },
  'carrot' => { type: 'vegetable', colors: ['orange'], size: 'medium' },
  'apple' => { type: 'fruit', colors: %w[red green], size: 'medium' },
  'apricot' => { type: 'fruit', colors: ['orange'], size: 'medium' },
  'marrow' => { type: 'vegetable', colors: ['green'], size: 'large' }
}

p(hsh.each_value.map do |data|
  case data[:type]
  when 'fruit' then data[:colors].map(&:capitalize)
  when 'vegetable' then data[:size].upcase
  end
end)

# ***
puts "\n* Practice Problem 15 *"
# Given this data structure write some code to return an array which contains only the hashes where all the integers
# are even.
arr = [{ a: [1, 2, 3] }, { b: [2, 4, 6], c: [3, 6], d: [4] }, { e: [8], f: [6, 10] }]

# Basic logic:
# Iterate through each item in the array (hash)
#   Iterate through each value of the hash (arrays of numbers)
#     Iterate through each number; if any is odd, exclude the entire hash.
# Ruby has methods for succinct code and algorithmically efficient execution.
#   any?(&:odd) will be more efficient than all?(&:even) because the former does not need to check all array values.

p(arr.reject { |hsh| hsh.values.any? { |numbers| numbers.any?(&:odd?) } })

# ***
puts "\n* Practice Problem 16 *"
# Generate a UUID (Version 4/random)

# ** PEDAC **

# 1. Understand the problem
# ======================
# Problem Domain: https://en.wikipedia.org/wiki/Universally_unique_identifier
# - The problem statement describes a randomly generated UUID, which corresponds to Version 4.

# - Input: none
# - Output: randomly-generated UUID (Version 4)
#   - Each UUID consists of 32 hexadecimal characters.
#   - Typically broken into 5 sections like this 8-4-4-4-12.
#   - Represented as a string.
# Mental model: Generate '-'-separated groups of hexadecimal symbols. The number of symbols in each group: 8-4-4-4-12.

# 2. Examples and test cases
# ==========================
# There's no input, and output is randomly generated. Just ensure the correct format:
# "f65c57f6-a6aa-17a8-faa1-a67f2dc9fa91"
#
# 3. Data Structure
# =================
# - Array to represent the possible symbols.
# - Array to represent group counts.
#
# 4. Algorithm
# ============
# - random_hex_string(length): method to generate (length) number of hex symbols as a string.
#   - Sample from the array of possible symbols.
# - Map group_lengths array to generate strings, then join with the optionally specified separator.

HEX_CHARS = '0'.upto('9').to_a.concat('a'.upto('f').to_a).freeze
Ractor.make_shareable(HEX_CHARS)

def random_hex_string(length)
  HEX_CHARS.sample(length).join
end

def uuid_v4(group_lengths: [8, 4, 4, 4, 12], separator: '-')
  group_lengths.map { |length| random_hex_string(length) }.join(separator)

  # That's a fun exercise. In the real world, one should use SecureRandom#uuid or other RFC 4122-compliant
  # implementation to generate UUIDs:
  # require 'securerandom'
  # SecureRandom.uuid
end

p uuid_v4

# How many Version 4 UUIDs can we generate using the above super-basic implementation before getting a duplicate?
# Let's test:
require_relative '../../../ruby-common/benchmark_report'
require_relative '../../../ruby-common/test'

def test_generate_duplicate_report(size, count, reported, report_interval: 5)
  reported = 0 if reported.nil?
  percent_complete = (size / count.to_f).floor(2) * 100

  if percent_complete >= reported + report_interval
    puts "#{reported + report_interval}% generated"
    return percent_complete.to_i
  end

  reported
end

def generate_uuids(count)
  uuids = []
  uuids << uuid_v4 while uuids.size < count
  uuids
end

def generate_uuids_threaded(count, concurrency)
  ractors = []
  count_per_ractor = count / concurrency

  concurrency.times do
    ractors << Ractor.new(count_per_ractor) do |count|
      generate_uuids(count)
    end
  end

  ractors.map(&:take)
end

def duplicates?(uuids)
  uuids.uniq.size != uuids.size
end

# Find all duplicates
def duplicates(array)
  sorted = array.sort
  sorted.select.with_index { |element, idx| element == sorted[idx - 1] }
end

def array_to_hash_count(array)
  map = Hash.new(0)
  array.each { |e| map[e] += 1 }
  map
end

# To check for dups concurrently:
# - Pass uuid arrays generated in each ractor (don't flatten, just pass here).
# - Loop through to compare each array to the other arrays. One Ractor per comparison. Ractor result: duplicate list.
#   - Compare array1 to all arrays after it.
#   - Compare array2 to all arrays after it.
#   - ...and so on...
# Wanted to work on that problem, but it's time to continue with the Launch School curriculum!

def generate_uuids_with_options(count, options = { concurrency: 1 })
  return generate_uuids_threaded(count, options[:concurrency]).flatten if options[:concurrency] > 1

  generate_uuids(count)
end

def test_generate_duplicates(count, options = { concurrency: 1 })
  uuids = generate_uuids_with_options(count, options)

  if duplicates?(uuids)
    duplicates = duplicates(uuids)
    return "#{duplicates.size} duplicates found after generating #{uuids.size} UUIDs\n" \
           "#{array_to_hash_count(duplicates)}"
  end

  "No duplicates generated. Generations: #{uuids.size} | Concurrency: #{options[:concurrency]}."
end

TESTS = [
  { label: '1m UUIDs, Concurrency: 1', input: [1_000_000],
    expected_output: 'No duplicates generated. Generations: 1000000 | Concurrency: 1.' },
  { label: '1m UUIDs, Concurrency: 2', input: [1_000_000, { concurrency: 2 }],
    expected_output: 'No duplicates generated. Generations: 1000000 | Concurrency: 2.' },
  { label: '1m UUIDs, Concurrency: 4', input: [1_000_000, { concurrency: 4 }],
    expected_output: 'No duplicates generated. Generations: 1000000 | Concurrency: 4.' },
  { label: '1m UUIDs, Concurrency: 6', input: [1_000_000, { concurrency: 6 }],
    expected_output: 'No duplicates generated. Generations: 999996 | Concurrency: 6.' },
  { label: '1m UUIDs, Concurrency: 8', input: [1_000_000, { concurrency: 8 }],
    expected_output: 'No duplicates generated. Generations: 1000000 | Concurrency: 8.' }
].freeze

run_tests('test_generate_duplicates', TESTS, ->(input) { test_generate_duplicates(*input) })
# All tests passed (no duplicates generated).

benchmark_report_test_data(TESTS, ->(input) { test_generate_duplicates(*input) })
