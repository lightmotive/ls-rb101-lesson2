# frozen_string_literal: true

# Flowchart: https://app.terrastruct.com/diagrams/2101848647

require_relative 'players'
require_relative 'gameplay'
require_relative '../../../ruby-common/prompt'

def play
  clear_console

  players = welcome_players

  loop do
    start_round!(players)

    break puts 'Cheerio!' unless prompt_yes_or_no("Play another round?") == 'y'
    clear_console
  end
end

play
