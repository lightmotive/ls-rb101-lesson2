# frozen_string_literal: true

array = [1, 2, 3]

array.map { |num| num + 1 }
# => [2, 3, 4]

p array.map { |num| num + 1 }
# That returns the mapped array [2, 3, 4] because {...} blocks have slightly higher precedence than do...end blocks,
# and higher precedence than method calls, so array.map binds more tightly to the block.
# Array.map with block is evaluated; the result is passed to method p.

array.map do |num|
  num + 1
end

p array.map do |num|
  num + 1
end
# That returns an Enumerator (array:map) because do...end blocks have the lowest precedence--lower than method calls.
# p is called with array.map, then the do...end block is passed to the Enumerator result (which doesn't do anything).

# MORAL OF THE STORY: use parentheses when an expression contains multiple operators!
