# frozen_string_literal: true

require_relative 'board'

def computer_move!(mark, board_state)
  coordinates = available_move_coordinates(board_state).sample
  # TODO: Add computer play intelligence
  board_mark!(mark, coordinates, board_state)
  puts "Computer moved: #{coordinates[:row]},#{coordinates[:column]}"
end
