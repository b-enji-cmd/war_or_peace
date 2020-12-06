class Turn
  attr_reader :player1,
              :player2,
              :spoils_of_war

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @spoils_of_war = []
  end

  def start

    puts "Welcome to War! (or Peace) This game will be played with 52 cards.\n"
    puts "The players today are #{@player1.name} and #{@player2.name}.\n"
    puts "Type GO to start the game"
    puts "-"*20

    user_in = gets.chomp
    while user_in != "GO"
      puts "Bad input!, try again"
      user_in = gets.chomp
    end
    count = 0
    until @player1.has_lost? || @player2.has_lost? || count >= 1000000
      turn = type
      round_winner = winner

      if turn == :mutually_assured_destruction
        victor = "No Winner"
      else
        victor = round_winner.name
      end

      if @player1.deck.cards.count == 2 || @player2.deck.cards.count == 2 && turn == :mutually_assured_destruction
        puts "Brutality for: #{victor}!"
      end
      pile_cards
      if @player1.has_lost? || @player2.has_lost?
        p "*~*~*~*~#{victor} Has won the game!*~*~*~*~"
        break
      end

      if turn == :mutually_assured_destruction
        puts "mutually assured destruction, 6 cards removed from play"
      else
        award_spoils(round_winner)
        puts "Turn :#{count}: #{victor} wins #{spoils_of_war.length} cards!"
      end
      puts "~*~* DRAW *~*~" if count >= 1000000
      @spoils_of_war = []
      count+=1

    end
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
    if mutually_assured_destruction?
      "No Winner"
    elsif war?
      calculate_winner(@player1, @player2, 2)
    elsif basic?
      calculate_winner(@player1, @player2, 0)
    end
  end

  def pile_cards
    if mutually_assured_destruction?
      3.times do
        @player1.deck.remove_card
        @player2.deck.remove_card
      end
    elsif war?
      3.times do
        @spoils_of_war << @player1.deck.remove_card
        @spoils_of_war << @player2.deck.remove_card
      end
    elsif basic?
      @spoils_of_war << @player1.deck.remove_card
      @spoils_of_war << @player2.deck.remove_card
    end

  end

  def award_spoils(winner)
    card_take = @spoils_of_war.flatten
    card_take.each do |card|
      winner.deck.add_card(card)
    end
  end
end