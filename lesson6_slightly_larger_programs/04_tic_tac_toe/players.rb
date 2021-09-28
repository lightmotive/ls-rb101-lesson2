# frozen_string_literal: true

require_relative 'board_state'
require_relative '../../../ruby-common/prompt'

def player_move!(player, board_state)
  move_number = prompt_until_valid(
    "#{player[:name]}, enter the number to mark (#{player[:mark]}):",
    get_input: -> { gets.strip },
    convert_input: ->(input) { input.to_i },
    validate: ->(number) { validate_move(number, board_state) }
  )

  board_mark!(player[:mark], move_number, board_state)
end

def computer_move!(mark, board_state)
  move_number = available_moves(board_state).sample
  # TODO: Add computer play intelligence
  board_mark!(mark, move_number, board_state)
  puts "Computer marked #{move_number}"
end
