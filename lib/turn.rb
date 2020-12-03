class Turn
    attr_reader :player1, 
                :player2, 
                :spoils_of_war

    def initialize(player1,player2)
        @player1 = player1
        @player2 = player2
        @spoils_of_war = []
    end

    def type
       if ((@player1.deck.rank_of_card_at(0) == @player2.deck.rank_of_card_at(0))  &&  @player1.deck.rank_of_card_at(2) == @player2.deck.rank_of_card_at(2))
        :mutually_assured_destruction
       elsif @player1.deck.rank_of_card_at(0) == @player2.deck.rank_of_card_at(0)
        :war
       else @player1.deck.rank_of_card_at(0) != @player2.deck.rank_of_card_at(0)
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
            calculate_winner(@player1,@player2, 0)
        when :war
            calculate_winner(@player1,@player2, 2)
        when :mutually_assured_destruction
            "No Winner"
        else
            "Something went wrong!"
        end
    end
end