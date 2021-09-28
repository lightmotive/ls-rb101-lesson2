# frozen_string_literal: true

require_relative 'board_state'
require_relative 'board_display'

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
