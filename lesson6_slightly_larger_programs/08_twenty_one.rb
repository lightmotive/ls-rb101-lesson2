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

def cards_create
  cards = []

  suits = ["\u2660", "\u2663", "\u2665", "\u2666"]
  values = %w(A J Q K) + (2..10).to_a

  suits.each do |suit|
    values.each { |value| cards.push({ suit: suit, value: value }) }
  end

  cards
end

def cards_value(cards)
  # ** Calculate hand value **
  # Sum all values as follows:
  # - 2-10: face value
  # - Jack, Queen, King: 10
  # - Ace: depends on hand value...
  #   - If hand value is <= 21 when ace is 11, then ace is 11.
  #   - Otherwise, aces are worth 1.
end

def table_draw(game_state)
  # Draw dealer and player hands
  # "#{card[:suit]}#{card[:value]}"
end

def player_strategy(_game_state)
  prompt_until_valid(
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

def dealer_strategy(game_state)
  cards = game_state.dig(:table, :dealer, :cards)
  value = cards_value(cards)

  return HIT_INPUT if value < 17

  STAY_INPUT
end

def table_create
  {
    dealer: { cards: [] },
    player: { cards: [] }
  }
end

def game_state_create
  state = {}

  state[:players] = {
    dealer: { strategy: dealer_strategy },
    player: { strategy: player_strategy }
  }
  state[:deck] = cards_create.shuffle.shuffle.shuffle
  state[:table] = table_create

  state
end

def deal_cards!(game_state)
  # Flowchart: https://app.terrastruct.com/diagrams/465606234
  # With a player and a dealer, deal cards from a standard 52-card deck.
  # - Start with 2 cards face up for player, and 1 up/1 down for the dealer.
end

def turn!(player_key, game_state)
  # Get player and execute strategy
  # After each, draw table
end

def continue_game?(game_state)
  # Continue as long as no player has busted
end

def display_winner(game_state)
  # Determine winner based on hand value
  # First, check for bust. If no busts, compare value.
end

def play
  game_state = game_state_create
  deal_cards!(game_state)
  turn!(:player, game_state)
  turn!(:dealer, game_state) if continue_game?(game_state)
  display_winner(game_state)
end

# play
