# frozen_string_literal: true

require_relative 'board_state'

# TODO: Improve computer logic to play best strategy:
# - Strategy: https://en.wikipedia.org/wiki/Tic-tac-toe#:~:text=cat's%20game%22%5B15%5D)-,strategy
# - Minimax algorithm: https://www.youtube.com/watch?v=trKjYdBASyQ

def move_to_win(with_mark, board_state)
  player_completion_square_numbers = board_squares_that_complete_line(with_mark, board_state)
  player_completion_square_numbers.first
end

def move_defense(against_mark, board_state)
  opponent_completion_square_numbers = board_squares_that_complete_line(against_mark, board_state)
  opponent_completion_square_numbers.sample
end

def computer_move_select(mark, opponent_mark, board_state)
  complete_line_square_number = move_to_win(mark, board_state)
  return complete_line_square_number unless complete_line_square_number.nil?

  defend_square_number = move_defense(opponent_mark, board_state)
  return defend_square_number unless defend_square_number.nil?

  available_spaces(board_state).sample
end
