# frozen_string_literal: true

require_relative '../../../ruby-common/validation_error'

def board_state_create(size: 3)
  board = {}

  (1..size**2).each do |space_number|
    board[space_number] = { mark: '' }
  end

  board
end

def space_available?(mark)
  mark.empty?
end

# Ensure move coordinates are valid (within bounds, board square free)
def validate_move(move_number, board_state)
  keys = board_state.keys
  unless keys.include?(move_number)
    raise ValidationError, "Your move number should be between #{keys.first} and #{keys.last}."
  end

  unless available_moves(board_state).include?(move_number)
    raise ValidationError, 'Please choose an unmarked square (square with a number).'
  end

  nil
end

def available_moves(board_state)
  board_state.select { |_, data| space_available?(data[:mark]) }.keys
end

def board_full?(board_state)
  available_moves(board_state).empty?
end

def board_mark!(mark, move_number, board_state)
  board_state[move_number][:mark] = mark
end

# Determine board square side length
def board_size(board_state)
  Math.sqrt(board_state.size).to_i
end

def board_rows(board_state)
  size = board_size(board_state)
  keys = board_state.keys
  size.times.map do
    size.times.map do
      key = keys.shift
      { space: key }.merge(board_state[key])
    end
  end
end

def board_columns(board_state)
  board_rows = board_rows(board_state)
  board_rows[0].zip(*board_rows[1..-1])
end

def board_diagonals(board_state)
  diagonal_by_index = ->(row, idx) { row[idx] }
  board_rows = board_rows(board_state)
  top_left_diagonal = board_rows.map.with_index(&diagonal_by_index)
  bottom_left_diagonal = board_rows.reverse.map.with_index(&diagonal_by_index)

  [top_left_diagonal, bottom_left_diagonal]
end
