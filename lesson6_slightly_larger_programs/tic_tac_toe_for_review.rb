# frozen_string_literal: true

# This contains all code from 04_tic_tac_toe and other files required from the
# lightmotive/ruby-common repository.

# *****************************
# /ruby-common/stdout_format.rb
# *****************************
# Add color and formatting methods to string.
# Source: https://stackoverflow.com/a/16363159/2033465
class String
  def black
    "\e[30m#{self}\e[0m"
  end

  def red
    "\e[31m#{self}\e[0m"
  end

  def green
    "\e[32m#{self}\e[0m"
  end

  def brown
    "\e[33m#{self}\e[0m"
  end

  def blue
    "\e[34m#{self}\e[0m"
  end

  def magenta
    "\e[35m#{self}\e[0m"
  end

  def cyan
    "\e[36m#{self}\e[0m"
  end

  def gray
    "\e[37m#{self}\e[0m"
  end

  def bg_black
    "\e[40m#{self}\e[0m"
  end

  def bg_red
    "\e[41m#{self}\e[0m"
  end

  def bg_green
    "\e[42m#{self}\e[0m"
  end

  def bg_brown
    "\e[43m#{self}\e[0m"
  end

  def bg_blue
    "\e[44m#{self}\e[0m"
  end

  def bg_magenta
    "\e[45m#{self}\e[0m"
  end

  def bg_cyan
    "\e[46m#{self}\e[0m"
  end

  def bg_gray
    "\e[47m#{self}\e[0m"
  end

  def bold
    "\e[1m#{self}\e[22m"
  end

  def italic
    "\e[3m#{self}\e[23m"
  end

  def underline
    "\e[4m#{self}\e[24m"
  end

  def blink
    "\e[5m#{self}\e[25m"
  end

  def reverse_color
    "\e[7m#{self}\e[27m"
  end
end

# ********************************
# /ruby_common/validation_error.rb
# ********************************
class ValidationError < StandardError
end

# **********************
# /ruby-common/prompt.rb
# **********************
# NOTE: prompt_until_valid should be a class. Will learn Ruby OOP and refactor later.

# Returns the value from options[:convert_input]
# options[:validate]: if input is invalid, raise ValidationError with custom message or StandardError without message.
#   Raise ValidationError with helpful explanation (message) to prefix original.
def prompt_until_valid_apply_default_options!(options)
  options[:prompt_with_format] ||= ->(msg) { puts "-> #{msg}" }
  options[:input_invalid_default_message] ||= 'Invalid input.'
  options[:get_input] ||= -> { gets.chomp }
  options[:convert_input] ||= ->(input) { input }
  options[:validate] ||= ->(_input_converted) { nil }
end

def _prompt_until_valid_loop(message, options)
  loop do
    value = options[:convert_input].call(options[:get_input].call)
    options[:validate].call(value)
    break value
  rescue ValidationError => e
    options[:prompt_with_format].call("#{e.message} #{message}")
  rescue StandardError
    options[:prompt_with_format].call("#{options[:input_invalid_default_message]} #{message}")
  end
end

def prompt_until_valid(
  message,
  options = {
    prompt_with_format: nil,
    input_invalid_default_message: nil,
    get_input: nil,
    convert_input: nil,
    validate: nil
  }
)
  prompt_until_valid_apply_default_options!(options)

  options[:prompt_with_format].call(message)
  _prompt_until_valid_loop(message, options)
end

# ***********
# messages.rb
# ***********
def messages_bordered_display(messages, border_char, header: '')
  messages = [messages] unless messages.is_a?(Array)

  max_length = messages.max_by(&:length).length
  max_length = header.length + 4 if header.length >= max_length

  border = border_char.ljust(max_length, border_char)

  puts(header.empty? ? border : header.center(max_length, border_char))
  messages.each { |message| puts message }
  puts border
end

# **************
# board_state.rb
# **************
def board_state_create(size: 3)
  size = 3 if size < 3
  size = 9 if size > 9

  board = {}

  (1..size**2).each do |space_number|
    board[space_number] = { mark: nil }
  end

  board
end

def space_available?(mark)
  mark.nil?
end

def available_spaces(board_state)
  board_state.select { |_, data| space_available?(data[:mark]) }.keys
end

def board_full?(board_state)
  available_spaces(board_state).empty?
end

def board_mark!(mark, space_number, board_state)
  board_state[space_number][:mark] = mark
end

# Determine board space side length (spaces per side)
def board_size(board_state)
  Math.sqrt(board_state.size).to_i
end

def board_rows(board_state)
  size = board_size(board_state)
  keys = board_state.keys

  size.times.map do
    size.times.map do
      key = keys.shift
      { space_number: key }.merge(board_state[key])
    end
  end
end

def board_columns(board_state)
  board_rows = board_rows(board_state)
  board_rows[0].zip(*board_rows[1..-1])
end

