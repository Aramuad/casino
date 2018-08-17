class Person
  attr_accessor :bank
  attr_reader :name

  def initialize
    puts "Enter your name:"
    @name = gets.strip
    puts "What is your initial bankroll?"
    @bank = gets.to_f
  end
end

  