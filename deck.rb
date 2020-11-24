# frozen_string_literal: true

require_relative 'card'

class Deck
  SUITS = %i[hearts spades clubs diamonds].freeze
  VALUES = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'J', 'Q', 'K', 'A'].freeze

  def initialize
    @cards = []
    SUITS.each { |suite| VALUES.each { |value| @cards << Card.new(value, suite) } }
    @deck = []
    @deck += @cards
  end

  def recover
    @deck.clear
    @deck += @cards
  end

  def issue_card
    @deck.shuffle!
    @deck.delete_at(0)
  end
end
