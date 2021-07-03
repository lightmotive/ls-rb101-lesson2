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

def game_result(player1_choice, player2_choice)
  return :tie if player1_choice == player2_choice
  return :win if CHOICES[player1_choice.to_sym][:beats].include?(player2_choice.to_sym)

  :lose
end

def game_result_print(result)
  prompt('You won!') if result == :win
  prompt('Tie!') if result == :tie
  prompt('You lost.') if result == :lose
end

loop do
  player1_choice = nil
  loop do
    prompt("Choose one: #{choices_as_strings.join(', ')}")
    player1_choice = Kernel.gets.chomp.downcase
    break if choice_valid?(player1_choice)

    prompt("That wasn't a valid choice. Please try again.")
  end

  player2_choice = choices_as_strings.sample
  prompt("Computer: #{player2_choice}")

  game_result_print(game_result(player1_choice, player2_choice))
  # Future tip: print the result for player2 by simply switching the choice arguments.

  puts("\n")
  prompt('Would you like to play again?')
  play_again = gets.strip
  break unless play_again.downcase.start_with?('y')
end
