# frozen_string_literal: true

require_relative 'board'

def computer_move!(board_state)
  computer_player_coordinates = available_move_coordinates(board_state).sample
  # TODO: Add computer play intelligence
  board_mark!('C', computer_player_coordinates, board_state)
  puts "Computer moved: #{computer_player_coordinates[:row]},#{computer_player_coordinates[:column]}"
end
