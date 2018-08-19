require_relative 'cardsdeck'
require_relative 'generic'
require_relative 'dealer'
#require 'pry'

class Player < Dealer
  attr_accessor :p_finish, :player_cards
  def initialize(person)
    @generic = Generic.new
    @deck = Deck.new
    @cards_deck = @deck.cards
    @player_cards = []
    @player_card_value = 0
    @p_finish = true
    @person = person
  end
  
  def set_player_cards_value(p_value)
    @player_card_value = p_value
  end
  
  def get_player_cards_value
    return @player_card_value 
  end


  def initialCards
    puts "\nPlayer cards are\n"
    @player_cards = [@cards_deck.sample,@cards_deck.sample]
    @deck.list_all_cards(@player_cards)
    set_player_cards_value(@generic.cardsValue(@player_cards).to_i)
    puts "\nPlayer card values #{get_player_cards_value}"
  end

  def playerCardValues(bet)
    p_counter = 0
    hit = true
    while hit == true
      puts "\n#{@person.name}, Do you want to hit or stay"
      choice = gets.strip.downcase=='hit' ? 1 : 0
      if choice == 1
        @player_cards << @cards_deck.sample 
        result_hash = @generic.hitMethod(@player_cards,get_player_cards_value)
        set_player_cards_value(result_hash[:card_val].to_i)
        if !result_hash[:busted]
          @person.bank -=bet
          hit = false
          #binding.pry
          p_counter = 1
          @p_finish =false
          #binding.pry
        end
        puts "Player card values #{get_player_cards_value}"
      else
        hit = false
        @p_finish =true
      end
    end
    return p_counter
  end

end