# frozen_string_literal: true

require_relative 'board'

def winning_line_mark(lines)
  lines.each do |line|
    unique_marks = line.uniq
    return unique_marks.first if unique_marks.size == 1
  end

  nil
end

def winning_mark(board_state)
  winning_mark = winning_line_mark(board_state) # Check rows
  return winning_mark unless winning_mark.nil?

  winning_mark = winning_line_mark(board_columns(board_state))
  return winning_mark unless winning_mark.nil?

  winning_mark = winning_line_mark(board_diagonals(board_state))
  return winning_mark unless winning_mark.nil?

  nil
end

def board_full?(board_state)
  available_move_coordinates(board_state).empty?
end
