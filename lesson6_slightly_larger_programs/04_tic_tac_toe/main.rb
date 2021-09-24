# frozen_string_literal: true

# Flowchart: https://app.terrastruct.com/diagrams/2101848647

require_relative 'board'
require_relative 'player'
require_relative 'computer_player'

board_state = board_state_empty
board_display(board_state)

loop do
  player_coordinates = player_move(board_state)
  board_mark!('U', player_coordinates, board_state)

  computer_move!(board_state)

  board_display(board_state)
end