def board_diagonals(board_state)
  diagonal_by_index = ->(row, idx) { row[idx] }
  board_rows = board_rows(board_state)
  top_left_diagonal = board_rows.map.with_index(&diagonal_by_index)
  bottom_left_diagonal = board_rows.reverse.map.with_index(&diagonal_by_index)

  [top_left_diagonal, bottom_left_diagonal]
end

def board_center_space_sets(sets, board_state)
  board_size = board_size(board_state)

  if board_size.odd?
    [] << sets[board_size / 2]
  else
    first_middle = sets[(board_size / 2) - 1]
    last_middle = sets[board_size / 2]
    [first_middle, last_middle]
  end
end

def board_center_spaces(board_state, empty_only: false)
  middle_rows = board_center_space_sets(board_rows(board_state), board_state)
  middle_columns = board_center_space_sets(
    board_columns(board_state), board_state
  )

  center_spaces = middle_rows.flatten.intersection(middle_columns.flatten)

  return center_spaces.select { |space| space_available?(space[:mark]) } if empty_only

  center_spaces
end

# ****************
# board_display.rb
# ****************
SPACE_WIDTH_PADDING = 1
SPACE_VERTICAL_PADDING = 0
SPACE_WIDTH = (SPACE_WIDTH_PADDING * 2) + 1

def board_row_padding(column_count)
  Array.new(column_count, ' ' * SPACE_WIDTH).join('|')
end

def board_mark_space_number(space)
  space[:space_number].to_s.rjust(SPACE_WIDTH, ' ').italic.gray
end

def board_mark_with_padding(space, include_space_numbers)
  padding = ' ' * SPACE_WIDTH_PADDING

  mark = space[:mark]
  mark = mark.bold unless space_available?(mark)

  if space_available?(mark) && include_space_numbers
    mark = board_mark_space_number(space)
    padding.replace('')
  end

  mark = ' ' if space_available?(mark) && !include_space_numbers

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
  Array.new(column_count, '-' * SPACE_WIDTH).join('+')
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

# **********
# players.rb
# **********
COMPUTER_NAME = 'Computer'

def player_id(player)
  player[:name].to_sym
end

# Randomize first player and assign mark (X/O)
def initialize_players(names)
  names = names.shuffle # Randomize first player

  names.map.with_index do |name, idx|
    { name: name, mark: idx.zero? ? 'X' : 'O',
      is_computer: name == COMPUTER_NAME }
  end
end

def prompt_multiplayer?
  puts 'Multiplayer? (Y/N)'
  gets.strip.downcase.chars.first == 'y'
end

def identify_players_single
  puts "What's your name?"
  [].push(gets.strip, COMPUTER_NAME)
end

def identify_players_multiple(player_count)
  players = []

  player_count.times do |idx|
    puts "What's Player #{idx + 1}'s name?"
    players << gets.strip
  end

  players
end

def identify_players
  player_count = prompt_multiplayer? ? 2 : 1

  return identify_players_single if player_count == 1

  identify_players_multiple(player_count)
end

def welcome_players
  puts
  messages_bordered_display('Welcome to Noughts and Crosses!', 'xo')
  puts

  initialize_players(identify_players)
end

def players_display(players)
  players.each do |player|
    puts "#{player[:mark]}: #{player[:name]}"
  end
end

# Ensure play is valid: within bounds, board space free
def validate_play(space_number, board_state)
  keys = board_state.keys

  unless keys.include?(space_number)
    raise ValidationError,
          "Your space number should be between #{keys.first} and #{keys.last}."
  end

  unless available_spaces(board_state).include?(space_number)
    raise ValidationError,
          'Please choose an unmarked space.'
  end

  nil
end

# Get a player's opponent (player). Assumes only 2 players/marks.
def opponent(player, players)
  players.reject { |p| p[:mark] == player[:mark] }.first
end

def player_play!(player, board_state)
  space_number = prompt_until_valid(
    "#{player[:name]}, enter the number to mark (#{player[:mark]}):",
    get_input: -> { gets.strip },
    convert_input: ->(input) { input.to_i },
    validate: ->(number) { validate_play(number, board_state) }
  )

  board_mark!(player[:mark], space_number, board_state)
end

def computer_play!(mark, opponent_mark, board_state)
  space_number = computer_space_number_select(mark, opponent_mark, board_state)
  board_mark!(mark, space_number, board_state)
  puts "#{COMPUTER_NAME} marked #{space_number}"
end

# ***************
# gameplay_win.rb
# ***************
def winning_line_mark(spaces_sets)
  spaces_sets.each do |spaces|
    marks = spaces.map { |space| space[:mark] }
    unique_marks = marks.uniq
    return unique_marks.first if unique_marks.size == 1 && !space_available?(unique_marks.first)
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

# *****************
# gameplay_score.rb
# *****************
def round_state_create(players, win_score)
  round_state = { win_score: win_score, scores: {} }

  players.each do |player|
    round_state[:scores][player_id(player)] = 0
  end

  round_state
end

