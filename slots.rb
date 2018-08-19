
class SlotMachine
  attr_accessor :column1
  attr_accessor :slot_roll
  

  def initialize
    @column1 = %w(rainbow cherry cherry pizza pizza pizza poop)
    @slot_roll = []
    @bank = 10
    pay_to_play
  end

  def pay_to_play
    puts 'Welcome to the slot machine! It costs $10 to play!'
    puts "\u{1f308}"
    @bank -= 10
    shuffle_slots
  end

  def shuffle_slots
   @shuffle = @column1.shuffle
   generate_slots
  end

  def generate_slots
    3.times { @slot_roll << @column1.sample }
    final_results
  end

  def final_results
    puts 'Spinning...'
    print @slot_roll
    count_method
  end


  def count_method
    rainbowcount = 0
    cherrycount = 0
    pizzacount = 0
    poopcount = 0
    @slot_roll.each do |picture|
    case picture
    when "rainbow"
      rainbowcount = rainbowcount + 1
      rainbow_method(rainbowcount)
    when "cherry"
      cherrycount += 1
      cherry_method(cherrycount)
    when "pizza"
      pizzacount += 1
      pizza_method(pizzacount)
    when "poop"
      poopcount
      poop_method(poopcount)
    end
  end
  end

  def rainbow_method(rainbowcount)
    if rainbowcount == 3
      @bank += 1000
      puts 'You are a WINNER!! +$1000!!'
    elsif rainbowcount == 2
      @bank += 250
      puts 'You win $250!'
    end
    @bank = @bank
  end

  def cherry_method(cherrycount)
    if cherrycount == 3
      @bank += 500
      puts 'You win $500!'
    elsif cherrycount == 2
      @bank += 125
      puts 'You win $125!'
    end
  end

  def pizza_method(pizzacount)
    if pizzacount == 3
      puts 'You win $250!'
      @bank += 250
    elsif pizzacount == 2
      puts 'You win $75!'
      @bank += 75
    end
  end

  def poop_method(poopcount)
    if poopcount == 3
      puts "You Loose!"
    elsif poopcount == 2
      puts "You Loose!"
    end
  end

  def add_money
    #pass back to main menu
  end
end


slotmachine = SlotMachine.new
#get rid of to run once menu is running
