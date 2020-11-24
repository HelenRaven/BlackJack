# frozen_string_literal: true

require_relative 'player'
require_relative 'deck'
require_relative 'validation'

class Game
  include Validation

  attr_reader :status, :actions, :player, :dealer, :game_bank

  validate :bank, :positive
  validate :bet, :positive

  def initialize(player_name, bank = 100, bet = 10)
    @bank = bank
    @bet = bet
    validate!
    @deck = Deck.new
    @dealer = Dealer.new("Dealer", @bank)
    @player = Player.new(player_name, @bank)
    @game_bank = 0
    @status = :player
    @actions = []
  end

  # Game moves ---------------------------------------------------

  def get_cards(player, number)
    number.times { player.take_card(@deck.issue_card) }
  end

  def make_bets(bet)
    @game_bank = 2 * bet
    @player.make_bet(bet)
    @dealer.make_bet(bet)
  end

  def dealer_move
    get_cards(@dealer, 1) if @dealer.score < 17 && @dealer.cards.size < 3
    @status = if @player.cards.size == 3 && @dealer.cards.size == 3
                :open
              else
                :player
              end
  end

  def player_actions
    @actions.clear
    i = @player.move.size < 2 ? @player.move.size : 2
    i.times { |k| @actions[k] = @player.move[k] }
  end

  def player_move(key)
    @player.move.delete(key)
    case key
    when :open
      @status = :open
    when :skip
      @status = :dealer
    when :get
      get_cards(@player, 1)
      @status = if @player.cards.size == 3 && @dealer.cards.size == 3
                  :open
                else
                  :dealer
                end
    end
  end

  # Game result moves -----------------------------------------------

  def find_winner
    if (@dealer.score <= 21 && @player.score > 21) || (@dealer.score <= 21 && @player.score <= 21 && @dealer.score > @player.score)
      give_winning(@dealer)
      winner(@dealer)
    elsif (@dealer.score > 21 && @player.score > 21) || ((@dealer.score == @player.score) && @dealer.score <= 21 && @player.score <= 21)
      draw_game
      winner(nil)
    else
      give_winning(@player)
      winner(@player)
    end
  end

  def give_winning(winner)
    winner.get_win(@game_bank)
    @game_bank = 0
  end

  def draw_game
    @player.get_win(@game_bank / 2)
    @dealer.get_win(@game_bank / 2)
    @game_bank = 0
  end

  def winner(player)
    @actions.clear
    @actions << if player.nil?
                  'draw'
                else
                  player.name
                end
  end

  # Setting initial values --------------------------------------------------------

  def start
    @status = :player
    @actions.clear
    reset
    get_cards(@player, 2)
    get_cards(@dealer, 2)
    make_bets(@bet)
  end

  def reset
    @player.reset
    @dealer.reset
    @deck.recover
  end

  def reset_banks
    @dealer.bank = @bank
    @player.bank = @bank
    @game_bank = 0
  end

  def finish?
    if @dealer.bank.zero?
      winner(@player)
      reset_banks
      true
    elsif @player.bank.zero?
      winner(@dealer)
      reset_banks
      true
    else
      false
    end
  end
end
