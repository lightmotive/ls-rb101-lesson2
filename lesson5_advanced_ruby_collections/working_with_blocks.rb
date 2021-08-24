# frozen_string_literal: true

# Example 3
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
