class Turn
  attr_reader :player1,
              :player2,
              :spoils_of_war

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @spoils_of_war = []
  end

  def mutually_assured_destruction?
    @player1.deck.rank_of_card_at(0) == @player2.deck.rank_of_card_at(0) &&
      @player1.deck.rank_of_card_at(2) == @player2.deck.rank_of_card_at(2)
  end

  def war?
    @player1.deck.rank_of_card_at(0) == @player2.deck.rank_of_card_at(0)
  end

  def basic?
    @player1.deck.rank_of_card_at(0) != @player2.deck.rank_of_card_at(0)
  end

  def type
    if mutually_assured_destruction?
      :mutually_assured_destruction
    elsif war?
      :war
    elsif basic?
      :basic
    end
  end

  def calculate_winner(player1, player2, card_index)
    if player1.deck.rank_of_card_at(card_index) < player2.deck.rank_of_card_at(card_index)
      player2
    else
      player1
    end
  end

  def winner
    victor = type
    case victor
    when :basic
      calculate_winner(@player1, @player2, 0)
    when :war
      calculate_winner(@player1, @player2, 2)
    when :mutually_assured_destruction
      "No Winner"
    else
      "Something went wrong!"
    end
  end

  def pile_cards
    cards = type
    case cards
    when :basic
      @spoils_of_war << @player1.deck.cards.shift
      @spoils_of_war << @player2.deck.cards.shift
    when :war
      @spoils_of_war << @player1.deck.cards.shift(3)
      @spoils_of_war << @player2.deck.cards.shift(3)
    when :mutually_assured_destruction
      @player1.deck.cards.shift(3)
      @player2.deck.cards.shift(3)
    else
      "Something went wrong!"
    end
  end
end