require_relative 'screen'
require_relative 'player'
require_relative 'deck'
require_relative 'validation'

class Game
  include Validation

  validate :bank, :positive

  SHIRT = [" ____ ",
          "|////|",
          "|////|",
          "|////|",
          " ---- "]

  def initialize(player_name, bank)
    @bank = bank
    validate!
    @deck = Deck.new
    @dealer = Dealer.new("Dealer", @bank)
    @player = Player.new(player_name, @bank)
    @screen = Screen.new(80, 15)
    @game_bank = 0
    @x_player = 2
    @x_dealer = 30
    @turn = :player
  end

# Drawing picture of card -------------------------------------------------

  def card_picture(card)
    pict = [" ____ "]
    pict.push("|"+ card[:suite]+"   |")
    if card[:value] == 10
      pict << "| 10 |"
    else
      pict << "|  #{card[:value]} |"
    end
    pict << "|    |"
    pict << " ---- "
    pict
  end

# Drawing info -------------------------------------------------------------

  def draw_player_info(x, player, score = true)
    @screen.add_image(x, 1, [player.name])
    @screen.add_image(x, 9, ["bank: #{player.bank}  "])
    if score
      @screen.add_image(x, 10, ["score: #{player.score}  "])
    else
      @screen.add_image(x, 10, ["score:"])
    end
    @screen.print_screen
  end

  def draw_cards(x, player, face = true)
    player.cards.each.with_index do |card, i|
      if face
        @screen.add_image(x + i * 8, 3, card_picture(card))
      else
        @screen.add_image(x + i * 8, 3, SHIRT)
      end
      @screen.print_screen(0.5)
    end
  end

  def draw_info
    draw_player_info(@x_player, @player)
    draw_player_info(@x_dealer, @dealer, false)
    @screen.add_image(15, 12, ["Game bank = #{@game_bank}  "])
    @screen.print_screen
  end

# Game moves ---------------------------------------------------

  def get_cards(player, number)
    number.times {player.take_card(@deck.issue_card)}
  end

  def make_bets(bet)
    @game_bank = 2 * bet
    @player.make_bet(bet)
    @dealer.make_bet(bet)
    draw_info
  end

  def dealer_move
    if @dealer.score < 17 && @dealer.cards.size < 3
      get_cards(@dealer,1)
      draw_cards(@x_dealer, @dealer, false)
    end
    @turn = :player
  end

  def player_move
    puts "Enter your choice:"
    i = @player.move.size < 2 ? @player.move.size : 2
    i.times {|k| puts "#{@player.move[k][:text]} (#{k + 1})"}
    answer = gets.to_i
    key = @player.move[answer - 1][:key]
    @player.move.delete_at(answer - 1)

    case key
    when :O
      @turn = :open
    when :S
      @turn = :dealer
    when :G
      get_cards(@player, 1)
      draw_cards(@x_player, @player)
      draw_player_info(@x_player, @player)
      @turn = :dealer
    end
  end

# Game result moves -----------------------------------------------

  def open_cards
    draw_cards(@x_dealer, @dealer)
    draw_player_info(@x_dealer, @dealer, true)
    find_winner
    reset
  end

  def find_winner
    if (@dealer.score <= 21 && @player.score > 21) || (@dealer.score <= 21 && @player.score <= 21 && @dealer.score > @player.score)
      give_winning(@dealer)
    elsif (@dealer.score > 21 && @player.score > 21) || ((@dealer.score == @player.score) && @dealer.score <= 21 && @player.score <= 21)
      draw_game
    else
      give_winning(@player)
    end
  end

  def give_winning(winner)
    winner.get_win(@game_bank)
    @game_bank = 0
    draw_info
    puts "#{winner.name} is winner!"
  end

  def draw_game
    @player.get_win(@game_bank / 2)
    @dealer.get_win(@game_bank / 2)
    draw_info
    puts "Draw game!"
  end

# Setting initial values --------------------------------------------------------

  def start
    draw_info
    get_cards(@player, 2)
    get_cards(@dealer, 2)
    draw_cards(@x_player, @player, false)
    draw_cards(@x_dealer, @dealer, false)
    draw_cards(@x_player, @player)
    sleep 0.5
    draw_info
    sleep 1
    make_bets(10)
  end

  def reset
    @player.reset
    @dealer.reset
    @deck.recover
    @turn = :player
  end

  def reset_banks
    @dealer.bank = @bank
    @player.bank = @bank
    @game_bank = 0
  end

# Game -----------------------------------------------------------------------------

  def run
    loop do
    @screen.clear
    start
      loop do
        case @turn
        when :dealer
          dealer_move
        when :player
          player_move
        when :open
          open_cards
          break
        end
        if @player.cards.size == 3 && @dealer.cards.size == 3
          open_cards
          break
        end
      end
      if @dealer.bank == 0
        puts "Congratulations, #{@player.name}, you`re win!"
        reset_banks
      elsif @player.bank == 0
        puts "Sorry, #{@dealer.name} is winner!"
        reset_banks
      end

      puts "Play new game? (y/n)?"
      answ = gets.chomp.downcase
      break if answ == 'n'
    end
  end

end