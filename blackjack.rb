require "pry"

#1.	Get a deck of card
def initial_deck(deck)
	deck_color=%w(Spade Club Heart Square)
	rank_point=%w(Ace 2 3 4 5 6 7 8 9 10 Jack Queen King)

	deck_color.each{|color|
		rank_point.each(){|point| deck.push [color,point,"Muck"]}
	}
end

def calculate(cards)
		points=0
		ace_count=0
		cards.each(){|card|
			if card[2]=="Show"   #For show card only
				if card[1]=="King"||card[1]=="Queen"||card[1]=="Jack"
					points=points+10
				elsif card[1]=="Ace"
					points=points+11
					ace_count=ace_count+1
				else
					points=card[1].to_i+points
				end
			end
		}  # calculate points

		ace_count.times {
			if points>21
				points=points-10
			end
			}

		points # return points 
end

def deal_to_player(player_hand,deck)
  card=deck.pop
  card[2]="Show"
  player_hand.push card
end

def deal_to_house(house_hand,deck)
  card=deck.pop
  house_hand.push card
end

def main()
	#1.	Get a deck of card
	system("clear")
	deck=Array.new
	player_hand=[] ; house_hand=[]
	result=nil

	#2.  Shuffle the card
	initial_deck(deck)
	deck.shuffle!

	#3.  Deal the 2 card to Player   card-Show	
	2.times {deal_to_player(player_hand,deck)} 

	#4.	Deal 2 cards to House , one muck and one show
	2.times { deal_to_house(house_hand,deck) }
	house_hand[1][2]="Show"

	#Show the cards to user in front of monitoe 
	player_hand.each{|card|p "You have card #{card[0]} #{card[1]}"}
	p "House have #{house_hand[1][0]} #{house_hand[1][1]}"

	begin  # keep asking player for new card 
		player_points=0 ; player_points=calculate(player_hand)
		house_points=0 ; house_points=calculate(house_hand)
		
		p "House get #{house_points}"
		p "You get #{player_points}"

		p "You wanna more card? Enter 'y' for new card "
		answer=gets.chomp
		if answer=="Y" or answer=="y" # deal a new card 
			card=deck.pop
			card[2]="Show"
			player_hand.push card
			p " "
			p "You just receive a card #{card[0]} #{card[1]}"
			player_points=calculate(player_hand)
			
			if player_points>21 # Break if > 21 busted 
				result="Lose"
				p "Busted~!"
				break #no More new cards
			end
		end # End of dealing a new card    
	end until answer=="n" #begin end loop    END of ask player for new card

#==================================
# Dealing the HOUSE new cards until reach 17
	house_hand[0][2]="Show" # Turn over House's muck card
	house_points=calculate(house_hand)
	p "House turn over the muck card to #{house_hand[0][0]} #{house_hand[0][1]}"
	p "The new House hand point is #{house_points}"
	
	if house_points<17 && result!="Lose" # only if House <17 and player is not busted
		begin
			p "Dealing new card to the House"
			card=deck.pop
			card[2]="Show"
			house_hand.push card 
			p "Thw House received a #{card[0]} #{card[1]}"
			house_points=calculate(house_hand)
			p "The new House hand point is #{house_points}"
			if house_points>21 
				result="Win"
				p "House busted"
				break
			end
		end until house_points>17
	end

	# Calculate the win or lose
	if player_points>house_points && player_points<22
		result="Win"
	elsif player_points==house_points
		result="Draw"
	elsif (player_points<house_points)&&result!="Win"
		result="Lose"
	end

	case result
	when "Win" 
		p "Player Win"
	when "Draw"
		p "Draw"
	when "Lose"
		p "Player Lose"
	end
	p "=============================="

end # end of main
#===============================================

system("clear")
answer="y"
begin
	main
	p "U wanan play again ? Enter 'n' to exit "
	answer=gets.chomp
end until answer=="n" or answer=="no"