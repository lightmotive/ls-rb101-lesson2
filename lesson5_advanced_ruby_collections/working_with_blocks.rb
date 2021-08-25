# frozen_string_literal: true

# Example 3
# =========
[[1, 2], [3, 4]].map do |arr|
  puts arr.first
  arr.first
end

# Detailed breakdown
# 1. Array with two sub-arrays calls method Array#map.
# 2. map iterates through each element in the caller; each element is an array. The iteration block:
#     1. puts the first element of each array (1, then 3).
#     2. returns the first element of each array (1, then 3).
#         - map inserts each return value into an array (new array to start).
# 3. map returns the new array that it built from the values returned from the block passed to map.

# Example 4
# =========
my_arr = [[18, 7], [3, 12]].each do |arr|
  arr.each do |num|
    puts num if num > 5
  end
end

# Detailed breakdown:
# 1. my_arr is assigned to the result of an Array#each method call.
# 2. The array calls each and passes a block, which iterates through each element of that array.
#     - Each element is an array.
#       - Each array then calls each, passing a block that iterates over each element.
#         - Each element is a number.
#         - if the number is > 5, then puts num.
#           - STDOUT will display 18, then 7, then 12 (each on a separate line).
#         - The block always returns nil because puts returns nil and there are no statements after the if expression.
#       - The Array#each returns nil, which isn't used.
#     - Each returns the original array.
# 3. The result of the Array#each call is assigned to my_arr, which is [[18, 7], [3, 12]]
#     - Array#each always returns the caller.
# 4. The final result is the original array assigned to my_arr
#     => [[18, 7], [3, 12]]

# Example 5
# =========
[[1, 2], [3, 4]].map do |arr|
  arr.map do |num|
    num * 2
  end
end
# - [[1, 2], [3, 4]] calls map and passes a block, which passes each element to the block.
#   - Each element passed to the block is an array.
#   - Each array calls map with a block, which passes each element to the block.
#     - Each element is a number.
#     - Each number is multiplied by 2 in the block; the block returns the results to arr.map, building an array.
#       => [2, 4]
#       => [6, 8]
#     - The block returns each of those arrays to the first Array#map call.
#   - The first Array#map method inserts each of those results into an array, which results in:
#     => [[2, 4], [6, 8]]
# - The final result is the array that the first Array#map method built:
# => [[2, 4], [6, 8]]

# Example 6
# =========
[{ a: 'ant', b: 'elephant' }, { c: 'cat' }].select do |hash|
  hash.all? do |key, value|
    value[0] == key.to_s
  end
end
# => [{ :c => "cat" }]

# Summary breakdown:
# An array of hashes calls select with a block. #select passes each hash in the array to the block.
# In the block, the hash calls Enumerable#all? with a block that evaluates whether the first character of the value
# equals the value's key for all key-value pairs. It passes the result to the select method.
# #select adds the associated hash to a new array if it receives true from the block.
# There are no side effects.

# Example 9
# =========
[[[1], [2], [3], [4]], [['a'], ['b'], ['c']]].map do |element1|
  element1.each do |element2|
    element2.partition do |element3|
      element3.size > 0
    end
  end
end
# => [[[1], [2], [3], [4]], [["a"], ["b"], ["c"]]]

# Breakdown:
# - Level 1: Array with sub-arrays represented by element1
#   - element1 calls each, which will return the original value of of element1 to map.
#     - At this point, we can probably consider this a bug because the remaining calls have no program impact.
#     - We'd want to determine the desired result of the call to map before continuing.
# - That array that map returns will have a different object ID than the caller, but it's elements will point to the
#   same objects in memory as the objects within the calling array.
