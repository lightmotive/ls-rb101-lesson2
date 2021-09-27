# frozen_string_literal: true

require_relative '../../../ruby-common/validation_error'

SQUARE_WIDTH_PADDING = 1
SQUARE_VERTICAL_PADDING = 0

def board_state_empty_row(size, input_number_start)
  size.times.map { |idx| input_number_start + idx }
end

def board_state_empty(size: 3)
  size.times.map { |idx| board_state_empty_row(size, idx * size + 1) }
end

def board_row_padding(column_count)
  column_count.times.map { ' ' * (SQUARE_WIDTH_PADDING * 2 + 1) }.join('|')
end

def board_row_marks(columns)
  columns.map do |mark|
    "#{' ' * SQUARE_WIDTH_PADDING}#{mark}#{' ' * SQUARE_WIDTH_PADDING}"
  end.join('|')
end

def board_row_string(columns)
  row_string = board_row_marks(columns)

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

def move_number_to_indices(move_number, board_state)
  indices = []

  board_state.each_with_index do |row, row_idx|
    row.each_with_index do |value, column_idx|
      break indices << row_idx << column_idx if value == move_number
    end
    break unless indices.empty?
  end

  indices
end

def move_value?(value)
  value.is_a?(Integer)
end

# Ensure move coordinates are valid (within bounds, board square free)
def validate_move(move_number, board_state)
  bounds = 1..board_state.size**2

  unless bounds.include?(move_number)
    raise ValidationError, "Your move number should be between #{bounds.first} and #{bounds.last}."
  end

  unless available_moves(board_state).include?(move_number)
    raise ValidationError, 'Please choose an unmarked square (square with a number).'
  end

  nil
end

def available_moves(board_state)
  board_state.map { |columns| columns.select { |column| move_value?(column) } }.flatten
end

def board_mark!(mark, move_number, board_state)
  row_index, column_index = move_number_to_indices(move_number, board_state)
  board_state[row_index][column_index] = mark
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
