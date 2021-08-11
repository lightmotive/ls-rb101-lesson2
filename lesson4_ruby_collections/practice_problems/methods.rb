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

[1, 2, 3].reject do |num|
  puts num
end
# => [1, 2, 3]
# According to the docs (https://docs.ruby-lang.org/en/master/Array.html#method-i-reject), "Returns a new Array whose
# elements are all those from self for which the block returns false or nil..."
# "puts num" always returns nil

%w[ant bear cat].each_with_object({}) do |value, hash|
  hash[value[0]] = value
end
# => { 'a' => 'ant', 'b' => 'bear', 'c' => 'cat' }
# Enumerable#each_with_object returns the object passed as an argument. The block mutates that argument.

hash = { a: 'ant', b: 'bear' }
hash.shift
# => [:a, 'ant']
hash
# => { b => 'bear' }
# According to the docs (https://docs.ruby-lang.org/en/master/Hash.html#method-i-shift), "Removes the first hash entry
# (see Entry Order); returns a 2-element Array containing the removed key and value...
# Returns the default value if the hash is empty"
