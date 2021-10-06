# frozen_string_literal: true

require_relative 'board_state'
require_relative '../../../ruby-common/prompt'
require_relative '../../../ruby-common/messages'

COMPUTER_NAME = 'Computer'

def player_id(player)
  player[:name].to_sym
end

# Randomize first player and assign mark (X/O)
def initialize_players(names)
  names = names.shuffle # Randomize first player

  names.map.with_index do |name, idx|
    { name: name, mark: idx.zero? ? 'X' : 'O',
      is_computer: name == COMPUTER_NAME }
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
  puts
  messages_bordered_display('Welcome to Noughts and Crosses!', 'xo')
  puts

  initialize_players(identify_players)
end

def players_display(players, game_state: nil)
  last_mark = game_state[:mark_history].last unless game_state.nil?

  players.each do |player|
    player_display = "#{player[:mark]}: #{player[:name]}"

    last_mark_display = ""
    if !last_mark.nil? && last_mark[:mark] == player[:mark]
      last_mark_display = " | just marked #{last_mark[:space_number]}"
    end

    puts "#{player_display}#{last_mark_display}"
  end
end

# Ensure play is valid: within bounds, board space free
def validate_play(space_number, board_state)
  keys = board_state.keys

  unless keys.include?(space_number)
    raise ValidationError,
          "Your space number should be between #{keys.first} and #{keys.last}."
  end

  unless available_spaces(board_state).include?(space_number)
    raise ValidationError,
          'Please choose an unmarked space.'
  end

  nil
end

# Get a player's opponent (player). Assumes only 2 players/marks.
def opponent(player, players)
  players.reject { |p| p[:mark] == player[:mark] }.first
end

def player_play!(player, board_state, game_state)
  space_number = prompt_until_valid(
    "#{player[:name]}, enter the number to mark (#{player[:mark]}):",
    get_input: -> { gets.strip },
    convert_input: ->(input) { input.to_i },
    validate: ->(number) { validate_play(number, board_state) }
  )

  board_mark!(player[:mark], space_number, board_state)
  player_played!(mark, space_number, game_state)
end

def computer_play!(mark, opponent_mark, board_state, game_state)
  space_number = computer_space_number_select(mark, opponent_mark, board_state)
  board_mark!(mark, space_number, board_state)
  player_played!(mark, space_number, game_state)
end
