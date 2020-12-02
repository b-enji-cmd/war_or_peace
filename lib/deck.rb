class Deck
  attr_reader :cards

  def initialize(cards)
    @cards = cards
  end

  def rank_of_card_at(arg_index)
    @cards.fetch(arg_index).rank
  end

  def high_ranking_cards
    @cards.find_all do |card|
      card.rank >= 11
    end
  end

  def percentage_high_ranking
    percentage = (high_ranking_cards.count / @cards.count.to_f) *100
    percentage.round(2)
  end
end