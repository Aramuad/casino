require_relative 'cardsdeck'

class Generic
  def initialize
    @deck = Deck.new
  end

  def cardsValue(card_arr)
    card_value = 0
    value = 0
    if card_arr[0].rank == "A" && card_arr[1] == "A"
      card_value =2
    else
      card_arr.each do |card|
          if ["K","Q","J"].include? card.rank
              value = 10
          elsif card.rank.eql? "A"
            # @working_arr = @player_cards.clone
            # card.rank = aceMethod(card_arr)
            value = 11
            if card_value.between?(11,20) || card_value.between?(1,6)
              value = 1
            end
          else
            value = card.rank
          end
          card_value += value.to_i
      end
    end
    card_value
  end

  def hitMethod(arr,value)
    result ={}
    puts 
    @deck.list_all_cards(arr)
    value = cardsValue(arr)
    if value > 21
      
      return {card_val:value,busted:false}
    else
      return {card_val:value,busted:true}
    end
  end
end