[1, 2, 3].select do |num|
  num > 5
  'hi'
end
# => [1, 2, 3]
# Why? Because 'hi' is truthy, and select returns a new array by selecting values from the caller where the block's
# return value is truthy. The block always returns 'hi' because it's the last statement.

%w[ant bat caterpillar].count do |str|
  str.length < 4
end
# => 2
# Why? The Array#count method increments when the block's return value is truthy. The documentation makes that clear:
# "With no argument and a block given, calls the block with each element; returns the count of elements for which the
# block returns a truthy value..."
# https://docs.ruby-lang.org/en/master/Array.html#method-i-count
