require_relative 'dealer'

class Player < Dealer

  attr_accessor :move

  MOVE = [{key: :G, text: "Get card"}, {key: :S, text: "Skip move"}, {key: :O, text: "Open cards"}]

  def initialize (name, bank)
    @name = name
    @move = []
    @move += MOVE
    super
  end

  def reset
    @move.clear
    @move += MOVE
    super
  end

end