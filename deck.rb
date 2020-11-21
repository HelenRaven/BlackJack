class Deck

  DECK = [
    {value: 2, suite: "\u2665", cost: 2}, {value: 2, suite: "\u2663", cost: 2}, {value: 2, suite: "\u2660", cost: 2}, {value: 2, suite: "\u2666", cost: 2},
    {value: 3, suite: "\u2665", cost: 3}, {value: 3, suite: "\u2663", cost: 3}, {value: 3, suite: "\u2660", cost: 3}, {value: 3, suite: "\u2666", cost: 3},
    {value: 4, suite: "\u2665", cost: 4}, {value: 4, suite: "\u2663", cost: 4}, {value: 4, suite: "\u2660", cost: 4}, {value: 4, suite: "\u2666", cost: 4},
    {value: 5, suite: "\u2665", cost: 5}, {value: 5, suite: "\u2663", cost: 5}, {value: 5, suite: "\u2660", cost: 5}, {value: 5, suite: "\u2666", cost: 5},
    {value: 6, suite: "\u2665", cost: 6}, {value: 6, suite: "\u2663", cost: 6}, {value: 6, suite: "\u2660", cost: 6}, {value: 6, suite: "\u2666", cost: 6},
    {value: 7, suite: "\u2665", cost: 7}, {value: 7, suite: "\u2663", cost: 7}, {value: 7, suite: "\u2660", cost: 7}, {value: 7, suite: "\u2666", cost: 7},
    {value: 8, suite: "\u2665", cost: 8}, {value: 8, suite: "\u2663", cost: 8}, {value: 8, suite: "\u2660", cost: 8}, {value: 8, suite: "\u2666", cost: 8},
    {value: 9, suite: "\u2665", cost: 9}, {value: 9, suite: "\u2663", cost: 9}, {value: 9, suite: "\u2660", cost: 9}, {value: 9, suite: "\u2666", cost: 9},
    {value: 10, suite: "\u2665", cost: 10}, {value: 10, suite: "\u2663", cost: 10}, {value: 10, suite: "\u2660", cost: 10}, {value: 10, suite: "\u2666", cost: 10},
    {value: :J, suite: "\u2665", cost: 10}, {value: :J, suite: "\u2663", cost: 10}, {value: :J, suite: "\u2660", cost: 10}, {value: :J, suite: "\u2666", cost: 10},
    {value: :Q, suite: "\u2665", cost: 10}, {value: :Q, suite: "\u2663", cost: 10}, {value: :Q, suite: "\u2660", cost: 10}, {value: :Q, suite: "\u2666", cost: 10},
    {value: :K, suite: "\u2665", cost: 10}, {value: :K, suite: "\u2663", cost: 10}, {value: :K, suite: "\u2660", cost: 10}, {value: :K, suite: "\u2666", cost: 10},
    {value: :T, suite: "\u2665", cost: 11}, {value: :T, suite: "\u2663", cost: 11}, {value: :T, suite: "\u2660", cost: 11}, {value: :T, suite: "\u2666", cost: 11},
  ]

  attr_reader :deck

  def initialize
    @deck = []
    recover
  end

  def recover
    @deck.clear
    @deck += DECK
  end

  def issue_card
    @deck.shuffle!
    @deck.delete_at(0)
  end

end