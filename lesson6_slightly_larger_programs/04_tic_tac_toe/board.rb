# frozen_string_literal: true

SQUARE_WIDTH_PADDING = 2
SQUARE_VERTICAL_PADDING = 1

def board_state_empty(size: 3)
  Array.new(size) { Array.new(size, nil) }
end

def board_row_padding(column_count)
  column_count.times.map { ' ' * (SQUARE_WIDTH_PADDING * 2 + 1) }.join('|')
end

def board_row_markers(columns)
  columns.map do |marker|
    "#{' ' * SQUARE_WIDTH_PADDING}#{marker.nil? ? ' ' : marker}#{' ' * SQUARE_WIDTH_PADDING}"
  end.join('|')
end

def board_row_string(columns)
  "#{SQUARE_VERTICAL_PADDING.times.map { board_row_padding(columns.size) }.join("\n")}\n" \
  "#{board_row_markers(columns)}\n" \
  "#{SQUARE_VERTICAL_PADDING.times.map { board_row_padding(columns.size) }.join("\n")}"
end

def board_row_divider(column_count)
  column_count.times.map { '-' * (SQUARE_WIDTH_PADDING * 2 + 1) }.join('+')
end

def board_display(board_state)
  row_strings = board_state.map do |columns|
    "#{board_row_string(columns)}\n"
  end

  puts row_strings.join("#{board_row_divider(board_state[0].size)}\n")
end
