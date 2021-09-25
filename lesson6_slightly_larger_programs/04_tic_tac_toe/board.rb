# frozen_string_literal: true

require_relative '../../../ruby-common/validation_error'

SQUARE_WIDTH_PADDING = 1
SQUARE_VERTICAL_PADDING = 0

def board_state_empty(size: 3)
  Array.new(size) { Array.new(size, nil) }
end

def board_row_padding(column_count)
  column_count.times.map { ' ' * (SQUARE_WIDTH_PADDING * 2 + 1) }.join('|')
end

def board_row_markers(columns)
  columns.map do |marker|
    "#{' ' * SQUARE_WIDTH_PADDING}#{marker.nil? ? ' ' : marker}#{' ' * SQUARE_WIDTH_PADDING}"
  end.join('|')
end

def board_row_string(columns)
  row_string = board_row_markers(columns)

  if SQUARE_VERTICAL_PADDING.positive?
    row_string =
      "#{SQUARE_VERTICAL_PADDING.times.map { board_row_padding(columns.size) }.join("\n")}\n" \
      "#{row_string}\n" \
      "#{SQUARE_VERTICAL_PADDING.times.map { board_row_padding(columns.size) }.join("\n")}"
  end

  row_string
end

def board_row_divider(column_count)
  column_count.times.map { '-' * (SQUARE_WIDTH_PADDING * 2 + 1) }.join('+')
end

def board_display(board_state)
  row_strings = board_state.map do |columns|
    "#{board_row_string(columns)}\n"
  end

  puts "\n#{row_strings.join("#{board_row_divider(board_state[0].size)}\n")}\n"
end

def coordinates_to_indices(coordinates)
  row_index = coordinates[:row] - 1
  column_index = coordinates[:column] - 1

  [row_index, column_index]
end

# Ensure move coordinates are valid (within bounds, board square free)
def validate_move_coordinates(coordinates, board_state)
  bounds = 1..board_state.size

  unless bounds.include?(coordinates[:row]) && bounds.include?(coordinates[:column])
    raise ValidationError, "Row and Column should be between #{bounds.first} and #{bounds.last}."
  end

  row_index, column_index = coordinates_to_indices(coordinates)
  raise ValidationError, 'Please choose an empty square.' unless board_state[row_index][column_index].nil?

  nil
end

def available_move_coordinates(board_state)
  available_moves = []

  board_state.each_with_index do |row, row_idx|
    row.each_with_index do |column, column_idx|
      available_moves.append({ row: row_idx + 1, column: column_idx + 1 }) if column.nil?
    end
  end

  available_moves
end

def board_mark!(user_id, coordinates, board_state)
  row_index, column_index = coordinates_to_indices(coordinates)
  board_state[row_index][column_index] = user_id

  board_state
end

def board_columns(board_state)
  board_state[0].zip(*board_state[1..-1])
end

def board_diagonals(board_state)
  diagonal_by_index = ->(row, idx) { row[idx] }
  top_left_diagonal = board_state.map.with_index(&diagonal_by_index)
  bottom_left_diagonal = board_state.reverse.map.with_index(&diagonal_by_index)

  [top_left_diagonal, bottom_left_diagonal]
end
