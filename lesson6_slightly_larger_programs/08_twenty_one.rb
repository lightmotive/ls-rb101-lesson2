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
# - value (2-10, j, q, k, ace)

# P4: Algorithm
# ** Calculate hand value **
# Sum all values as follows:
# - 2-10: face value
# - Jack, Queen, King: 10
# - Ace: depends on hand value...
#   - If hand value is <= 21 when ace is 11, then ace is 11.
#   - Otherwise, aces are worth 1.

# P5: Implementation

def cards_create
  # ** Cards **
  # Array of hashes; one hash for each card; hash includes:
  # - suit (hearts-\u2665, diamonds-\u2666, clubs-\u2663, spades-\u2660)
  # - value (2-10, j, q, k, ace)
end

def player_strategy_create
  # Player goes first: they can hit as long as they don't bust (exceed 21),
  # or stay.
end

def dealer_strategy_create
  # Dealer goes second if player doesn't bust.
  # - Dealer (computer) play rules:
  #   - Hit until value is >= 17.
end

def game_state_create
  # Return new game state with players and a shuffled deck of cards
  # With a player and a dealer, deal cards from a standard 52-card deck.
  # - Start with 2 cards face up for player, and 1 up/1 down for the dealer.
end

def deal_cards!(game_state)
  # Flowchart: https://app.terrastruct.com/diagrams/465606234
end

def turn!(player_key, game_state)
  # Get player and execute strategy
end

def hand_value(hand)
  # ** Calculate hand value **
  # Sum all values as follows:
  # - 2-10: face value
  # - Jack, Queen, King: 10
  # - Ace: depends on hand value...
  #   - If hand value is <= 21 when ace is 11, then ace is 11.
  #   - Otherwise, aces are worth 1.
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
  turn!(:dealer, game_state) if continue_hand?(game_state)
  display_winner(game_state)
end

play
