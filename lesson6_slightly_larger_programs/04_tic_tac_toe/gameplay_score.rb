# frozen_string_literal: true

require_relative 'players'
require_relative 'messages'

def round_state_create(players, win_score)
  round_state = { win_score: win_score, scores: {} }

  players.each do |player|
    round_state[:scores][player_id(player)] = 0
  end

  round_state
end

def round_player_score(player, round_state)
  round_state[:scores][player_id(player)]
end

def round_player_score_increment(player, round_state)
  round_state[:scores][player_id(player)] += 1
end

def round_win_score_prompt
  puts 'Games to win (default: 5)?'
  win_score = gets.chomp

  return 5 if win_score.empty?

  win_score.to_i
end

def round_winner(players, round_state)
  players.select { |player| round_player_score(player, round_state) == round_state[:win_score] }.first
end

def round_score_display(players, round_state)
  puts
  messages_bordered_display(
    players.sort_by { |player| round_player_score(player, round_state) }.reverse.map do |player|
      "#{player[:name]}: #{round_player_score(player, round_state)}"
    end,
    '=', header: 'Round Scoreboard'
  )
end

def round_score_final_display(winning_player)
  puts
  messages_bordered_display("#{winning_player[:name]} won the round!", '*')
end

def end_round?(players, round_state)
  round_winner = round_winner(players, round_state)

  if round_winner.nil?
    puts 'Press enter to continue the round...'
    gets
    false
  else
    round_score_final_display(round_winner)
    true
  end
end
