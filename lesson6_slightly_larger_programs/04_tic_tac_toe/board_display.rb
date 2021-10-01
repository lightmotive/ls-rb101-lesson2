# frozen_string_literal: true

require_relative 'board_state'

SPACE_WIDTH_PADDING = 1
SPACE_VERTICAL_PADDING = 0

def board_row_padding(column_count)
  Array.new(column_count, ' ' * ((SPACE_WIDTH_PADDING * 2) + 1)).join('|')
end

def board_mark_with_padding(space, include_space_numbers)
  mark = space[:mark]
  padding = ' ' * SPACE_WIDTH_PADDING

  if space_available?(mark)
    mark = space[:space_number].to_s.rjust(3, '* ')
    padding.chop! if include_space_numbers
    mark = ' ' unless include_space_numbers
  end

  "#{padding}#{mark}#{padding}"
end

def board_row_marks(spaces, include_space_numbers: false)
  spaces.map do |space|
    board_mark_with_padding(space, include_space_numbers)
  end.join('|')
end

def board_row_string(spaces, include_space_numbers: false)
  row_string = board_row_marks(
    spaces, include_space_numbers: include_space_numbers
  )

  return row_string unless SPACE_VERTICAL_PADDING.positive?

  vertical_padding = Array.new(
    SPACE_VERTICAL_PADDING,
    board_row_padding(spaces.size)
  ).join("\n")

  "#{vertical_padding}\n#{row_string}\n#{vertical_padding}"
end

def board_row_divider(column_count)
  Array.new(column_count, '-' * ((SPACE_WIDTH_PADDING * 2) + 1)).join('+')
end

def board_display(board_state, include_space_numbers: false)
  rows = board_rows(board_state)

  row_strings = rows.map do |spaces|
    "#{board_row_string(
      spaces,
      include_space_numbers: include_space_numbers
    )}\n"
  end

  puts row_strings.join("#{board_row_divider(rows[0].size)}\n").to_s
end
