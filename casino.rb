require_relative 'person'
require_relative 'blackjack'

class Casino

  def initialize
  @person = Person.new
  puts "\nWELCOME TO THE DPL CASINO!!!!"
  puts "\nYour current balance : #{@person.bank}\n\n
          What game do you want to play?"
  end

  def welcome

    puts "\n\t    1) Slots!!\n
            2) High or Low\n
            3) Roulette\n
            4) BlackJack\n
            5) Quit
            "
      case gets.to_i
          when 1
            puts "Slots"
            SlotMachine.new(@person)
          when 2
            puts "High or Low"
            #Enter the code here
          when 3 
            puts "Roulette"
            #Enter the code here
          when 4
            puts "BlackJack"
            BlackJack.new(@person)
          when 5
            puts "GoodBye! See you soon!!"
            exit
          else
            puts "Invalid input. Please select from above."
            welcome
        end
        welcome
  end

end

Casino.new.welcome