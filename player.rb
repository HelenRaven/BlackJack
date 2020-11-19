class Player

  attr_accessor :bank, :cards
  attr_reader :name


  def initialize(name, bank)
    @name = name
    @cards = []
    @bank = bank
  end

end