# frozen_string_literal: true

require_relative 'board_state'
require_relative 'board_display'
require_relative 'players'
require_relative '../../../ruby-common/messages'

def winning_line_mark(spaces_sets)
  spaces_sets.each do |spaces|
    marks = spaces.map { |space| space[:mark] }
    unique_marks = marks.uniq
    if unique_marks.size == 1 && !space_available?(unique_marks.first)
      return unique_marks.first
    end
  end

  nil
end

def winning_mark(board_state)
  winning_mark = winning_line_mark(board_rows(board_state)) # Check rows
  return winning_mark unless space_available?(winning_mark)

  winning_mark = winning_line_mark(board_columns(board_state))
  return winning_mark unless space_available?(winning_mark)

  winning_mark = winning_line_mark(board_diagonals(board_state))
  return winning_mark unless space_available?(winning_mark)

  nil
end

def display_win(_board_state, players, game_state)
  no_computer_players = players.count { |player| player[:is_computer] }.zero?
  winner = game_state[:winner]

  winner_message = if no_computer_players || winner[:is_computer]
                     "#{winner[:name]} won the game!"
                   else 'You won the game!'
                   end

  messages_bordered_display("#{winner_message} (#{winner[:mark]})", '-')
end

def player_won!(winning_mark, players, game_state, round_state)
  winner = players.select { |player| player[:mark] == winning_mark }.first
  round_player_score_increment(winner, round_state)
  game_state[:winner] = winner
end

# Get space numbers that would complete a line for a specific mark
# (immediate threat/win).
def _private_space_numbers_to_win(mark, spaces_sets, board_state)
  size = board_size(board_state)

  completion_sets = spaces_sets.select do |spaces|
    spaces.count { |space| space[:mark] == mark } == size - 1
  end

  empty_completion_spaces = completion_sets.flatten.select do |space|
    space_available?(space[:mark])
  end

  empty_completion_spaces.map { |space| space[:space_number] }
end

def space_numbers_to_win(for_mark, board_state)
  rows = _private_space_numbers_to_win(
    for_mark, board_rows(board_state), board_state
  )
  columns = _private_space_numbers_to_win(
    for_mark, board_columns(board_state), board_state
  )
  diagonals = _private_space_numbers_to_win(
    for_mark, board_diagonals(board_state), board_state
  )

  rows.concat(columns, diagonals)
end
