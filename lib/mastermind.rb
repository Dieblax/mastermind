class MasterMind
	SYMBOLS = ["*", "+", "\#", "-", "@", "/"]

	def create_code(size = 4)
		@code = []

		size.times do |i|
			symbol = SYMBOLS[(rand * 5).round]
			@code.push(symbol)
		end

		return @code
	end

	def check_guess(guess, code = @code)
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
		code.each_with_index do |symbol, i|
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
		end

		(0..3).each do |i|
			unless feedback[i]
				feedback[i] = "X"
			end
		end
		
		return feedback
	end

end










