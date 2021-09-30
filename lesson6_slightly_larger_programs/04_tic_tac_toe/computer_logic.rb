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

  available_spaces(board_state).sample
end
