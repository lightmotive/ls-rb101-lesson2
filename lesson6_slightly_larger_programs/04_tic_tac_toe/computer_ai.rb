# frozen_string_literal: true

require_relative 'board_state'

def move_defense(against_mark, board_state)
  opponent_completion_square_numbers = board_squares_that_complete_line(against_mark, board_state)
  opponent_completion_square_numbers.sample
end

def computer_move_select(mark, opponent_mark, board_state)
  defend_square_number = move_defense(opponent_mark, board_state)
  return defend_square_number unless defend_square_number.nil?

  available_spaces(board_state).sample
end
