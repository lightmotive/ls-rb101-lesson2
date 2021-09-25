# frozen_string_literal: true

require_relative 'board'
require_relative '../../../ruby-common/prompt'

def player_move_to_coordinates(move)
  row, column = move.split(',').map(&:to_i)
  { row: row, column: column }
end

def player_move!(mark, board_state)
  move_coordinates = prompt_until_valid(
    "What's your move? Specify row,column, e.g. '1,3'",
    get_input: -> { gets.strip },
    convert_input: ->(input) { player_move_to_coordinates(input) },
    validate: ->(coordinates) { validate_move_coordinates(coordinates, board_state) }
  )

  board_mark!(mark, move_coordinates, board_state)
end

def computer_move!(mark, board_state)
  coordinates = available_move_coordinates(board_state).sample
  # TODO: Add computer play intelligence
  board_mark!(mark, coordinates, board_state)
  puts "Computer moved: #{coordinates[:row]},#{coordinates[:column]}"
end
