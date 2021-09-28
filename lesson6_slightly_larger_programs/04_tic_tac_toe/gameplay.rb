# frozen_string_literal: true

require_relative 'board_state'
require_relative 'gameplay_score'
require_relative 'gameplay_win'

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

def redraw(board_state, players)
  board_display(board_state, include_move_values: true)
  players_display(players)
  puts
end

def play_and_end_game?(board_state, players)
  end_game = false

  players.each do |player|
    if player[:is_computer] then computer_move!(player[:mark], board_state)
    else player_move!(player, board_state)
    end

    redraw(board_state, players)

    end_game = end_game?(board_state, players)
    break if end_game
  end

  end_game
end

def board_size_prompt
  puts 'Board Size (3-9)? '
  gets.strip.to_i
end

def start_game!(players, board_state)
  redraw(board_state, players)

  loop do
    end_game = play_and_end_game?(board_state, players)
    break round_score_display(players) if end_game
  end

  nil
end

def start_round!(players)
  size = board_size_prompt
  round_win_score = round_win_score_prompt

  loop do
    board_state = board_state_create(size: size)
    start_game!(players, board_state)
    break if end_round?(players, round_win_score)
  end
end
