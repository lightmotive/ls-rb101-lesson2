# frozen_string_literal: true

# Sum Even Number Rows
# ====================
# Imagine a sequence of consecutive even integers beginning with 2.
# The integers are grouped in rows, with the first row containing one integer,
# the second row two integers, the third row three integers, and so on.
# Given an integer representing the row_number of a particular row, return an
# integer representing the sum of all the integers in that row.

# PEDAC, phase 1: Understand the problem
# ======================================
# Input: An integer that represents the row number of sequential numbers incrementing by 2.
# Output: Integer that's the sum of the integers that row.
#
# Rules:
#   - The first row has a single row_number: 2.
#   - The second row has two numbers that continue the even row_number sequence (increment by 2): 4, 6
#   - Each subsequent row contains a row_number of even integers equal to the row number and continue
#     that incremental sequence.
#   - Example:
#       Row 1: 2
#       Row 2: 4, 6
#       Row 3: 8, 10, 12
#       ...and so on...

# PEDAC, phase 2: Examples and Test Cases
# =======================================
# (1) => 2
# (2) => 10
# (4) => 68

# PEDAC, phase 3: Data Structures
# ===============================
# This will be a dynamically generated structure (or a mathematical solution, which wouldn't require a data structure).
# However, if we had to represent it with a data structure, a nested array structure would work.
# [
#   [2],
#   [4, 6],
#   [8, 10, 12],
#   ...
# ]
# One could basically generate each row, discarding previous rows (to minimize memory usage) until the specified row is reached.

# PEDAC, phase 4: Algorithm
# =========================
# High-level:
# Given a row number as an integer, generate a sequence of even numbers up to the
# - The first row contains the row_number 2.
# - Each subsequent row continues the sequence and adds a row_number, with each row_number incrementing by 2.
# - Generate rows up to the specified integer.
# - Finally, sum the last row of numbers.
#
# - *Note: one could fairly easily replace nested array generation with a mathematical solution.
#
# Pseudocode:
# Given a row_number as an integer
#
# RETURN 0 if row_number <= 0
#
# SET numbers = [[2]]
# SET sequence_increment = 2
# SET current_row = 1
#
# WHILE current_row < row_number
#   INCREMENT current_row
#
#   SET row_numbers = [numbers.last.last + sequence_increment]
#   WHILE row_numbers.size < current_row
#     APPEND (row_numbers.last + sequence_increment) to row_numbers
#   ENDWHILE
#
#   APPEND row_numbers to numbers
# ENDWHILE
#
# RETURN numbers[row_number].sum

def row_numbers(numbers, row_number, sequence_increment)
  row_numbers = [numbers[-1][-1] + sequence_increment]
  row_numbers.push(row_numbers[-1] + sequence_increment) while row_numbers.size < row_number
  row_numbers
end

def sum_at_row(row_number)
  return 0 unless row_number.positive?

  numbers = [[2]]
  sequence_increment = 2
  current_row = 1

  while current_row < row_number
    current_row += 1
    numbers.push(row_numbers(numbers, current_row, sequence_increment))
  end

  numbers[row_number - 1].sum
end

p sum_at_row(1) == 2
p sum_at_row(2) == 10
p sum_at_row(4) == 68

# The problem statement doesn't specify anything about using each rows numbers in any way. Therefore,
# the literal solution above could be optimized in at least a couple ways:
# - Eliminate number storage (no arrays)
#   - Pros: Low memory usage; logic to iterate through and capture numbers if they're needed for other purposes.
#   - Cons: Iterating to add numbers requires more operations than a mathematical solution,
#     especially for higher row numbers.
# - Mathematical
#   - Pros: As efficient as possible; minimal code.
#   - Cons: None unless one needs to capture the "structure's" numbers, which would require writing a new
#     iterating solution.

# Increment and then sum at the specified 'row' - minimal memory requirements, but no access to generated numbers array.
puts "\nOptimized algorithm - no arrays"
def increment_row(number_last_row, row_number, increment)
  incremented = number_last_row

  number_count = 0
  while number_count < row_number
    incremented += increment
    yield(incremented) if block_given?
    number_count += 1
  end

  incremented
end

def sum_row(number_last_row, row_number, increment)
  sum = 0
  increment_row(number_last_row, row_number, increment) { |incremented| sum += incremented }
  sum
end

def sum_at_row_optimized(row_number)
  return 0 unless row_number.positive?

  number = 0
  increment = 2
  current_row = 0

  loop do
    current_row += 1
    break sum_row(number, current_row, increment) if current_row == row_number

    number = increment_row(number, current_row, increment)
  end
end

p sum_at_row_optimized(1) == 2
p sum_at_row_optimized(2) == 10
p sum_at_row_optimized(4) == 68

# Optimize with math:
puts "\nMath-optimized algorithm:"
# High-level math explanation:
# The row_number can tell us how many sequential numbers to generate.
# [
#   [2],                       2
#   [4, 6],                    4 * r + 2
#   [8, 10, 12],               8 * r + 2 + (2*2)
#   [14, 16, 18, 20],         14 * r + 2 + (2*2) + (2*3) -> same as f * r + (2 * (((r-1) * r) / 2))
# ]
def sum_at_row_math(row_number)
  # To add a sequence of numbers: http://www.themathworld.com/math-tricks/adding-sequence-of-numbers.php
  previous_row_number_count = ((row_number - 1) * row_number) / 2
  first_number = (previous_row_number_count + 1) * 2
  first_number * row_number + (2 * (((row_number - 1) * row_number) / 2))
end

p sum_at_row_math(1) == 2
p sum_at_row_math(2) == 10
p sum_at_row_math(4) == 68
