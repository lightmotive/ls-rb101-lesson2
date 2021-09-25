# frozen_string_literal: true

# Flowchart: https://app.terrastruct.com/diagrams/2101848647

require_relative 'board'
require_relative 'player'
require_relative 'computer_player'
require_relative 'board_evaluation'

def display_winner(winning_mark, board_state, players)
  board_display(board_state)
  puts "#{players.select { |player| player[:mark] == winning_mark }.first[:name]} won!"
end

# p display_winner("X", [[nil, nil, nil],[nil, nil, nil], [nil, nil, nil]], [{}, {}]

def end_game_winner?(board_state, players)
  winning_mark = winning_mark(board_state)
  unless winning_mark.nil?
    display_winner(winning_mark, board_state, players)
    return true
  end

  false
end

def display_tie(board_state)
  board_display(board_state)
  puts 'Tie!'
end

def end_game_tie?(board_state)
  if board_full?(board_state)
    display_tie(board_state)
    return true
  end

  false
end

def end_game?(board_state, players)
  return true if end_game_winner?(board_state, players)
  return true if end_game_tie?(board_state)

  false
end

# Randomize first player and assign mark (X/O)
def initialize_players(names)
  names = names.shuffle   # Randomize first player

  names.map.with_index do |name, idx|
    { name: name, mark: idx.zero? ? 'X' : 'O', is_computer: name == 'Computer' }
  end
end

def players_display(players)
  players.each do |player|
    puts "#{player[:mark]}: #{player[:name]}"
  end
end

def redraw(board_state, players)
  board_display(board_state)
  players_display(players)
  puts
end

def play_and_end_game?(board_state, players)
  end_game = false

  players.each do |player|
    if player[:is_computer] then computer_move!(player[:mark], board_state)
    else player_move!(player[:mark], board_state)
    end

    redraw(board_state, players)

    end_game = end_game?(board_state, players)
    break if end_game
  end

  end_game
end

def start_game(players)
  board_state = board_state_empty
  redraw(board_state, players)

  loop do
    end_game = play_and_end_game?(board_state, players)
    break if end_game
  end
end

def play
  puts 'Welcome to Noughts and Crosses!'
  puts "What's your name?"
  player_name = gets.chomp

  loop do
    start_game(initialize_players([player_name, 'Computer']))

    print "\nPlay again? (Y/N) "
    break puts 'Cheerio!' unless gets.strip.downcase.chars.first == 'y'
  end
end

play
