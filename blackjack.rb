require_relative 'person'
require_relative 'cardsdeck'
require_relative 'player'
require_relative 'dealer'
require 'colorize'
require 'artii'
#require 'pry'

class BlackJack
  
  
  def initialize(person)
   
    @person = person
    @player = Player.new(@person)
    @dealer = Dealer.new(@person)
    @player_cards = []
    @card_value = 0
    @game = true
    @quit_casino = false
    playerProfile
  end

  def playerProfile
    a = Artii::Base.new 
puts a.asciify('BLACK JACK!')
    @counter = 0
    puts "\nWelcome #{@person.name.capitalize}".colorize(:cyan)
    puts "\nYou have #{@person.bank} in your bank" .colorize(:cyan)
    if @person.bank ==0 
      puts "\nYou should have atleast $10 balance".colorize(:cyan)
      @person.bank = 10.0
    end
     startGame
  end

  def startGame
    @deck = Deck.new
    @bet =0
    puts "\nMinimum Bet: 10".colorize(:cyan)
    puts "\nHow much do you want to bet?".colorize(:cyan)
    @bet = gets.to_i

    if @bet >= 10
        puts "\nDealer deal the cards".colorize(:cyan)
        @player.initialCards
        @dealer.initialCards
        if @player.get_player_cards_value == @dealer.get_dealer_cards_value && @dealer.get_dealer_cards_value ==21
          @deck.list_all_cards(@dealer.dealer_cards)
          puts "\nDealer card values #{@dealer.get_dealer_cards_value}".colorize(:cyan)
          puts "its a PUSH!!!".colorize(:blue)
          ##binding.pry
          @counter += 1
          ##binding.pry
        elsif @player.get_player_cards_value == 21
          puts
          @deck.list_all_cards(@dealer.dealer_cards)
          puts "\nDealer card values #{@dealer.get_dealer_cards_value}"
          @person.bank += (@bet*1.5)
          ##binding.pry
          @player.p_finish = false
          @counter += 1
          ##binding.pry
          puts "\nBLACKJACK for #{@person.name.capitalize}!!\nYour new balance is #{@person.bank}".colorize(:pink)
        elsif @dealer.get_dealer_cards_value == 21
          @deck.list_all_cards(@dealer.dealer_cards)
          puts "\nDealer card values #{@dealer.get_dealer_cards_value}".colorize(:cyan)
          ##binding.pry
          @counter+=1
          ##binding.pry
          @person.bank -= @bet
          puts "\nBLACKJACK for Dealer!!\n Your new balance is #{@person.bank}".colorize(:pink)
          
        else
          #binding.pry
          @counter += @player.playerCardValues(@bet).to_i
          #binding.pry
          if @player.p_finish
            #binding.pry
            @counter += @dealer.dealerCardValues(@bet).to_i
            #binding.pry
            if @player.p_finish && @dealer.d_finish
              continueGame
            end
          end
          
          
        end
        puts "\nNo of games #{@counter}".colorize(:cyan)
          puts "Player Balance :#{@person.bank}".colorize(:cyan)
          if(@counter % 10 == 0 || @person.bank == 0.0)
            puts "\nDo you wanna quit?"
            quit_choice = gets.strip.downcase
              if(quit_choice != 'no')
                puts "\nGoodBye!! See you next time".colorize(:cyan)
                
              else
                startGame
              end
            else
              startGame
            end 
        #puts "\nPlayer Balance :#{@person.bank}".colorize(:cyan)
    else
      puts "\nThe minimum bet is 10. Please place 10 or more.".colorize(:cyan)
    end

  end

  

  def continueGame
    if @player.get_player_cards_value > @dealer.get_dealer_cards_value
      puts "\nYou Won!".colorize(:green)
      @person.bank +=@bet
    elsif @player.get_player_cards_value < @dealer.get_dealer_cards_value && @dealer.get_dealer_cards_value <= 21
      puts "\nYou Lost!".colorize(:red)
      @person.bank -=@bet
    elsif @player.get_player_cards_value == @dealer.get_dealer_cards_value
      puts "\nPUSH!".colorize(:blue)
    end
    ##binding.pry
    @counter = @counter + 1
    ##binding.pry
    
    
  end
  
end
#BlackJack.new(Person.new)