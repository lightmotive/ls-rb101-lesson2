# frozen_string_literal: true

# Sum Even Number Rows
# ====================
# Imagine a sequence of consecutive even integers beginning with 2.
# The integers are grouped in rows, with the first row containing one integer,
# the second row two integers, the third row three integers, and so on.
# Given an integer representing the number of a particular row, return an
# integer representing the sum of all the integers in that row.

# PEDAC, phase 1: Understand the problem
# ======================================
# Input: An integer that represents the row number of sequential.
# Output: Integer that's the sum of the integers that row.
#
# Rules:
#   - The first row has a single number: 2.
#   - The second row has two numbers that continue the even number sequence (increment by 2): 4, 6
#   - Each subsequent row contains a number of even integers equal to the row number and continue
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
# - The first row contains the number 2.
# - Each subsequent row continues the sequence and adds a number, with each number incrementing by 2.
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

def row_numbers(numbers, row, sequence_increment)
  row_numbers = [numbers[-1][-1] + sequence_increment]
  row_numbers.push(row_numbers[-1] + sequence_increment) while row_numbers.size < row
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

# Now, one can optimize by either discarding previous rows or using math.

# Optimize by discarding previous rows:
puts "\nMemory-optimized algorithm"
def sum_at_row_memory_optimized(row_number)
  return 0 unless row_number.positive?

  numbers = [[2]]
  sequence_increment = 2
  current_row = 1

  while current_row < row_number
    current_row += 1
    numbers.push(row_numbers(numbers, current_row, sequence_increment))
    numbers.delete_at(0)
  end

  numbers.last.sum
end

p sum_at_row_memory_optimized(1) == 2
p sum_at_row_memory_optimized(2) == 10
p sum_at_row_memory_optimized(4) == 68

# Optimize with math:
puts "\nMath-optimized algorithm:"
# High-level math explanation:
# The row number can tell us how many sequential numbers to generate.
def sum_at_row_math(number)
  # To add a sequence of numbers: http://www.themathworld.com/math-tricks/adding-sequence-of-numbers.php
  previous_row_number_count = ((number - 1) * number) / 2
  first_number = (previous_row_number_count + 1) * 2
  first_number * number + (2 * (((number - 1) * number) / 2))
end

p sum_at_row_math(1) == 2
p sum_at_row_math(2) == 10
p sum_at_row_math(4) == 68
