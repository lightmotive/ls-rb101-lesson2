# frozen_string_literal: true

require_relative 'board_state'

SQUARE_WIDTH_PADDING = 1
SQUARE_VERTICAL_PADDING = 0

def board_row_padding(column_count)
  Array.new(column_count, ' ' * (SQUARE_WIDTH_PADDING * 2 + 1)).join('|')
end

def board_mark_with_padding(space, include_move_values)
  mark = space[:mark]
  padding = ' ' * SQUARE_WIDTH_PADDING

  if space_available?(mark)
    mark = space[:space].to_s.rjust(3, '* ')
    padding.chop! if include_move_values
    mark = ' ' unless include_move_values
  end

  "#{padding}#{mark}#{padding}"
end

def board_row_marks(spaces, include_move_values: false)
  spaces.map do |space|
    board_mark_with_padding(space, include_move_values)
  end.join('|')
end

def board_row_string(spaces, include_move_values: false)
  row_string = board_row_marks(spaces, include_move_values: include_move_values)

  if SQUARE_VERTICAL_PADDING.positive?
    vertical_padding = Array.new(SQUARE_VERTICAL_PADDING, board_row_padding(spaces.size)).join("\n")
    row_string =
      "#{vertical_padding}\n" \
      "#{row_string}\n" \
      "#{vertical_padding}"
  end

  row_string
end

def board_row_divider(column_count)
  Array.new(column_count, '-' * (SQUARE_WIDTH_PADDING * 2 + 1)).join('+')
end

def board_display(board_state, include_move_values: false)
  rows = board_rows(board_state)
  row_strings = rows.map do |spaces|
    "#{board_row_string(spaces, include_move_values: include_move_values)}\n"
  end

  puts "\n#{row_strings.join("#{board_row_divider(rows[0].size)}\n")}\n"
end
