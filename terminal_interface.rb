# frozen_string_literal: true

require_relative 'game'
require_relative 'screen'

class TerminalInterface
  def initialize(game)
    @game = game
    @screen = Screen.new(80, 15)
    @x_player = 2
    @x_dealer = 30
  end

  # Drawing picture of card -------------------------------------------------

  SHIRT = [" ____ ",
           "|////|",
           "|////|",
           "|////|",
           " ---- "].freeze

  def card_picture(card)
    pict = [" ____ "]
    pict.push("|#{card.unicode}   |")
    pict << if card.value == 10
              "| 10 |"
            else
              "|  #{card.value} |"
            end
    pict << "|    |"
    pict << " ---- "
    pict
  end

  # Drawing info -------------------------------------------------------------

  def draw_player_info(x, player, score: true)
    @screen.add_image(x, 1, [player.name])
    @screen.add_image(x, 9, ["bank: #{player.bank}  "])
    if score
      @screen.add_image(x, 10, ["score: #{player.score}  "])
    else
      @screen.add_image(x, 10, ["score:"])
    end
    @screen.print_screen
  end

  def draw_cards(x, player, delay = 0, face: true)
    player.cards.each.with_index do |card, i|
      if face
        @screen.add_image(x + i * 8, 3, card_picture(card))
      else
        @screen.add_image(x + i * 8, 3, SHIRT)
      end
      @screen.print_screen(delay)
    end
  end

  def draw_info(dealer_score: false)
    draw_player_info(@x_player, @game.player)
    draw_player_info(@x_dealer, @game.dealer, score: dealer_score)
    @screen.add_image(15, 12, ["Game bank = #{@game.game_bank}  "])
    @screen.print_screen
  end

  def draw_start
    draw_player_info(@x_player, @game.player, score: false)
    draw_player_info(@x_dealer, @game.dealer, score: false)
    draw_cards(@x_player, @game.player, 0.5, face: false)
    draw_cards(@x_dealer, @game.dealer, 0.5, face: false)
    draw_cards(@x_player, @game.player, 0.5)
    draw_info
  end

  def draw_game
    draw_cards(@x_player, @game.player)
    draw_cards(@x_dealer, @game.dealer, face: false)
    draw_info
  end

  def answer
    puts "Chose action:"
    @game.actions.each.with_index(1) do |action, i|
      case action
      when :get
        puts "Get card (#{i})"
      when :skip
        puts "Skip move (#{i})"
      when :open
        puts "Open cards (#{i})"
      end
    end
    i = gets.to_i
    @game.actions[i - 1]
  end

  # Game -----------------------------------------------------------------------------

  def round
    loop do
      case @game.status
      when :dealer
        @game.dealer_move
        draw_game
      when :player
        @game.player_actions
        key = answer
        @game.player_move(key)
        draw_game
      when :open
        draw_cards(@x_dealer, @game.dealer, 0.5)
        draw_player_info(@x_dealer, @game.dealer)
        @game.find_winner
        draw_info(dealer_score: true)
        winner = @game.actions[0]
        if winner == 'draw'
          puts "Draw game!"
        else
          puts "#{winner} is round winner!"
        end
        break
      end
    end
  end

  def start_game
    loop do
      @screen.clear
      @game.start
      draw_start
      round
      if @game.finish?
        winner = @game.actions[0]
        puts "#{winner} is Game winner!"
        puts "Play new Game? (y/n):"
      else
        puts "Play new round? (y/n):"
      end
      answer = gets.chomp.downcase
      break if answer == 'n'
    end
  end
end
