require './lib/card'
require './lib/deck'
require './lib/player'
require './lib/turn'
require 'pry'
@card1 = Card.new(:heart, 'Jack', 11)
@card2 = Card.new(:heart, '10', 10)
@card3 = Card.new(:heart, '9', 9)
@card4 = Card.new(:diamond, 'Jack', 11)
@card5 = Card.new(:heart, '8', 8)
@card6 = Card.new(:diamond, 'Queen', 12)
@card7 = Card.new(:heart, '3', 3)
@card8 = Card.new(:diamond, '2', 2)


suits = [:heart, :diamond, :spade, :club]
card_details = {
    '2' => 2,
    '3' => 3,
    '4' => 4,
    '5' => 5,
    '6' => 6,
    '7' => 7,
    '8' => 8,
    '9' => 9,
    '10' => 10,
    'Jack' => 11,
    'Queen' => 12,
    'King' => 13,
    'Ace' => 14
}

global_deck = []
suits.each do |suit|
  card_details.each do |key,value|
    global_deck << Card.new(suit,key,value)
  end
end

player_one_deck = [global_deck[0..25]].flatten
player_two_deck = [global_deck[26..51]].flatten
@deck1 = Deck.new(player_one_deck.shuffle)
@deck2 = Deck.new(player_two_deck.shuffle)

@player1 = Player.new("Megan", @deck1)
@player2 = Player.new("Aurora", @deck2)
@turn = Turn.new(@player1, @player2)



@turn.start