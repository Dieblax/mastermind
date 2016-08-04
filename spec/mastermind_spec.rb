require "mastermind"
describe MasterMind do
	before do
		@mastermind = MasterMind.new
	end

	describe "\#create_code" do
		context "given no argument" do
			it "returns a random non-empty code of length 4" do
				expect(@mastermind.create_code.size).to eq(4)
				expect(@mastermind.create_code.include?(" ")).to eq(false)
			end
		end

		context "given 5" do
			it "returns a random non-empty code of length 5" do
				expect(@mastermind.create_code(5).size).to eq(5)
				expect(@mastermind.create_code(5).include?(" ")).to eq(false)
			end
		end
	end

	before do
		@code = @mastermind.create_code
		@guess = ["*", "+", "-", "/"]
		@check = ["*", "+", "-", "-"]
		@not_matching = ["@"]*4
	end
	describe "\#check_guess" do
		context "given the code as argument" do
			it "returns B B B B" do
				expect(@mastermind.check_guess(@code)).to eq(["B", "B", "B", "B"])
			end
		end
		context "given a code with 3 matching symbols" do
			it "returns B B B X" do
				expect(@mastermind.check_guess(@guess, @check)).to eq(["B", "B", "B", "X"])
			end
		end
		context "given a guess that doesn't match the code at all" do
			it "returns X X X X" do
				expect(@mastermind.check_guess(@not_matching, @check)).to eq(["X", "X", "X", "X"])
			end	
		end
	end
end