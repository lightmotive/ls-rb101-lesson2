# frozen_string_literal: true

require_relative 'board_state'
require_relative '../../../ruby-common/prompt'

COMPUTER_NAME = 'Computer'

def player_id(player)
  player[:name].to_sym
end

# Randomize first player and assign mark (X/O)
def initialize_players(names)
  names = names.shuffle # Randomize first player

  names.map.with_index do |name, idx|
    { name: name, mark: idx.zero? ? 'X' : 'O', is_computer: name == COMPUTER_NAME }
  end
end

def prompt_multiplayer?
  puts 'Multiplayer? (Y/N)'
  gets.strip.downcase.chars.first == 'y'
end

def identify_players_single
  puts "What's your name?"
  [].push(gets.strip, COMPUTER_NAME)
end

def identify_players_multiple(player_count)
  players = []

  player_count.times do |idx|
    puts "What's Player #{idx + 1}'s name?"
    players << gets.strip
  end

  players
end

def identify_players
  player_count = prompt_multiplayer? ? 2 : 1

  return identify_players_single if player_count == 1

  identify_players_multiple(player_count)
end

def welcome_players
  puts 'Welcome to Noughts and Crosses!'

  initialize_players(identify_players)
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
  puts "#{COMPUTER_NAME} marked #{move_number}"
end
