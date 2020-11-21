require_relative 'dealer'
require_relative 'validation'

class Player < Dealer

  include Validation

  attr_accessor :move
  validate :name, :presence
  validate :bank, :positive

  MOVE = [{key: :G, text: "Get card"}, {key: :S, text: "Skip move"}, {key: :O, text: "Open cards"}]

  def initialize (name, bank)
    @name = name
    @move = []
    @move += MOVE
    super
    validate!
  end

  def reset
    @move.clear
    @move += MOVE
    super
  end

end