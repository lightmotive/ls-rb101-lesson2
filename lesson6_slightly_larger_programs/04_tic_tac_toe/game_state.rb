# frozen_string_literal: true

require_relative 'gameplay_win'
require_relative 'gameplay_tie'

def game_state_create
  { win: false, tie: false, winner: nil }
end

def update_game_state!(board_state, players, game_state)
  winning_mark = winning_mark(board_state)
  unless winning_mark.nil?
    game_state[:win] = true
    player_won!(winning_mark, players, game_state)
  end

  game_state[:tie] = !game_state[:win] && board_full?(board_state)
end

def end_game?(game_state)
  game_state[:win] || game_state[:tie]
end

def game_state_display(board_state, players, game_state)
  display_win(board_state, players, game_state) if game_state[:win]
  display_tie(board_state) if game_state[:tie]
end
