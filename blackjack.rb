require_relative 'person'
require_relative 'cardsdeck'
require_relative 'player'
require_relative 'dealer'
#require 'pry'

class BlackJack

  
  def initialize(person)
    @deck = Deck.new
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
    @counter = 0
    puts "\nWelcome #{@person.name}"
    puts "\nYou have #{@person.bank} in your bank" 
    if @person.bank ==0 
      puts "\nYou should have atleast $10 balance"
      @person.bank = 10.0
    end
     startGame
  end

  def startGame
    
    @bet =0
    puts "\nMinimum Bet: 10"
    puts "\nHow much do you want to bet?"
    @bet = gets.to_i

    if @bet >= 10
        puts "\nDealer deal the cards"
        @player.initialCards
        @dealer.initialCards
        if @player.get_player_cards_value == @dealer.get_dealer_cards_value && @dealer.get_dealer_cards_value ==21
          @deck.list_all_cards(@dealer.dealer_cards)
          puts "\nDealer card values #{@dealer.get_dealer_cards_value}"
          puts "its a PUSH!!!"
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
          puts "\nBLACKJACK for #{@person.name}!!\nYour new balance is #{@person.bank}"
        elsif @dealer.get_dealer_cards_value == 21
          @deck.list_all_cards(@dealer.dealer_cards)
          puts "\nDealer card values #{@dealer.get_dealer_cards_value}"
          ##binding.pry
          @counter+=1
          ##binding.pry
          @person.bank -= @bet
          puts "\nBLACKJACK for Dealer!!\n Your new balance is #{@person.bank}"
          
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
        puts "\nNo of games #{@counter}"
          puts "Player Balance :#{@person.bank}"
          if(@counter % 10 == 0 || @person.bank == 0.0)
            puts "\nDo you wanna quit?"
            quit_choice = gets.strip.downcase
              if(quit_choice != 'no')
                puts "\nGoodBye!! See you next time"
                
              else
                startGame
              end
            else
              startGame
            end 
        puts "\nPlayer Balance :#{@person.bank}"
    else
      puts "\nThe minimum bet is 10. Please place 10 or more."
    end

  end

  

  def continueGame
    if @player.get_player_cards_value > @dealer.get_dealer_cards_value
      puts "\nYou Won!"
      @person.bank +=@bet
    elsif @player.get_player_cards_value < @dealer.get_dealer_cards_value && @dealer.get_dealer_cards_value <= 21
      puts "\nYou Lost!"
      @person.bank -=@bet
    elsif @player.get_player_cards_value == @dealer.get_dealer_cards_value
      puts "\nPUSH!"
    end
    ##binding.pry
    @counter = @counter + 1
    ##binding.pry
    
    
  end
  
end
#BlackJack.new