# frozen_string_literal: true

# Flowchart: https://app.terrastruct.com/diagrams/2101848647

require_relative 'players'
require_relative 'gameplay'
require_relative '../../../ruby-common/prompt'
require 'io/console'

def play
  $stdout.clear_screen

  players = welcome_players

  loop do
    start_round!(players)

    break puts 'Cheerio!' unless prompt_yes_or_no("Play another round?") == 'y'
    $stdout.clear_screen
  end
end

play
