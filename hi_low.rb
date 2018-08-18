
# deals player a card
# player bets whether next card will be higher or lower than current card
# card dealt is compared to previous card
# card equality/inequality is compared to player's bet

require 'pry'

require_relative 'test_1.rb'

def greeting
  puts
  puts "*-" * 10
  puts "Let's play High/Low"
  puts "*-" * 10
  puts
  puts "Press 'Enter' to recieve your first card!"
  binding.pry
  first_card
end

  def first_card
  gets
  @hand = []
  @hand << @deck.cards.sample
  @hand.each do |card|
    puts "-" * 14
    puts "#{card.rank}, of #{card.suit}"
    puts "-" * 14
  end
  puts
  puts "What is your call: higher or lower?"
  choice = gets.strip
  case choice
    when higher
      if @hand(0) > @hand(1)
        then puts "You win!"
      if @hand(0) < @hand(1)
      puts "Better luck next time..."
    when lower
      if @hand(0) < @hand(1)
        then puts "You win!"
      if @hand(0) > @hand(1)
        then puts "Better luck next time..."
      else
        puts "Invalid choice, please enter 'higher' or 'lower'"
      end
  second_card
end

def second_card
  puts "Press 'Enter' to recieve your second card!"
  gets
  @hand = []
  @hand << @deck.cards.sample
  @hand.each do |card|
    puts "-" * 14
    puts "#{card.rank}, of #{card.suit}"
    puts "-" * 14
  end
end

def deal_card
  d = Deck.new
end

@deck = Deck.new
greeting