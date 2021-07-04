# frozen_string_literal: true

def prompt(message)
  Kernel.puts("=> #{message}")
end

# Game creator that added Spock and Lizard :-): https://web.archive.org/web/20181217114425/http://www.samkass.com/theories/RPSSL.html
CHOICES = {
  rock: { beats: %i[scissors lizard], short_choice: 'r' },
  paper: { beats: %i[rock spock], short_choice: 'p' },
  scissors: { beats: %i[paper lizard], short_choice: 'sc' },
  spock: { beats: %i[rock scissors], short_choice: 'sp' },
  lizard: { beats: %i[paper spock], short_choice: 'l' }
}.freeze

def choices_as_string_list
  CHOICES.map do |key, detail|
    choice = key.to_s
    short_choice = detail[:short_choice]
    choice.delete_prefix(short_choice).insert(0, "(#{short_choice.capitalize})")
  end
end

def choices_prompt
  prompt("What's your throw? #{choices_as_string_list.join(', ')}")
end

# Convert choice string (full or short) to a symbol if not already a symbol.
# Return nil if key isn't found.
def choice_to_key(choice)
  return choice if choice.is_a?(Symbol) && CHOICES.key?(choice)

  if choice.is_a?(String)
    choice = choice.strip.downcase
    return choice.to_sym if CHOICES.key?(choice.to_sym)

    found = CHOICES.select { |_, detail| detail[:short_choice] == choice }
    return found.keys[0] unless found.nil?
  end

  nil
end

def choice_key_to_display_string(choice)
  choice.to_s.capitalize
end

def choice_valid?(choice)
  CHOICES.key?(choice_to_key(choice))
end

def game_result(player1_key, player2_key)
  return nil if player1_key.nil? || player2_key.nil?

  return :tie if player1_key == player2_key
  return :win if CHOICES[player1_key][:beats].include?(player2_key)

  :lose
end

def game_result_print(player1_key, player2_key, result)
  prompt("You threw #{choice_key_to_display_string(player1_key)}")
  prompt("Computer threw #{choice_key_to_display_string(player2_key)}")

  prompt(case result
         when :win then 'You won!'
         when :tie then 'Tie!'
         when :lose then 'You lost.'
         else 'Ooops, there was a game error :-('
         end)
end

loop do
  player1_choice = nil
  loop do
    choices_prompt
    player1_choice = Kernel.gets.strip.downcase
    break if choice_valid?(player1_choice)

    prompt("That wasn't a valid choice. Please try again.")
  end

  player1_key = choice_to_key(player1_choice)
  player2_key = CHOICES.keys.sample
  result = game_result(player1_key, player2_key)
  # Future tip: print the result for player2 by simply switching the key arguments.

  game_result_print(player1_key, player2_key, result)

  puts("\n")
  prompt('Would you like to play again?')
  play_again = gets.strip
  break unless play_again.downcase.start_with?('y')
end
