class Deck

  DECK = [
    {value: 2, suite: :hearts, cost: 2}, {value: 2, suite: :clubs, cost: 2}, {value: 2, suite: :spades, cost: 2}, {value: 2, suite: :diamonds, cost: 2},
    {value: 3, suite: :hearts, cost: 3}, {value: 3, suite: :clubs, cost: 3}, {value: 3, suite: :spades, cost: 3}, {value: 3, suite: :diamonds, cost: 3},
    {value: 4, suite: :hearts, cost: 4}, {value: 4, suite: :clubs, cost: 4}, {value: 4, suite: :spades, cost: 4}, {value: 4, suite: :diamonds, cost: 4},
    {value: 5, suite: :hearts, cost: 5}, {value: 5, suite: :clubs, cost: 5}, {value: 5, suite: :spades, cost: 5}, {value: 5, suite: :diamonds, cost: 5},
    {value: 6, suite: :hearts, cost: 6}, {value: 6, suite: :clubs, cost: 6}, {value: 6, suite: :spades, cost: 6}, {value: 6, suite: :diamonds, cost: 6},
    {value: 7, suite: :hearts, cost: 7}, {value: 7, suite: :clubs, cost: 7}, {value: 7, suite: :spades, cost: 7}, {value: 7, suite: :diamonds, cost: 7},
    {value: 8, suite: :hearts, cost: 8}, {value: 8, suite: :clubs, cost: 8}, {value: 8, suite: :spades, cost: 8}, {value: 8, suite: :diamonds, cost: 8},
    {value: 9, suite: :hearts, cost: 9}, {value: 9, suite: :clubs, cost: 9}, {value: 9, suite: :spades, cost: 9}, {value: 9, suite: :diamonds, cost: 9},
    {value: 10, suite: :hearts, cost: 10}, {value: 10, suite: :clubs, cost: 10}, {value: 10, suite: :spades, cost: 10}, {value: 10, suite: :diamonds, cost: 10},
    {value: :J, suite: :hearts, cost: 10}, {value: :J, suite: :clubs, cost: 10}, {value: :J, suite: :spades, cost: 10}, {value: :J, suite: :diamonds, cost: 10},
    {value: :Q, suite: :hearts, cost: 10}, {value: :Q, suite: :clubs, cost: 10}, {value: :Q, suite: :spades, cost: 10}, {value: :Q, suite: :diamonds, cost: 10},
    {value: :K, suite: :hearts, cost: 10}, {value: :K, suite: :clubs, cost: 10}, {value: :K, suite: :spades, cost: 10}, {value: :K, suite: :diamonds, cost: 10},
    {value: :T, suite: :hearts, cost: 11}, {value: :T, suite: :clubs, cost: 11}, {value: :T, suite: :spades, cost: 11}, {value: :T, suite: :diamonds, cost: 11},
  ]

  attr_reader :deck

  def initialize
    recover
  end

  def recover
    @deck = DECK
  end

  def issue_card
    @deck.shuffle!
    @deck.delete_at(0)
  end


end