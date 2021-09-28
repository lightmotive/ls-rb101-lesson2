# frozen_string_literal: true

require_relative 'board_state'
require_relative '../../../ruby-common/prompt'

# Randomize first player and assign mark (X/O)
def initialize_players(names)
  names = names.shuffle # Randomize first player

  names.map.with_index do |name, idx|
    { name: name, mark: idx.zero? ? 'X' : 'O', is_computer: name == 'Computer' }
  end
end

def welcome_players
  puts 'Welcome to Noughts and Crosses!'
  puts "What's your name?"
  player_name = gets.chomp

  board_display(board_state_create, include_move_values: true)

  initialize_players([player_name, 'Computer'])
end

def players_display(players)
  players.each do |player|
    puts "#{player[:mark]}: #{player[:name]}"
  end
end

# Ensure move is valid: within bounds, board square free
def validate_move(move_number, board_state)
  keys = board_state.keys
  unless keys.include?(move_number)
    raise ValidationError, "Your move number should be between #{keys.first} and #{keys.last}."
  end

  unless available_moves(board_state).include?(move_number)
    raise ValidationError, 'Please choose an unmarked square (square with a number).'
  end

  nil
end

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