def round_player_score(player, round_state)
  round_state[:scores][player_id(player)]
end

def round_player_score_increment(player, round_state)
  round_state[:scores][player_id(player)] += 1
end

def round_win_score_prompt
  puts 'Games to win (default: 5)?'
  win_score = gets.chomp

  return 5 if win_score.empty?

  win_score.to_i
end

def round_winner(players, round_state)
  players.select do |player|
    round_player_score(player, round_state) == round_state[:win_score]
  end.first
end

def players_by_top_score(players, round_state)
  players_by_score =
    players.sort_by do |player|
      round_player_score(player, round_state)
    end

  players_by_score.reverse
end

def round_score_display(players, round_state)
  players_by_top_score = players_by_top_score(players, round_state)
  messages = players_by_top_score.map do |player|
    "#{player[:name]}: #{round_player_score(player, round_state)}"
  end

  puts
  messages_bordered_display(messages, '=', header: 'Round Scoreboard')
end

def round_score_final_display(winning_player)
  puts
  messages_bordered_display("#{winning_player[:name]} won the round!", '*')
end

def end_round?(players, round_state)
  round_winner = round_winner(players, round_state)

  if round_winner.nil?
    puts 'Press enter to continue the round...'
    gets
    false
  else
    round_score_final_display(round_winner)
    true
  end
end

# *************
# game_state.rb
# *************
def game_state_create
  { win: false, tie: false, winner: nil }
end

def update_game_state!(board_state, players, game_state, round_state)
  winning_mark = winning_mark(board_state)
  unless space_available?(winning_mark)
    game_state[:win] = true
    player_won!(winning_mark, players, game_state, round_state)
  end

  game_state[:tie] = !game_state[:win] && board_full?(board_state)
end

def end_game?(game_state)
  game_state[:win] || game_state[:tie]
end

def game_state_display(board_state, players, game_state)
  display_win(board_state, players, game_state) if game_state[:win]
  messages_bordered_display('Tie!', '-') if game_state[:tie]
end

# *****************
# computer_logic.rb
# *****************
# TODO: Improve computer logic to play best strategy, regardless of board size:
# - Strategy: https://en.wikipedia.org/wiki/Tic-tac-toe#:~:text=cat's%20game%22%5B15%5D)-,strategy
# - Minimax algorithm: https://www.youtube.com/watch?v=trKjYdBASyQ

def space_number_to_win(with_mark, board_state)
  space_numbers_to_win(with_mark, board_state).first
end

def space_numbers_to_defend(against_mark, board_state)
  space_numbers_to_win(against_mark, board_state)
end

def space_number_to_play(board_state)
  center_spaces = board_center_spaces(board_state)
  empty_center_spaces = board_center_spaces(board_state, empty_only: true)
  return nil if center_spaces.size > 1 || empty_center_spaces.empty?

  empty_center_spaces.sample[:space_number]
end

def computer_space_number_select(mark, opponent_mark, board_state)
  space_number_to_win = space_number_to_win(mark, board_state)
  return space_number_to_win unless space_number_to_win.nil?

  space_number_to_defend =
    space_numbers_to_defend(opponent_mark, board_state).sample
  return space_number_to_defend unless space_number_to_defend.nil?

  space_number_to_play = space_number_to_play(board_state)
  return space_number_to_play unless space_number_to_play.nil?

  available_spaces(board_state).sample
end

# ***********
# gameplay.rb
# ***********
def redraw(board_state, players)
  puts
  board_display(board_state, include_space_numbers: true)
  players_display(players)
  puts
end

def player_type_play!(player, players, board_state)
  if player[:is_computer]
    computer_play!(player[:mark], opponent(player, players)[:mark], board_state)
  else
    player_play!(player, board_state)
  end
end

def play!(board_state, players, game_state, round_state)
  players.each do |player|
    player_type_play!(player, players, board_state)

    redraw(board_state, players)
    update_game_state!(board_state, players, game_state, round_state)
    game_state_display(board_state, players, game_state)

    break if end_game?(game_state)
  end
end

def board_size_prompt
  puts 'Board Size (3-9)? '
  gets.strip.to_i
end

def start_game!(board_state, players, round_state)
  redraw(board_state, players)

  game_state = game_state_create
  loop do
    play!(board_state, players, game_state, round_state)
    break round_score_display(players, round_state) if end_game?(game_state)
  end
end

def start_round!(players)
  size = board_size_prompt
  round_state = round_state_create(players, round_win_score_prompt)

  loop do
    board_state = board_state_create(size: size)
    start_game!(board_state, players, round_state)
    break if end_round?(players, round_state)

    # Randomize starting player between games without changing mark:
    players.shuffle!
  end
end

# *******
# main.rb
# *******
def play
  players = welcome_players

  loop do
    start_round!(players)

    print "\nPlay again? (Y/N) "
    break puts 'Cheerio!' unless gets.strip.downcase.chars.first == 'y'
  end
end

play
