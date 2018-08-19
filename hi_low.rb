
# deals player a card
# player bets whether next card will be higher or lower than current card
# card dealt is compared to previous card
# card equality/inequality is compared to player's bet

require 'pry'

require_relative 'main.rb'

def greeting
  puts
  puts "*-" * 10
  puts "Let's play High/Low"
  puts "*-" * 10
  puts
  puts "Press 'Enter' to recieve your first card!"
  first_card
end

class High_low
  attr_accessor :rank, :suit

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
    end
  def deal_card
    d = Deck.new
    end
  def first_card
    gets
    @hand = [].sort
    @hand << @deck.cards.sample
    @hand[0] do |card|
      puts "-" * 14
      puts "#{card.rank}, of #{card.suit}"
      puts "-" * 14
    end
    puts
    puts "What is your call: higher or lower?"
    choice = gets.strip
    second_card
    case choice
    when higher
      if @hand[0] > @hand[1]
        puts "You win!"
       end
      if @hand[0] < @hand[1]
        puts "Better luck next time..."
       end
    when lower
      if @hand[0] < @hand[1]
        puts "You win!"
       end
      if @hand[0] > @hand[1]
        puts "Better luck next time..."
       end
      elsif
        puts "Invalid choice, please enter 'higher' or 'lower'"
        choice
      end
  def second_card
    puts "Press 'Enter' to recieve your second card!"
    gets
    @hand = []
    @hand << @deck.cards.sample
    @hand[1] do |card|
    puts "-" * 14
    puts "#{card.rank}, of #{card.suit}"
    puts "-" * 14
      end
    end
  end

@deck = Deck.new
greeting