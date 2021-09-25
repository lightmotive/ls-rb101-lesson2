# frozen_string_literal: true

# Flowchart: https://app.terrastruct.com/diagrams/2101848647

require_relative 'board'
require_relative 'player'
require_relative 'computer_player'
require_relative 'board_evaluation'

def display_winner(winner, board_state)
  board_display(board_state)
  puts "#{winner} won!"
end

def end_game_winner?(board_state)
  winner = winner(board_state)
  unless winner.nil?
    display_winner(winner, board_state)
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

def end_game?(board_state)
  return true if end_game_winner?(board_state)
  return true if end_game_tie?(board_state)

  false
end

def start_game
  # TODO: Add randomized first player logic

  board_state = board_state_empty

  loop do
    board_display(board_state)

    player_move!(board_state)
    break if end_game?(board_state)

    computer_move!(board_state)
    break if end_game?(board_state)
  end
end

start_game

# TODO: add "Play again?" loop
