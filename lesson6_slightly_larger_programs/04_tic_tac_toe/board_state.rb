# frozen_string_literal: true

require_relative '../../../ruby-common/validation_error'

def board_state_create(size: 3)
  board = {}

  (1..size**2).each do |space_number|
    board[space_number] = { mark: nil }
  end

  board
end

def space_available?(mark)
  mark.nil?
end

def available_spaces(board_state)
  board_state.select { |_, data| space_available?(data[:mark]) }.keys
end

def board_full?(board_state)
  available_spaces(board_state).empty?
end

def board_mark!(mark, space_number, board_state)
  board_state[space_number][:mark] = mark
end

# Determine board square side length (squares per side)
def board_size(board_state)
  Math.sqrt(board_state.size).to_i
end

def board_rows(board_state)
  size = board_size(board_state)
  keys = board_state.keys

  size.times.map do
    size.times.map do
      key = keys.shift
      { space_number: key }.merge(board_state[key])
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

def board_middle_square_sets(sets, board_state)
  # To get middle(s): (if board size is odd, get at index [size / 2]; if even, get at index [size / 2 - 1] and [size / 2])
  board_size = board_size(board_state)

  if board_size.odd?
    [] << sets[board_size / 2]
  else
    first_middle = sets[board_size / 2 - 1]
    last_middle = sets[board_size / 2]
    [first_middle, last_middle]
  end
end

def board_center_squares(board_state, empty_only: false)
  middle_rows = board_middle_square_sets(board_rows(board_state), board_state)
  middle_columns = board_middle_square_sets(board_columns(board_state), board_state)

  middle_squares = middle_rows.flatten.intersection(middle_columns.flatten)

  empty_only ? middle_squares.select { |square| space_available?(square[:mark]) } : middle_squares
end
