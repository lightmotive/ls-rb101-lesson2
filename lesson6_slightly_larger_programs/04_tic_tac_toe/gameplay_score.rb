# frozen_string_literal: true

def round_win_score_prompt
  puts 'Games to win (default: 5)?'
  round_win_score = gets.chomp

  return 5 if round_win_score.empty?

  round_win_score.to_i
end

def round_winner(players, round_win_score)
  players.select { |player| player[:score] == round_win_score }.first
end

def round_score_display(players)
  puts "\n-- Round Scoreboard --"
  players.sort_by { |player| player[:score] }.reverse.each do |player|
    puts "#{player[:name]}: #{player[:score]}"
  end
end

def round_score_final_display(winning_player, players)
  puts "** #{winning_player[:name]} won the round! **"
  round_score_display(players)
end
