require "pry"
require "colorize"


class Stop
  attr_accessor :value, :color
  # A stop is one of slots on the Roulette wheel
  def initialize(value,color)
    @value = value  # int type
    @color = color  # string type
  end  
end

class Flipper
  # a class to generate a number 0 or 1, depending on initial value (0 or 1) and the first call to 'next' will return that initial value, but the next calls to "next" will returned the other value
  def initialize(initial_val)
    @x = initial_val - 1
  end

  def next
    @x += 1
    return @x % 2
  end
end

class Wheel
  attr_accessor :stops
  def initialize
    @colors = %w(Red Black)
    @colorIdx = 0  # The inital index into colors (==> Red initially)
    @dontFlipColor = [10,18,28] # dont flip color on these indices during creation of the stops
    @flipper = Flipper.new(0)
    @stops = []   # an array of objects of Stop class
    generate_wheel
  end 
  
  def generate_wheel
    36.times do |i| 
      # only flip the color IF the index is NOT in the dontFlipColor
      if !(@dontFlipColor.include? i)
        @colorIdx = @flipper.next # on the first iteration, colorIdx is set to 0
        # no else statement needed. colorIdx doesn't change if 'i' is NOT in dontFlipColor
      end 
      @stops << Stop.new(i+1, @colors[@colorIdx])
    end
    @stops << Stop.new(0,"Green") << Stop.new(0,"Green")
  end
end


class Roulette

  def initialize(person)
    @person = person
    @wheel = Wheel.new
    take_bet
  end

  def show_menu
    puts "
    \t**************************************************************************
    \t*******                  WELCOME TO ROULLETE GAME                  *******
    \t**************************************************************************"
    puts "\n\tBets to choose from:\n\tSingle Stops:"
    for i in 1..36
      if i % 6 == 1
        print "\t"
      end
      print "#{i} \t "
      if i % 6 == 0 
        puts "\n"
      end
    end
    puts "
    \tCombination Stops:
    \t37. 1st 12 (1-12) \t 38. 2nd 12 (13:24) \t 39. 3rd 12 (25-36)
    \t40. 1st 18 (1-18) \t 41. 2nd 18 (19-36)
    \t42. Even \t\t 43. Odd
    \t44. Red \t\t 45. Black
    "   
  end

  def take_bet
    wanna_play = true
    while wanna_play
      @betStops = []
      @betAmnt = 0
      @odds = 0

      while true
        show_menu
        puts "\tPlease select a choice from above (enter number) followed by a space, and then your desired bet amount:"
        @bet = gets.split.map(&:to_i)
        
        if @bet.size % 2 != 0
          # puts "\n\tError! Wrong number of inputs, try again!\n".colorize(:color => :red, :background => :white) # works
          puts "\n\n\tError! Wrong number of inputs, try again!\n".colorize(color: :red, background: :white)
          # puts "\n\tError! Wrong number of inputs, try again!\n".red
          next # Goes to the next iteration of the while loop (starting over)
        end

        if @bet.empty? 
          puts "\n\n\tError! Must make a bet!".colorize(color: :red, background: :white)
          next # Goes to the next iteration of the while loop (starting over)
        end
        
        if @bet[1].to_i <= @person.bank
          @betAmnt = @bet[1].to_i
        else
          puts "\n\n\tError! You cannot bet More than you have in your bank. Your bank amount is $#{@person.bank}.Try again!\n".colorize(color: :red, background: :white)
          next # Goes to the next iteration of the while loop (starting over)
        end

        # binding.pry
        # puts "@betAmnt = #{@betAmnt}"
        # puts "@bet[0] = #{@bet[0]}"
        if @bet[0] <= 36 && @bet[0]>0
          @betStops << @wheel.stops[@bet[0]-1]
        elsif @bet[0] >= 37 && @bet[0] <= 45
          puts "here!!!"
          case @bet[0]
          when 37 # 1st 12
            @betStops = @wheel.stops[0..11]
            # binding.pry
          when 38 # 2nd 12
            @betStops = @wheel.stops[12..23]
          when 39 # 3rd 12
            @betStops = @wheel.stops[24..35]
          when 40 # 1st 18
            @betStops = @wheel.stops[0..17]
          when 41 # 2nd 18
            @betStops = @wheel.stops[18..35]
          when 42 # Even
            @wheel.stops[0..35].each do |s|
              if s.value % 2 == 0
                @betStops << s
              end            
            end
          when 43 # odd
            @wheel.stops[0..35].each do |s|
              if s.value % 2 == 1
                @betStops << s
              end            
            end
          when 44 # Red
            @wheel.stops[0..35].each do |s|
              if s.color == 'Red'
                @betStops << s
              end            
            end
          when 45 # Black
            @wheel.stops[0..35].each do |s|
              if s.color == 'Black'
                @betStops << s
              end            
            end
          end
        else
          puts "\n\n\tError! The chosen bet must be a value between 1 and 45. Try again!\n".colorize(color: :red, background: :white)
          next  # Go to the next iteration of the while loop, starting over
        end 

        # binding.pry   

        # if we get here we didn't have an error so break
        break

      end # end of while statement

      
      
      @odds = @betStops.size/ 36.0 # number of elements in the selected Stops / number of NON-green stops in the wheel
      puts "size of @betStops: #{@betStops.size}"
      puts "@odds= #{@odds}"
      process_bet(spin_wheel)

      while true
        puts "\tDo you want to play again? press 'y' for YES or 'n' for No"
        play_again = gets.strip.downcase
        # puts "playagain=#{play_again}" 
        case play_again       
        when 'n'
          wanna_play = false
          break
        when 'y' # do nothing. Repeats the external loop. But exit this loop
          break
        else
          print "\n\n\tError! Invalid response".colorize(color: :red, background: :white)
        end
      end

    end 

  end # end of take_bet
  

  def spin_wheel
    return @wheel.stops.sample
  end
  
  def process_bet(the_stop)
    # the_stop is the stop we land on after spinning the wheel
    colors = [:red,   :blue,   :green, :pink,   :magenta, :cyan,]
    bg     = [:green, :yellow, :red,   :yellow, :white,   :yellow]
    colors.size.times do |i|
       puts "\tSpinning".colorize(color: colors[i], background: bg[i])
       sleep(0.5)
    end
    puts "\n\n\t~~~~~~~~~~~~      The ball landed on: #{the_stop.value}, #{the_stop.color}      ~~~~~~~~~~~~"
    if @betStops.include? the_stop
      puts "\n\n\t**********    YOU WON!    ***********\n\n".colorize(:green)
      winAmnt = @betAmnt/@odds
      puts "\tBalace before the game: $#{@person.bank} - Bet amount: $#{@betAmnt} + Earned amount: $#{winAmnt}"
      @person.bank += winAmnt
    else
      puts "\n\n\t**********    YOU LOST!  ***********\n\n".colorize(:red)
      puts "\tBalace before the game: $#{@person.bank} - Bet amount: $#{@betAmnt}"
      @person.bank -= @betAmnt
    end
    puts "\tTotal: $#{@person.bank}"
  end


end




# class Roulette
#   def initialize(person)
#     #  person is the object of the person class that is playing the game
#     @person = person
#   end
# w = Wheel.new
# # binding.pry
# for s in w.stops
#   puts "s.value: #{s.value},  s.color: #{s.color}"
# end


# # For testing purposes, created a Person Class
# class Person
#   attr_accessor :bank
#   def initialize
#     @bank = 100
#   end
# end

# # FOr testing
# person = Person.new
# game = Roulette.new(person)


# end