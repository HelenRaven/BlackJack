# frozen_string_literal: true

class Card
  UNICODE = { hearts: "\u2665", spades: "\u2660", clubs: "\u2663", diamonds: "\u2666" }.freeze
  attr_reader :value, :suite, :cost

  def initialize(value, suite)
    @value = value
    @suite = suite
    set_cost
  end

  def unicode
    UNICODE[@suite]
  end

  private

  def set_cost
    @cost = value if @value.instance_of?(Integer)
    @cost = @value == 'A' ? 11 : 10 if @value.instance_of?(String)
  end
end
