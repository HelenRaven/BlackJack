require_relative 'validation'

class Dealer
  include Validation

  attr_accessor :bank
  attr_reader :name, :score, :cards

  validate :name, :presence
  validate :bank, :positive

  def initialize(name, bank)
    @name = name
    @cards = []
    @bank = bank
    @score = 0
  end

  def scores
    @score = 0
    aces = 0
    @cards.each do |card|
      aces += 1 if card[:value] == :T
      @score += card[:cost]
    end
    aces.times { @score -= 10 if @score > 21 }
  end

  def make_bet(value)
    @bank -= value
  end

  def get_win(value)
    @bank += value
  end

  def take_card(card)
    @cards << card
    scores
  end

  def reset
    @cards.clear
    @score = 0
  end

end