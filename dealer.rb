require_relative 'cardsdeck'
require_relative 'generic'
require 'colorize'
#require 'pry'

class Dealer
  attr_accessor :d_finish, :dealer_cards
  def initialize(person)
    @generic = Generic.new
    @deck = Deck.new
    @cards_deck = @deck.cards
    @dealer_cards = []
    @dealer_card_value = 0
    @d_finish = true
    @person = person
    
  end

  def set_dealer_cards_value(dealer_cards_value)
    @dealer_card_value = dealer_cards_value
  end

  def get_dealer_cards_value
    return @dealer_card_value 
  end

  def initialCards
    puts "\nDealer cards are".colorize(:cyan)
     @dealer_cards = [@cards_deck.sample,@cards_deck.sample]
    
     puts "#{@dealer_cards[0].rank} of #{@dealer_cards[0].suit} (#{@dealer_cards[0].color})\n"
    set_dealer_cards_value(@generic.cardsValue(@dealer_cards).to_i)
    #puts "\nDealer card values #{get_dealer_cards_value}"
  end

  def dealerCardValues(bet)
    d_counter = 0
    puts "Dealer cards:".colorize(:cyan)
    @deck.list_all_cards(@dealer_cards)
    while get_dealer_cards_value < 17
      @dealer_cards << @cards_deck.sample 
      result_hash = @generic.hitMethod(@dealer_cards,get_dealer_cards_value)
      set_dealer_cards_value(result_hash[:card_val].to_i)
      if !result_hash[:busted]
        puts "\nDEALER GOT BUSTED!!".colorize(:red)
        @person.bank +=bet          
          #binding.pry
          @d_finish =false
          d_counter = 1
          #binding.pry
          else
            @d_finish =true
      end
    end
    puts "\nDealer final card value #{get_dealer_cards_value}".colorize(:cyan)
    puts d_counter
    return d_counter
  end

end