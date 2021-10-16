# frozen_string_literal: true

# Flowchart: https://app.terrastruct.com/diagrams/465606234
# Resource for card symbol characters:
#   https://en.wikipedia.org/wiki/Playing_cards_in_Unicode

# P1: Understand the problem
# With a player and a dealer, deal cards from a standard 52-card deck.
# - Start with 2 cards face up for player, and 1 up/1 down for the dealer.
# Player goes first: they can hit as long as they don't bust (exceed 21),
# or stay.
# Dealer goes second if player doesn't bust.
# - Dealer (computer) strategy:
#   - Hit until value is >= 17.
# The winner is the player closest to 21, or the one who doesn't bust.

# P2: Examples/Test Cases
# N/A for now.

# P3: Data Structure
# ** Cards **
# Array of hashes; one hash for each card; hash includes:
# - suit (hearts, diamonds, clubs, spades)
# - value (A, 2-10, J, Q, K)

# P4: Algorithm
# ** Calculate hand value **
# Sum all values as follows:
# - 2-10: face value
# - Jack, Queen, King: 10
# - Ace: depends on hand value...
#   - If hand value is <= 21 when ace is 11, then ace is 11.
#   - Otherwise, aces are worth 1.

# P5: Implementation

require_relative '../../ruby-common/prompt'
require_relative '../../ruby-common/validation_error'
require_relative '../../ruby-common/messages'

SPADES_ICON = "\u2660"
CLUBS_ICON = "\u2663"
HEARTS_ICON = "\u2665"
DIAMONDS_ICON = "\u2666"
CARDS = {
  suits: [SPADES_ICON, CLUBS_ICON, HEARTS_ICON, DIAMONDS_ICON],
  values: {
    ace: 'A',
    jqk: %w(J Q K),
    numeric: (2..10).to_a
  }
}.freeze
INPUTS = { hit: 'h', stay: 's' }.freeze
DEALER_NAME = 'Dealer'
MAX_VALUE = 21

# * Cards *

def cards_create
  cards = []

  values = [CARDS[:values][:ace]] +
           CARDS[:values][:jqk] +
           CARDS[:values][:numeric]

  CARDS[:suits].each do |suit|
    values.each { |value| cards.push({ suit: suit, value: value }) }
  end

  cards
end

def card_value(card, ace_value: 0)
  value = card[:value]
  value = 10 if CARDS[:values][:jqk].include?(value)
  value = ace_value if value == CARDS[:values][:ace]

  value
end

def all_cards_face_up?(cards)
  cards.all? { |card| card[:face_up] }
end

def cards_value(cards)
  return nil unless all_cards_face_up?(cards)

  value_with_ace11 = cards.sum { |card| card_value(card, ace_value: 11) }
  return value_with_ace11 if value_with_ace11 <= MAX_VALUE

  cards.sum { |card| card_value(card, ace_value: 1) }
end

def cards_for_display(cards)
  cards.map do |card|
    card[:face_up] ? "#{card[:suit]}#{card[:value]}" : "\u{1F0A0}"
  end
end

# * Game State *

def table_create(players)
  { players: players.map { |player| player.merge({ cards: [] }) } }
end

def game_state_create(players)
  {
    deck: cards_create.shuffle.shuffle.shuffle,
    table: table_create(players)
  }
end

def update_player_cards_value!(player)
  player[:cards_value] = cards_value(player[:cards])
end

def deal_card!(player, game_state, face_up: true)
  cards = player[:cards]
  cards.push(game_state[:deck].shift.merge({ face_up: face_up }))
  update_player_cards_value!(player)
end

def deal_table!(game_state)
  players_dealer_last = players_dealer_last(game_state)
  2.times do |card_idx|
    players_dealer_last.each do |player|
      face_up = (!player[:is_dealer]) || card_idx == 0
      deal_card!(player, game_state, face_up: face_up)
    end
  end
end

# * Players *

def welcome_display
  clear_console

  message = "#{CLUBS_ICON} Welcome to Twenty-One! #{CLUBS_ICON}"
  border = "#{SPADES_ICON}#{HEARTS_ICON.center(
    message.length - 2, DIAMONDS_ICON
  )}#{SPADES_ICON}"

  puts border
  puts message
  puts border
  display_empty_line
end

