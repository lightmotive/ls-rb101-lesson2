# frozen_string_literal: true

require_relative 'board_state'
require_relative 'gameplay_score'
require_relative 'game_state'
require_relative 'computer_logic'

def redraw(board_state, players)
  board_display(board_state, include_move_values: true)
  players_display(players)
  puts
end

def play!(board_state, players, game_state, round_state)
  players.each do |player|
    if player[:is_computer] then computer_move!(player[:mark], opponent(player, players)[:mark], board_state)
    else player_move!(player, board_state)
    end

    redraw(board_state, players)
    update_game_state!(board_state, players, game_state, round_state)
    game_state_display(board_state, players, game_state)

    break if end_game?(game_state)
  end
end

def board_size_prompt
  puts 'Board Size (3-9)? '
  gets.strip.to_i
end

def start_game!(board_state, players, round_state)
  redraw(board_state, players)

  game_state = game_state_create
  loop do
    play!(board_state, players, game_state, round_state)
    break round_score_display(players, round_state) if end_game?(game_state)
  end
end

def start_round!(players)
  size = board_size_prompt
  round_state = round_state_create(players, round_win_score_prompt)

  loop do
    board_state = board_state_create(size: size)
    start_game!(board_state, players, round_state)
    break if end_round?(players, round_state)

    players.shuffle!    # Randomize starting player between games without changing mark.
  end
end
