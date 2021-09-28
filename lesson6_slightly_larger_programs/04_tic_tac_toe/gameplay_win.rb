# frozen_string_literal: true

require_relative 'board_display'

def winning_line_mark(spaces_rows)
  spaces_rows.each do |spaces|
    marks = spaces.map { |space| space[:mark] }
    unique_marks = marks.uniq
    return unique_marks.first if unique_marks.size == 1 && !space_available?(unique_marks.first)
  end

  nil
end

def winning_mark(board_state)
  winning_mark = winning_line_mark(board_rows(board_state)) # Check rows
  return winning_mark unless winning_mark.nil?

  winning_mark = winning_line_mark(board_columns(board_state))
  return winning_mark unless winning_mark.nil?

  winning_mark = winning_line_mark(board_diagonals(board_state))
  return winning_mark unless winning_mark.nil?

  nil
end

def player_won(winning_mark, board_state, players)
  board_display(board_state)

  winner = players.select { |player| player[:mark] == winning_mark }.first
  no_computer_players = players.count { |player| player[:is_computer] }.zero?

  winner[:score] += 1

  if no_computer_players || winner[:is_computer] then puts "#{winner[:name]} won the game!"
  else puts "You won the game! (#{winner[:mark]})"
  end
end

def end_game_winner?(board_state, players)
  winning_mark = winning_mark(board_state)
  unless winning_mark.nil?
    player_won(winning_mark, board_state, players)
    return true
  end

  false
end
