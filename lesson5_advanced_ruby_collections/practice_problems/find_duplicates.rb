# frozen_string_literal: true

require_relative '../../../ruby-common/benchmark_report'
require_relative '../../../ruby-common/test'

def test_generate_duplicates(array, count)
  duplicates = []
  count.times do
    duplicate = array.sample
    duplicate = array.sample while duplicates.include?(duplicate)
    duplicates.push(duplicate)
  end
  duplicates
end

def test_random_array_with_duplicates(element_count, duplicate_count)
  array = []
  1.upto(element_count) { |number| array.push(number) }

  duplicates = test_generate_duplicates(array, duplicate_count)
  array.push(*duplicates).shuffle!

  [array, duplicates.sort]
end

test_large100k = { label: 'large100k' }
test_large100k[:input], test_large100k[:expected_output] = test_random_array_with_duplicates(100_000, 10)
test_verylarge1m = { label: 'verylarge1m' }
test_verylarge1m[:input], test_verylarge1m[:expected_output] = test_random_array_with_duplicates(1_000_000, 50)

TESTS = [
  { label: 'small_one_dup_set', input: [1, 5, 3, 1, 2, 7, 2], expected_output: [1, 2] },
  { label: 'small_multi_dup_set', input: [1, 5, 3, 1, 2, 7, 2, 1], expected_output: [1, 1, 2] },
  test_large100k,
  test_verylarge1m
].freeze

def find_duplicates_by_select_with_index(arr)
  sorted = arr.sort
  sorted.select.with_index { |e, i| e == sorted[i - 1] }
end

run_tests('Select with Index', TESTS, ->(input) { find_duplicates_by_select_with_index(input) })

def find_duplicates_by_hash_map(arr)
  map = Hash.new(0)
  arr.each { |e| map[e] += 1 }

  map_duplicates = map.select { |_, v| v > 1 }

  map_duplicates.each_with_object([]) do |duplicate, duplicates|
    dup_count = duplicate[1] - 1
    dup_count.times { duplicates.push(duplicate[0]) }
  end.sort
end

run_tests('Hash Map', TESTS, ->(input) { find_duplicates_by_hash_map(input) })

benchmark_report(TESTS,
                 [
                   { label: 'Select with Index', method: ->(input) { find_duplicates_by_select_with_index(input) } },
                   { label: 'Hash Map', method: ->(input) { find_duplicates_by_hash_map(input) } }
                 ], iterations: 5)
