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

def cards_for_display(cards)
  cards.map do |card|
    card[:face_up] ? "#{card[:suit]}#{card[:value]}" : "\u{1F0A0}"
  end
end

def game_redraw(game_state)
  table_players = game_state.dig(:table, :players)

  table_players.each do |player|
    cards = player[:cards]
    puts "#{player[:name]}: #{cards_for_display(cards).join(' | ')}"
  end
end

def table_create(players)
  { players: players.map { |player| { cards: [] }.merge(player) } }
end

def game_state_create(players)
  {
    deck: cards_create.shuffle.shuffle.shuffle,
    table: table_create(players)
  }
end

def deal_cards!(game_state)
  players = game_state.dig(:table, :players)
  players_dealer_last = players.sort_by { |player| player[:is_dealer] ? 1 : 0 }
  2.times do |card_idx|
    players_dealer_last.each do |player|
      cards = player[:cards]
      face_up = !player[:is_dealer] || (player[:is_dealer] && card_idx == 0)
      cards.push(game_state[:deck].shift.merge({ face_up: face_up }))
    end
  end
end

def turn!(_player_key, game_state)
  # Get player and execute strategy

  # game_redraw(game_state)
end

def continue_game?(game_state)
  # Continue as long as no player has busted
end

def display_winner(game_state)
  # Determine winner based on hand value
  # First, check for bust. If no busts, compare value.
end

def players_prompt(player_strategy)
  puts "Welcome to Twenty-One!"

  players = []

  # TODO: Add prompt for name(s)...
  players.push({
                 name: "Player 1",
                 is_dealer: false,
                 strategy: player_strategy
               })

  players
end

def players_append_dealer!(players, dealer_strategy)
  players.push({
                 name: "Dealer",
                 is_dealer: true,
                 strategy: dealer_strategy
               })
end

def play(dealer_strategy, player_strategy)
  players = players_prompt(player_strategy)
  players_append_dealer!(players, dealer_strategy)

  game_state = game_state_create(players)
  deal_cards!(game_state)
  game_redraw(game_state)

  # require 'pp'
  # pp game_state # Validate progress thus far.

  turn!(:player, game_state)
  turn!(:dealer, game_state) if continue_game?(game_state)
  display_winner(game_state)
end

dealer_strategy = lambda do |game_state|
  cards = game_state.dig(:table, :dealer, :cards)
  value = cards_value(cards)

  return HIT_INPUT if value < 17

  STAY_INPUT
end

player_strategy = lambda do |_game_state|
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

play(dealer_strategy, player_strategy)
