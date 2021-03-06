require './lib/mastermind'
require './lib/player'

mastermind = MasterMind.new

again = true

while again

	puts `clear`
	puts "Let's play mastermind!".center(80, "-")
	print "\n"

	puts "Choose the game mode"
	puts "1. Codebreaker : Crack the code generated by the computer"
	puts "2. Codemaker : Make a code and see if the computer can guess it"
	mode = gets.chomp.downcase

	if mode == "1" || mode == "codebreaker"
		codebreaker = Player.new
		codemaker = AI.new
	else
		codebreaker = AI.new
		codemaker = Player.new
	end

	turns = 12

	mastermind.play(turns, codebreaker, codemaker)

	puts "Do you want to play again? (y/n)"
	continue = gets.chomp.downcase
	unless continue == "y"
		again = false
	end

end