require_relative 'cards'
class Deck
 # Getter and Setter methods for rank, suit and color
  attr_accessor :cards

  # Gets called when you call the new method to create an instance
  # deck = Deck.new
  def initialize
    @ranks = %w(A 2 3 4 5 6 7 8 9 10 J Q K)
    @suits = %w(Spades Diamonds Clubs Hearts)
    @cards = []
    generate_deck
  end

  def shuffle_cards
    @cards.shuffle
    #list_all_cards
  end
  
  def generate_deck
    @suits.each do |suit|
      @ranks.size.times do |i|
        # Ternary Operator
        color = (suit == 'Spades' || suit == 'Clubs') ? 'Black' : 'Red' 
        @cards << Card.new(@ranks[i], suit, color)
      end
    end
    shuffle_cards
  end
  
  def list_all_cards
    @cards.each do |card| 
      puts "#{card.rank} of #{card.suit} (#{card.color})"
    end
  end
end
#Deck.new
