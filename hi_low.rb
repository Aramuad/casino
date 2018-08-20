
# deals player a card
# player bets whether next card will be higher or lower than current card
# card dealt is compared to previous card
# card equality/inequality is compared to player's bet

require 'pry'

# require_relative 'main.rb'

class High_low
  attr_accessor :rank, :suit

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end
  
  def greeting
    puts
    puts "*-" * 10
    puts "Let's play High/Low"
    puts "*-" * 10
    puts
    puts "Press 'Enter' to recieve your first card!"
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

  def call 
    puts
    puts "What is your call: higher or lower?"
    choice = gets.strip
    second_card
    case High_low.new
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
      elsif
       puts "Invalid choice, please enter 'higher' or 'lower'"
       choice
    end
  end

  def second_card
    puts "Press 'Enter' to recieve your second card!"
    gets
    @hand = [].sort
    @hand << @deck.cards.sample
    @hand[1] do |card|
    puts "-" * 14
    puts "#{card.rank}, of #{card.suit}"
    puts "-" * 14
    end
  end
end

High_low.new
@deck = Deck.new