# require_relative 'cards'
require 'pry'

class Card
  attr_accessor :rank, :suit, :color

  def initialize(rank, suit, color)
    @rank = rank
    @suit = suit
    @color = color
  end
end

class Deck
  attr_accessor :cards

  def initialize
    @ranks = %w(A 2 3 4 5 6 7 8 9 10 J Q K)
    @suits = %w(Spades Diamonds Clubs Hearts)
    @cards = []
    generate_deck
  end

  def generate_deck
    @suits.each do |suit|
      @ranks.size.times do |i|
        color = (suit == 'Spades' || suit == 'Clubs') ? 'Black' : 'Red'
        @cards << Card.new(@ranks[i], suit, color)
      end
    end
    shuffle_cards
  end

  def shuffle_cards
    @shuffle = @cards.shuffle
    list
  end

  def list
    @shuffle.each do |card|
      puts "#{card.rank} of #{card.suit} (#{card.color})"
    end
    random_card = @shuffle.sample
    puts
    puts "Your random card is: #{random_card.rank} of #{random_card.suit} (#{random_card.color})"
    puts
  end
end

d = Deck.new
# puts d.cards