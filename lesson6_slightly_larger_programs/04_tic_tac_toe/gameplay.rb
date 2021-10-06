# frozen_string_literal: true

require_relative 'board_state'
require_relative 'gameplay_score'
require_relative 'game_state'
require_relative 'computer_logic'
require 'io/console'

def redraw(board_state, players, game_state: nil)
  $stdout.clear_screen
  board_display(board_state, include_space_numbers: true)
  players_display(players, game_state: game_state)
end

def player_type_play!(player, players, board_state, game_state)
  puts
  if player[:is_computer]
    computer_play!(player[:mark], opponent(player, players)[:mark],
                   board_state, game_state)
  else
    player_play!(player, board_state, game_state)
  end
end

def play!(board_state, players, game_state, round_state)
  players.each do |player|
    player_type_play!(player, players, board_state, game_state)

    redraw(board_state, players, game_state: game_state)
    update_game_state!(board_state, players, game_state, round_state)
    game_state_display(board_state, players, game_state)

    break if end_game?(game_state)
  end
end

def board_size_prompt
  prompt_until_valid(
    "Board Size (3-9)?",
    get_input: -> { gets.strip },
    convert_input: ->(input) { input.to_i },
    validate: lambda do |input|
      unless (3..9).include?(input)
        raise ValidationError, "Please enter a number between 3 and 9."
      end
    end
  )
end

def start_game!(board_state, players, round_state)
  redraw(board_state, players)

  game_state = game_state_create
  loop do
    play!(board_state, players, game_state, round_state)
    break round_score_display(players, round_state) if end_game?(game_state)
  end
end

def start_round!(players)
  size = board_size_prompt
  round_state = round_state_create(players, round_win_score_prompt)

  loop do
    board_state = board_state_create(size: size)
    start_game!(board_state, players, round_state)
    break if end_round?(players, round_state)

    $stdout.clear_screen

    # Randomize starting player between games without changing mark:
    players.shuffle!
  end
end
