# frozen_string_literal: true

require_relative 'board_state'

# TODO: Improve computer logic to play best strategy:
# - Strategy: https://en.wikipedia.org/wiki/Tic-tac-toe#:~:text=cat's%20game%22%5B15%5D)-,strategy
# - Minimax algorithm: https://www.youtube.com/watch?v=trKjYdBASyQ

def move_to_win(with_mark, board_state)
  player_square_numbers_to_win = square_numbers_to_win(with_mark, board_state)
  player_square_numbers_to_win.first
end

def move_to_defend(against_mark, board_state)
  opponent_square_numbers_to_win = square_numbers_to_win(against_mark, board_state)
  opponent_square_numbers_to_win.sample
end

def computer_move_select(mark, opponent_mark, board_state)
  square_number_to_win = move_to_win(mark, board_state)
  return square_number_to_win unless square_number_to_win.nil?

  square_number_to_defend = move_to_defend(opponent_mark, board_state)
  return square_number_to_defend unless square_number_to_defend.nil?

  available_spaces(board_state).sample
end
