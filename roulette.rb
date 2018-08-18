require "pry"

class Stop
  attr_accessor :value, :color
  # A stop is one of slots on the Roulette wheel
  def initialize(value,color)
    @value = value  # int type
    @color = color  # string type
  end  
end

class Flipper
  # a class to generate a number 0 or 1, depending on initial value (0 or 1) and the first call to 'next' will return that value
  def initialize(initial_val)
    @x = initial_val - 1
  end

  def next
    @x += 1
    return @x % 2
  end
end

class Wheel
  attr_accessor :stops, :colors, :dontFlipColor, :flipper
  def initialize
    @colors = %w(Red Black)
    @colorIdx = 0  # The inital index into colors (==> Red initially)
    @dontFlipColor = [10,18,28] # flip color on these indices during creation of the stops
    @flipper = Flipper.new(0)
    @stops = []   # an array of objects of Stop class
    generate_wheel
  end 
  
  def generate_wheel
    36.times do |i| 
      # only flip the color IF the index is NOT in the dontFlipColor
      if !(@dontFlipColor.include? i)
        @colorIdx = flipper.next # on the first iteration, colorIdx is set to 0
        # no else statement needed. colorIdx doesn't change if 'i' is NOT in dontFlipColor
      end 
      @stops << Stop.new(i+1, @colors[@colorIdx])
    end
  end
end

# class Roulette
#   def initialize(person)
#     #  person is the object of the person class that is playing the game
#     @person = person
#   end
w = Wheel.new
# binding.pry
for s in w.stops
  puts "s.value: #{s.value},  s.color: #{s.color}"
end



# end