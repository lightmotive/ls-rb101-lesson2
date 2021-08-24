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
