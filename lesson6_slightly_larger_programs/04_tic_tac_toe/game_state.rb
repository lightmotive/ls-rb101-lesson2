# frozen_string_literal: true

require_relative 'board_state'
require_relative 'gameplay_win'
require_relative '../../../ruby-common/messages'

def game_state_create
  { win: false, tie: false, winner: nil, mark_history: [] }
end

def update_game_state!(board_state, players, game_state, round_state)
  winning_mark = winning_mark(board_state)
  unless space_available?(winning_mark)
    game_state[:win] = true
    player_won!(winning_mark, players, game_state, round_state)
  end

  game_state[:tie] = !game_state[:win] && board_full?(board_state)
end

def player_played!(mark, space_number, game_state)
  game_state[:mark_history].push({ space_number: space_number, mark: mark })
end

def end_game?(game_state)
  game_state[:win] || game_state[:tie]
end

def game_state_display(board_state, players, game_state)
  display_win(board_state, players, game_state) if game_state[:win]
  messages_bordered_display('Tie!', '-') if game_state[:tie]
end
