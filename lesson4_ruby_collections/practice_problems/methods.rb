[1, 2, 3].select do |num|
  num > 5
  'hi'
end
# => [1, 2, 3]
# Why? Because 'hi' is truthy, and select returns a new array by selecting values from the caller where the block's
# return value is truthy. The block always returns 'hi' because it's the last statement.