def players_prompt(player_strategy)
  welcome_display

  players = []
  # TODO: Extra features - Prompt for player count (up to 3) and names for each.
  puts "What's your name?"
  players.push({ name: gets.strip, is_dealer: false,
                 strategy: player_strategy })
end

def players_append_dealer!(players, dealer_strategy)
  players.push({ name: DEALER_NAME, is_dealer: true,
                 strategy: dealer_strategy })
end

def busted?(cards_value)
  return false if cards_value.nil?

  cards_value > MAX_VALUE
end

def end_turn?(player)
  value = player[:cards_value]
  return false if value.nil?

  busted?(value) || value == MAX_VALUE
end

def players_dealer_last(game_state)
  players = game_state.dig(:table, :players)
  players.sort_by { |player| player[:is_dealer] ? 1 : 0 }
end

def turn_cards_up!(player)
  player[:cards].each { |card| card[:face_up] = true }
  update_player_cards_value!(player)
end

def turn!(player, game_state)
  turn_cards_up!(player) if player[:is_dealer]

  return game_redraw(game_state) if end_turn?(player)

  loop do
    input = player[:strategy].call(player, game_state)
    if input == :hit
      deal_card!(player, game_state)
      game_redraw(game_state)
    end
    break if input == :stay || end_turn?(player)
  end
end

def players_in_play(game_state)
  game_state.dig(:table, :players).reject do |player|
    busted?(player[:cards_value])
  end
end

def players_by_top_score(game_state)
  players_in_play(game_state).sort_by { |player| -player[:cards_value] }
end

def winners(game_state)
  players = players_by_top_score(game_state)
  return [] if players.empty?

  winner = players.first
  winning_score = winner[:cards_value]

  [winner] + players[1..-1].select do |player|
    player[:cards_value] == winning_score
  end
end

def winners_display(winners)
  message = "No winner."
  if winners.size > 1
    winner_names = winners.map { |winner| winner[:name] }.join(' and ')
    message = "Tie game between #{winner_names}."
  elsif winners.size == 1 then message = "#{winners.first[:name]} won!"
  end

  puts "|*| #{message} |*|"
end

# * Game Display *

def game_table_lines(game_state)
  game_state.dig(:table, :players).map do |player|
    cards = player[:cards]
    value = player[:cards_value]
    busted_display = " - Busted!" if busted?(value)
    value_display = " [#{value}#{busted_display}]" unless value.nil?
    cards_display = cards_for_display(cards).join(' | ')

    "#{player[:name]}:#{value_display} #{cards_display}"
  end
end

def game_redraw(game_state)
  clear_console
  messages_bordered_display(game_table_lines(game_state),
                            DIAMONDS_ICON, header: ' Table ')
  display_empty_line
end

# * Main *

def play(players)
  game_state = game_state_create(players)
  deal_table!(game_state)
  game_redraw(game_state)

  players_dealer_last(game_state).each do |player|
    turn!(player, game_state)
  end

  game_redraw(game_state)
  winners_display(winners(game_state))
end

def play_again?
  display_empty_line
  prompt_yes_or_no("Would you like to play again?") == 'y'
end

def play_loop(dealer_strategy, player_strategy)
  players = players_prompt(player_strategy)
  players_append_dealer!(players, dealer_strategy)

  loop do
    play(players)

    break puts 'Thank you for playing Twenty-One!' unless play_again?
  end
end

# * Player Strategies *

dealer_strategy = lambda do |dealer_player, _game_state|
  cards = dealer_player[:cards]
  value = dealer_player[:cards_value]
  return :hit if value < 17

  :stay
end

def player_strategy_input_validator_create
  lambda do |input|
    unless INPUTS.values.include?(input)
      raise ValidationError,
            "Please enter either #{INPUTS.values.join(' or ')}."
    end
  end
end

def player_strategy_prompt(name, cards_value)
  inputs_display = INPUTS.map do |key, value|
    "#{key.to_s.capitalize} (#{value})"
  end.join(' or ')

  prompt_until_valid(
    "#{name}, you have #{cards_value}. #{inputs_display}?",
    convert_input: ->(input) { input.downcase },
    validate: player_strategy_input_validator_create
  )
end

player_strategy = lambda do |player, _game_state|
  cards_value = player[:cards_value]
  player_input = player_strategy_prompt(player[:name], cards_value)
  return INPUTS.rassoc(player_input)[0]
end

# * Play with specific strategies (easily customize strategies) *

play_loop(dealer_strategy, player_strategy)
