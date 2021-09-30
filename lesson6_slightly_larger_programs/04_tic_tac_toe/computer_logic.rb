# frozen_string_literal: true

require_relative 'board_state'

# TODO: Improve computer logic to play best strategy:
# - Strategy: https://en.wikipedia.org/wiki/Tic-tac-toe#:~:text=cat's%20game%22%5B15%5D)-,strategy
# - Minimax algorithm: https://www.youtube.com/watch?v=trKjYdBASyQ

def space_number_to_win(with_mark, board_state)
  space_numbers_to_win(with_mark, board_state).first
end

def space_numbers_to_defend(against_mark, board_state)
  space_numbers_to_win(against_mark, board_state)
end

def computer_space_number_select(mark, opponent_mark, board_state)
  space_number_to_win = space_number_to_win(mark, board_state)
  return space_number_to_win unless space_number_to_win.nil?

  space_number_to_defend = space_numbers_to_defend(opponent_mark, board_state).sample
  return space_number_to_defend unless space_number_to_defend.nil?

  middle_spaces = board_center_squares(board_state)
  empty_middle_spaces = middle_spaces.select { |space| space_available?(space[:mark]) }
  return empty_middle_spaces.sample[:space_number] unless middle_spaces.size > 1 || empty_middle_spaces.empty?

  available_spaces(board_state).sample
end
