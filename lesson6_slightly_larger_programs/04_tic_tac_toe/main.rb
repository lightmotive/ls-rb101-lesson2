# frozen_string_literal: true

# Flowchart: https://app.terrastruct.com/diagrams/2101848647

require_relative 'board_state'
require_relative 'board_display'
require_relative 'players'
require_relative 'gameplay'

def play
  players = welcome_players

  loop do
    start_game(players)

    print "\nPlay again? (Y/N) "
    break puts 'Cheerio!' unless gets.strip.downcase.chars.first == 'y'
  end
end

play
