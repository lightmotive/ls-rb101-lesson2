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
