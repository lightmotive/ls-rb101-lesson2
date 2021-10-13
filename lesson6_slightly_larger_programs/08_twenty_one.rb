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
HIT_INPUT = 'h'
STAY_INPUT = 's'
DEALER_NAME = 'Dealer'

def cards_create
  cards = []

  suits = ["\u2660", "\u2663", "\u2665", "\u2666"]
  values = %w(A J Q K) + (2..10).to_a

  suits.each do |suit|
    values.each { |value| cards.push({ suit: suit, value: value }) }
  end

  cards
end

def cards_value(_cards)
  # TODO:

  # ** Calculate hand value **
  # Sum all values as follows:
  # - 2-10: face value
  # - Jack, Queen, King: 10
  # - Ace: depends on hand value...
  #   - If hand value is <= 21 when ace is 11, then ace is 11.
  #   - Otherwise, aces are worth 1.
end

def cards_for_display(cards)
  cards.map do |card|
    card[:face_up] ? "#{card[:suit]}#{card[:value]}" : "\u{1F0A0}"
  end
end

def game_redraw(game_state)
  clear_console
  table_players = game_state.dig(:table, :players)

  table_players.each do |player|
    cards = player[:cards]
    puts "#{player[:name]}: #{cards_for_display(cards).join(' | ')}"
  end
end

def players_dealer_last(game_state)
  players = game_state.dig(:table, :players)
  players.sort_by { |player| player[:is_dealer] ? 1 : 0 }
end

def table_create(players)
  { players: players.map { |player| player.merge({ cards: [] }) } }
end

def game_state_create(players)
  {
    deck: cards_create.shuffle.shuffle.shuffle,
    table: table_create(players)
  }
end

def deal_card!(player, game_state, face_up: true)
  cards = player[:cards]
  cards.push(game_state[:deck].shift.merge({ face_up: face_up }))
end

def deal_table!(game_state)
  players_dealer_last = players_dealer_last(game_state)
  2.times do |card_idx|
    players_dealer_last.each do |player|
      face_up = !player[:is_dealer] || (player[:is_dealer] && card_idx == 0)
      deal_card!(player, game_state, face_up: face_up)
    end
  end
end

def continue_turn?(player)
  cards_value(player[:cards]) < 21
end

def turn!(player, game_state)
  loop do
    input = player[:strategy].call(player, game_state)
    if input == HIT_INPUT
      deal_card!(player, game_state)
      game_redraw(game_state)
    end
    break if input == STAY_INPUT || !continue_turn?(player)
  end
end

def display_winner(game_state)
  # TODO:
  # Determine winner based on hand value
  # First, check for bust. If no busts, compare value.
end

def players_prompt(player_strategy)
  puts "Welcome to Twenty-One!"

  players = []

  # TODO: Extra features - Prompt for player count (up to 3) and names for each.
  puts "What's your name?"
  players.push({
                 name: gets.strip,
                 is_dealer: false,
                 strategy: player_strategy
               })

  players
end

def players_append_dealer!(players, dealer_strategy)
  players.push({
                 name: DEALER_NAME,
                 is_dealer: true,
                 strategy: dealer_strategy
               })
end

def play(dealer_strategy, player_strategy)
  players = players_prompt(player_strategy)
  players_append_dealer!(players, dealer_strategy)

  game_state = game_state_create(players)
  deal_table!(game_state)
  game_redraw(game_state)

  players_dealer_last(game_state).each do |player|
    turn!(player, game_state)
  end

  # require 'pp'
  # pp game_state # Validate progress thus far.
  display_winner(game_state)
end

dealer_strategy = lambda do |dealer_player, _game_state|
  cards = dealer_player[:cards]
  value = cards_value(cards)

  return HIT_INPUT if value < 17

  STAY_INPUT
end

# rubocop:disable Metrics/MethodLength
def player_strategy_prompt(name, cards_value)
  prompt_until_valid(
    "#{name}, you have #{cards_value}. " \
    "Hit (#{HIT_INPUT}) or stay (#{STAY_INPUT})?",
    convert_input: ->(input) { input.downcase },
    validate: lambda do |input|
      unless %W(#{HIT_INPUT} #{STAY_INPUT}).include?(input)
        raise ValidationError,
              "Please enter either #{HIT_INPUT} or #{STAY_INPUT}."
      end
    end
  )
end
# rubocop:enable Metrics/MethodLength

player_strategy = lambda do |player, _game_state|
  cards_value = cards_value(player[:cards])
  player_input = player_strategy_prompt(player[:name], cards_value)
  return HIT_INPUT if player_input == 'h'
  STAY_INPUT
end

play(dealer_strategy, player_strategy)