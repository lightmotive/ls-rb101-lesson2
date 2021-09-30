# frozen_string_literal: true

def computer_move_select(mark, opponent_mark, board_state)
  available_moves(board_state).sample
end
