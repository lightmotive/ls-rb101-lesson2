# frozen_string_literal: true

require 'pry'

def test
  a = 1
  puts a
end

arr = [1, 2, 3]

binding.pry
p arr
