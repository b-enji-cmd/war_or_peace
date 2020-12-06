require './lib/card'
require './lib/deck'
require './lib/player'
require './lib/turn'
require 'minitest/autorun'
require 'pry'

class TurnTest < Minitest::Test
  def setup
    @card1 = Card.new(:heart, 'Jack', 11)
    @card2 = Card.new(:heart, '10', 10)
    @card3 = Card.new(:heart, '9', 9)
    @card4 = Card.new(:diamond, 'Jack', 11)
    @card5 = Card.new(:heart, '8', 8)
    @card6 = Card.new(:diamond, 'Queen', 12)
    @card7 = Card.new(:heart, '3', 3)
    @card8 = Card.new(:diamond, '2', 2)
    @testing_deck = [@card1,@card2,@card3,@card4,@card5,@card6,@card7,@card8]
    @deck1 = Deck.new([@card1, @card2, @card5, @card8])
    @deck2 = Deck.new([@card3, @card4, @card6, @card7])
    @player1 = Player.new("Megan", @deck1)
    @player2 = Player.new("Aurora", @deck2)
    @turn = Turn.new(@player1, @player2)
  end

  def test_it_is
    assert_instance_of Turn, @turn
  end

  def test_it_has_things
    assert_equal @player1, @turn.player1
    assert_equal @player2, @turn.player2
    assert_equal [], @turn.spoils_of_war
  end

  def test_it_has_turn_type
    assert_equal :basic, @turn.type
  end

  def test_turn_type_war
    deck1 = Deck.new([@card1, @card2, @card5, @card8])
    deck2 = Deck.new([@card4, @card3, @card6, @card7])
    player1 = Player.new("Megan", deck1)
    player2 = Player.new("Aurora", deck2)
    turn = Turn.new(player1, player2)
    assert_equal :war, turn.type
    assert_equal true, turn.war?
  end

  def test_turn_type_mutual
    card6 = Card.new(:diamond, '8', 8)
    deck1 = Deck.new([@card1, @card2, @card5, @card8])
    deck2 = Deck.new([@card4, @card3, card6, @card7])
    player1 = Player.new("Megan", deck1)
    player2 = Player.new("Aurora", deck2)
    turn = Turn.new(player1, player2)
    assert_equal :mutually_assured_destruction, turn.type
    assert_equal true, turn.mutually_assured_destruction?
  end

  def test_there_can_be_a_winner
    winner = @turn.winner
    assert_equal @player1, winner
  end

  def test_it_can_congregate_spoils_of_war
    @turn.pile_cards
    assert_equal [@card1, @card3], @turn.spoils_of_war
  end

  def test_it_can_award_spoils_for_basic
    winner = @turn.winner
    @turn.pile_cards
    @turn.spoils_of_war
    @turn.award_spoils(winner)
    assert_equal [@card2,@card5,@card8,@card1,@card3], @player1.deck.cards
    assert_equal [@card4,@card6,@card7], @player2.deck.cards
  end

  def test_it_can_award_spoils_for_war
    deck1 = Deck.new([@card1, @card2, @card5, @card8])
    deck2 = Deck.new([@card4, @card3, @card6, @card7])
    player1 = Player.new("Megan", deck1)
    player2 = Player.new("Aurora", deck2)
    turn = Turn.new(player1, player2)
    winner = turn.winner
    turn.pile_cards
    turn.award_spoils(winner)

    assert_equal [@card8],player1.deck.cards
    assert_equal [@card7, @card1,@card4,@card2,@card3,@card5,@card6], player2.deck.cards

  end
  def test_it_can_award_spoils_for_mutual
    card6 = Card.new(:diamond, '8', 8)
    deck1 = Deck.new([@card1, @card2, @card5, @card8])
    deck2 = Deck.new([@card4, @card3, card6, @card7])
    player1 = Player.new("Megan", deck1)
    player2 = Player.new("Aurora", deck2)
    turn = Turn.new(player1, player2)
    winner = turn.winner
    assert_equal "No Winner", winner
    assert_equal [], turn.spoils_of_war
  end

  def test_pile_cards_mutual
    card6 = Card.new(:diamond, '8', 8)
    deck1 = Deck.new([@card1, @card2, @card5, @card8])
    deck2 = Deck.new([@card4, @card3, card6, @card7])
    player1 = Player.new("Megan", deck1)
    player2 = Player.new("Aurora", deck2)
    turn = Turn.new(player1, player2)
    winner = turn.winner
    assert turn.pile_cards #making sure it doesnt return false or nil
  end

  def test_pile_cards_war
    deck1 = Deck.new([@card1, @card2, @card5, @card8])
    deck2 = Deck.new([@card4, @card3, @card6, @card7])
    player1 = Player.new("Megan", deck1)
    player2 = Player.new("Aurora", deck2)
    turn = Turn.new(player1, player2)
    winner = turn.winner
    assert turn.pile_cards #making sure it doesnt return false or nil
  end
end