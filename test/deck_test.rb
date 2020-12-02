require 'minitest/autorun'
require 'minitest/pride'
require './lib/card'
require './lib/deck'
require 'pry'

class DeckTest < Minitest::Test
  def setup
    @card1 = Card.new(:diamond, 'Queen', 12)
    @card2 = Card.new(:spade, '3', 3)
    @card3 = Card.new(:heart, 'Ace', 14)
    cards = [@card1,@card2,@card3]
    @deck = Deck.new(cards)
  end

  def test_it_exists
    assert_instance_of Deck, @deck
  end

  def test_it_can_see_cards
    cards = [@card1,@card2,@card3]
    assert_equal cards , @deck.cards
  end

  def test_it_can_index_card_rank
    assert_equal 12 , @deck.rank_of_card_at(0)
    assert_equal 14 , @deck.rank_of_card_at(2)
  end

  def test_it_can_return_high_ranking_cards
    assert_equal [@card1,@card3], @deck.high_ranking_cards
  end

  def test_it_can_return_percentage_of_high_ranking_cards
    assert_equal 66.67 , @deck.percentage_high_ranking
  end

  def test_it_can_remove_cards
    assert_equal @card1, @deck.remove_card
  end

  def test_it_can_still_calculate_percentage_after_removal
    @deck.remove_card
    assert_equal [@card3], @deck.high_ranking_cards
    assert_equal [@card2, @card3], @deck.cards
    assert_equal 50.0, @deck.percentage_high_ranking
  end

  def test_it_can_add_new_cards
    card4 = Card.new(:club, '5', 5)
    @deck.add_card(card4)
    assert_equal [@card2,@card3,card4], @deck.cards
  end
end