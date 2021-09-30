# frozen_string_literal: true

COMPUTER_NAME = 'Computer'

def computer_move!(mark, board_state)
  move_number = available_moves(board_state).sample
  # TODO: Add computer play intelligence
  board_mark!(mark, move_number, board_state)
  puts "#{COMPUTER_NAME} marked #{move_number}"
end
