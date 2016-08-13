class Player
	SYMBOLS = ["*", "+", "\#", "-", "@", "/"]

	def check_guess(guess, code)
		feedback = []
		to_check = []
		(0...code.size).each do |i|
			to_check[i] = true
		end
		to_check.each_with_index do |check, i|
			if check
				if code[i] == guess[i]
					feedback.push("B") 
					to_check[i] = false
				end
			end
		end
		# to_check is an array the size of the code that indicates wether an index is to check ([false, true, true, true])
		# find all symbols in code that haven't been checked, code[i] hasn't been checked if to_check[i] is true
		values_to_match = []
		code.each_index do |i| 
			if to_check[i]
				values_to_match << code[i]
			end
		end 

		guess.each_with_index do |symbol, i|
			if to_check[i]
				feedback.push("W") if values_to_match.include?(guess[i])
			end
		end

		(0..3).each do |i|
			unless feedback[i]
				feedback[i] = "X"
			end
		end
		
		return feedback
	end

	def is_not_valid(combination, size = 4)
		if combination.size == size
			combination.each do |symbol|
				unless SYMBOLS.include?(symbol)
					return true
				end
			end
		elsif combination.size != size
			return true
		end
		return false
	end

	def human?
		return true
	end

	def codebreak(code, turns)

		score = 0

		turns.times do |turn|

			puts "Turn #{turn + 1}"

			begin
				puts "What's your guess?"
				guess = gets.chomp.split("")
				if is_not_valid(guess)
					raise "Guess is not valid"
				end
			rescue Exception => e
				puts "#{e}, please retry"
				sleep 1
				retry
			end

			feedback = check_guess(guess, code)

			if feedback == ["B", "B", "B", "B"]
				puts "Congratulations, you've cracked the code!"
				score = turns - turn
				puts "Your score is #{score}"
				return score
			else
				feedback.each do |peg|
					if peg == "B"
						print "  #{peg.colorize(:green)}  "
					elsif peg == "W"
						print "  #{peg.colorize(:light_black)}  "
					else
						print "  #{peg.colorize(:red)}  "
					end
				end
				puts "\n"
			end

		end
		puts "The code was : "
		code.each do |symbol|
			print "  #{symbol}  "
		end
		puts "\nYou lose..."
		puts "Your score is #{score}"
		return score
	end

	# when the player is the codemaker
	def create_code

		begin
			code = ""
			puts "Enter your code : "
			code = gets.chomp.split("")
			return code unless is_not_valid(code)
			if is_not_valid(code)
				raise "Code is not valid"
			end
		rescue Exception => e
			puts "#{e}, please retry"
			sleep 1
			retry
		end

	end

end

class AI < Player

	def initialize
		@possibilities = []
		SYMBOLS.each do |i|
			SYMBOLS.each do |j|
				SYMBOLS.each do |k|
					SYMBOLS.each do |l|
						@possibilities.push([i, j, k, l])
					end
				end
			end
		end
	end

	def human?
		return false
	end

	# when the computer is the codebreaker
	def codebreak(code, turns, score = turns)
		guess = []
		while @possibilities.size > 0
			if @possibilities.size == 6**4
				guess = ["*", "*", "+", "+"]
			else
				guess = @possibilities[(@possibilities.size / 2).round]
			end

			puts "The computer guessed :\t#{guess.join("\t")}"
			feedback = check_guess(guess, code)
			feedback.each do |peg|
				if peg == "B"
					print "  #{peg.colorize(:green)}  "
				elsif peg == "W"
					print "  #{peg.colorize(:light_black)}  "
				else
					print "  #{peg.colorize(:red)}  "
				end
			end
			puts "\n"

			if feedback == ["B", "B", "B", "B"]
				puts "The computer guessed the code in #{turns - score + 1} turns!"
				return score
			elsif score == 0
				return 0
			elsif feedback == ["X", "X", "X", "X"]
				guess.each do |symbol|
					@possibilities.reject! { |possible_code| possible_code.include?(symbol) }
				end
				@possibilities.reject! { |possible_code| check_guess(guess, possible_code) != feedback }
			elsif feedback == ["W", "W", "W", "W"]
				guess.each do |symbol|
					@possibilities.reject! { |possible_code| possible_code.none? { |sym| sym == symbol } }
					@possibilities.reject! { |possible_code| check_guess(guess, possible_code) != feedback }
				end
			else
				@possibilities.reject! { |possible_code| check_guess(guess, possible_code) != feedback }
			end
			score -= 1
			puts "Press enter to continue"
			gets
		end

	end

	def create_code(size = 4)
		code = []

		size.times do |i|
			symbol = SYMBOLS[(rand * 5).round]
			code.push(symbol)
		end

		return code
	end
end