require 'colorize'
class MasterMind
	SYMBOLS = ["*", "+", "\#", "-", "@", "/"]

	def play(turns = 12, codebreaker, codemaker)
		
		rules(:codebreaker, turns) if codebreaker.human?
		rules(:codemaker, turns) if codemaker.human?
		
		code = codemaker.create_code
		codebreaker.codebreak(code, turns)

	end

	def rules(mode, turns)
		if mode == :codebreaker

			puts "To win you must crack the #{"code".bold} in under #{turns} turns"
			puts "The #{"code".bold} is a 4 character long combination of symbols (duplicates are allowed)"
			puts "\nThe symbols are : "
			SYMBOLS.each do |sym|
				print "   #{sym}   |"
			end
			puts "\n"
			puts "\nAfter each attempt you'll be given feedback :"
			puts "\nB".green + " means that you guessed a symbol and its position correctly"
			puts "W".light_black + " means that you guessed a symbol correctly"
			puts "X".red + " means that there is no match\n"

		else

			puts "To win your opponent mustn't crack your code in under #{turns} turns"
			puts "Your code must be a 4 character long combination of symbols (duplicates are allowed)"
			puts "\nThe symbols are : "
			SYMBOLS.each do |sym|
				print "   #{sym}   |"
			end
			puts "\n"
			puts "\nAfter each attempt your opponent will be given feedback :"
			puts "\nB".green + " means that you guessed a symbol and its position correctly"
			puts "W".light_black + " means that you guessed a symbol correctly"
			puts "X".red + " means that there is no match\n"

		end
		puts "\nWhen ready to start, press enter."
		gets
	end

end










