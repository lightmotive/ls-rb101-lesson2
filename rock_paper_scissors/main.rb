# frozen_string_literal: true

def prompt(message)
  Kernel.puts("=> #{message}")
end

CHOICES = {
  rock: { beats: [:scissors] },
  paper: { beats: [:rock] },
  scissors: { beats: [:paper] }
}.freeze

def choices_as_strings
  CHOICES.keys.map(&:to_s)
end

def choice_valid?(choice)
  choices_as_strings.include?(choice)
end

def game_result(player_choice, computer_choice)
  return :tie if player_choice == computer_choice
  return :win if CHOICES[player_choice.to_sym][:beats].include?(computer_choice.to_sym)

  :lose
end

def game_result_print(result)
  prompt('You won!') if result == :win
  prompt('Tie!') if result == :tie
  prompt('You lost.') if result == :lose
end

loop do
  user_choice = nil
  loop do
    prompt("Choose one: #{choices_as_strings.join(', ')}")
    user_choice = Kernel.gets.chomp
    break if choice_valid?(user_choice)

    prompt("That wasn't a valid choice. Please try again.")
  end

  computer_choice = choices_as_strings.sample
  prompt("Computer: #{computer_choice}")

  game_result_print(game_result(user_choice, computer_choice))

  puts("\n")
  prompt('Would you like to play again?')
  play_again = gets.strip
  break unless play_again.downcase.start_with?('y')
end
