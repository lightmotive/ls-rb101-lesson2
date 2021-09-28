# frozen_string_literal: true

require_relative 'board_state'
require_relative 'board_display'

def display_tie(board_state)
  board_display(board_state)
  puts 'Tie!'
end
