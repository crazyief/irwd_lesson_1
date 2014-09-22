require "pry"
=begin
1.	Get a deck of card
2.  Shuffle the card

3.  Deal the card to Player   card-visable
3.  Deal the card to Player		card-visable

4.	Deal the card to House 		card-visable
4.	Deal the card to House 		card-invisable
6. check the House points 

5. 	Ask does the player wanna more card

		5.	Calculate the card points - player
				Calculate the card points - 
		6. 	Ask does the player wanna more card
		loop.....


6. 	Deal the card to House 	card-visable  (until reach 17 , exit if bust)
7.	Match the House and Player , decide the winner 
=end

#1.	Get a deck of card
def initial_deck(deck)
	deck_color=["Spade","Club","Heart","Square"]
	rank_point=["Ace","2","3","4","5","6","7","8","9","10","Jack","Queen","King"]

	deck_color.each{|color|
		rank_point.each(){|point|
			deck.push [color,point,"Muck"]}
	}
end

def calculate(cards)
		points=0
		cards.each(){|card|
			if card[2]=="Show"   #For show card only
				if card[1]=="King"||card[1]=="Queen"||card[1]=="Jack"
					points=points+10
				elsif card[1]=="Ace"
					points=points+1
				else
					points=card[1].to_i+points
				end
			end
			}  # calculate points
		points # return points 
end


def main()
	#1.	Get a deck of card
	#system("clear")
	deck=Array.new
	initial_deck(deck)

	#2.  Shuffle the card
	deck.shuffle!

	#3.  Deal the 2 card to Player   card-Show
	#    and turn over the card
	player_hand=[]
	player_hand.push deck.pop
	player_hand.push deck.pop
	player_hand.each{|card|card[2]="Show"}

	#4.	Deal 2 cards to House , one muck and one show
	house_hand=[]
	house_hand.push deck.pop
	house_hand.push deck.pop
	house_hand[1][2]="Show"

	#Show the cards to user in front of monitoe 
	player_hand.each{|card|
		p "You have card #{card[0]} #{card[1]}"
	}



=begin
5. 	Ask does the player wanna more card

		5.	Calculate the card points - player
				Calculate the card points - 
		6. 	Ask does the player wanna more card
		loop.....
=end
	begin  # keep asking player for new card 
		player_points=0 ; player_points=calculate(player_hand)
		house_points=0	;	house_points=calculate(house_hand)
		
		p "House get #{house_points}"
		p "You get #{player_points}"

		p "You wanna more card?"
		answer=gets.chomp
		if answer=="Y" or answer=="y" # deal a new card 
			card=deck.pop
			card[2]="Show"
			player_hand.push card
			p "You just receive a card #{card[0]}#{card[1]}"
			player_points=calculate(player_hand)
			
			if player_points>21 # Break if > 21 busted 
				p "Busted~!"
				break
			end
		end # End of dealing a new card 

	end until answer=="n" #begin end loop 


	house_hand[0][2]="Show" # Turn over House's muck card
	house_points=calculate(house_hand)
	p "The new House hand point is #{house_points}"

#==================================
# TO be insesrt new code 

#==================


	# Calculate the win or lose
	if player_points>house_points && player_points<22
		result="Win"
		p "Player win "
	elsif player_points==house_points
		result="Draw"
		p "This is draw"
	else
		result="Lose"
		p "Player lose"
	end
	p "=============================="




	

end # end of main

system("clear")
loop do
	main
end