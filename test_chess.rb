class Game
	attr_accessor :board, :WK, :WQ, :WB1, :WB2, :WK1, :WK2, :WR1, :WR2, :WP1, :WP2, :WP3, :WP4, :WP5, :WP6, :WP7, :WP8, :BK, :BQ, :BB1, :BB2, :BK1, :BK2, :BR1, :BR2, :BP1, :BP2, :BP3, :BP4, :BP5, :BP6, :BP7, :BP8, :b_score, :w_score, :all
	def initialize(game_name)
		@game_name = game_name
		@board = Board.new
		#@WK = King.new([4,0],"♚")
		#@WQ = Queen.new([3,0], "♛")
		#@WB1 = Bishop.new([2,0], "♝")
		#@WB2 = Bishop.new([5,0], "♝")
		#@WK1 = Knight.new([1,0], "♞")
		#@WK2 = Knight.new([6,0], "♞")
		#@WR1 = Rook.new([7,0], "♜")
		#@WR2 = Rook.new([0,0], "♜")
		@WP1 = Pawn.new([0,1], "♟")
		@WP2 = Pawn.new([1,1], "♟")
		@WP3 = Pawn.new([2,1], "♟")
		@WP4 = Pawn.new([3,1], "♟")
		@WP5 = Pawn.new([4,1], "♟")
		@WP6 = Pawn.new([5,1], "♟")
		@WP7 = Pawn.new([6,1], "♟")
		@WP8 = Pawn.new([7,1], "♟")
		#@BK = King.new([4,7],"♔")
		#@BQ = Queen.new([3,7], "♕")
		#@BB1 = Bishop.new([2,7], "♗")
		#@BB2 = Bishop.new([5,7], "♗")
		#@BK1 = Knight.new([1,7], "♘")
		#@BK2 = Knight.new([6,7], "♘")
		#@BR1 = Rook.new([7,7], "♖")
		#@BR2 = Rook.new([0,7], "♖")
		@BP1 = Pawn.new([0,6], "♙")
		#@BP2 = Pawn.new([1,6], "♙")
		#@BP3 = Pawn.new([2,6], "♙")
		#@BP4 = Pawn.new([3,6], "♙")
		#@BP5 = Pawn.new([4,6], "♙")
		#@BP6 = Pawn.new([5,6], "♙")
		#@BP7 = Pawn.new([6,6], "♙")
		#@BP8 = Pawn.new([7,6], "♙")
		@all = [@WK, @WQ, @WB1, @WB2, @WK1, @WK2, @WR1, @WR2, @WP1, @WP2, @WP3, @WP4, @WP5, @WP6, @WP7, @WP8, @BK, @BQ, @BB1, @BB2, @BK1, @BK2, @BR1, @BR2, @BP1, @BP2, @BP3, @BP4, @BP5, @BP6, @BP7, @BP8]
		@b_score = 0
		@w_score = 0
	end

	def show_board
		board_string ="Here is your chess board:

  (0) (1) (2) (3) (4) (5) (6) (7)
 ╔═══╦═══╦═══╦═══╦═══╦═══╦═══╦═══╗     Black's captured pieces:
8║▒#{w_space_piece(0,7)}▒║ #{b_space_piece(1,7)} ║▒#{w_space_piece(2,7)}▒║ #{b_space_piece(3,7)} ║▒#{w_space_piece(4,7)}▒║ #{b_space_piece(5,7)} ║▒#{w_space_piece(6,7)}▒║ #{b_space_piece(7,7)} ║(7) ┏━━━━━━
 ╠═══╬═══╬═══╬═══╬═══╬═══╬═══╬═══╣    ┃#{b_captured}
7║ #{b_space_piece(0,6)} ║▒#{w_space_piece(1,6)}▒║ #{b_space_piece(2,6)} ║▒#{w_space_piece(3,6)}▒║ #{b_space_piece(4,6)} ║▒#{w_space_piece(5,6)}▒║ #{b_space_piece(6,6)} ║▒#{w_space_piece(7,6)}▒║(6) ┗━━━━━━
 ╠═══╬═══╬═══╬═══╬═══╬═══╬═══╬═══╣
6║▒#{w_space_piece(0,5)}▒║ #{b_space_piece(1,5)} ║▒#{w_space_piece(2,5)}▒║ #{b_space_piece(3,5)} ║▒#{w_space_piece(4,5)}▒║ #{b_space_piece(5,5)} ║▒#{w_space_piece(6,5)}▒║ #{b_space_piece(7,5)} ║(5)
 ╠═══╬═══╬═══╬═══╬═══╬═══╬═══╬═══╣     Black's score : #{b_score}
5║ #{b_space_piece(0,4)} ║▒#{w_space_piece(1,4)}▒║ #{b_space_piece(2,4)} ║▒#{w_space_piece(3,4)}▒║ #{b_space_piece(4,4)} ║▒#{w_space_piece(5,4)}▒║ #{b_space_piece(6,4)} ║▒#{w_space_piece(7,4)}▒║(4)
 ╠═══╬═══╬═══╬═══╬═══╬═══╬═══╬═══╣
4║▒#{w_space_piece(0,3)}▒║ #{b_space_piece(1,3)} ║▒#{w_space_piece(2,3)}▒║ #{b_space_piece(3,3)} ║▒#{w_space_piece(4,3)}▒║ #{b_space_piece(5,3)} ║▒#{w_space_piece(6,3)}▒║ #{b_space_piece(7,3)} ║(3)
 ╠═══╬═══╬═══╬═══╬═══╬═══╬═══╬═══╣     White's score : #{w_score}
3║ #{b_space_piece(0,2)} ║▒#{w_space_piece(1,2)}▒║ #{b_space_piece(2,2)} ║▒#{w_space_piece(3,2)}▒║ #{b_space_piece(4,2)} ║▒#{w_space_piece(5,2)}▒║ #{b_space_piece(6,2)} ║▒#{w_space_piece(7,2)}▒║(2)
 ╠═══╬═══╬═══╬═══╬═══╬═══╬═══╬═══╣
2║▒#{w_space_piece(0,1)}▒║ #{b_space_piece(1,1)} ║▒#{w_space_piece(2,1)}▒║ #{b_space_piece(3,1)} ║▒#{w_space_piece(4,1)}▒║ #{b_space_piece(5,1)} ║▒#{w_space_piece(6,1)}▒║ #{b_space_piece(7,1)} ║(1)  White's captured pieces:
 ╠═══╬═══╬═══╬═══╬═══╬═══╬═══╬═══╣    ┏━━━━━━
1║ #{b_space_piece(0,0)} ║▒#{w_space_piece(1,0)}▒║ #{b_space_piece(2,0)} ║▒#{w_space_piece(3,0)}▒║ #{b_space_piece(4,0)} ║▒#{w_space_piece(5,0)}▒║ #{b_space_piece(6,0)} ║▒#{w_space_piece(7,0)}▒║(0) ┃#{w_captured}
 ╚═══╩═══╩═══╩═══╩═══╩═══╩═══╩═══╝    ┗━━━━━━
   a   b   c   d   e   f   g   h"
   		puts board_string
	end

	def b_score
		@b_score
	end

	def w_score
		@w_score
	end

	def w_space_piece(x,y)
		@all.each do |z|
			unless z == nil
				if z.position == [x,y]
					return z.color
				end
			end
		end
		return "▒"
	end

	def b_space_piece(x,y)
		@all.each do |z|
			unless z == nil
				if z.position == [x,y]
					return z.color
				end
			end
		end
		return " "
	end

	def b_captured
		@all.each do |z|
			unless z == nil
				if z.position == [8,0]
					return z.color
				end
			end
		end
		return " "
	end

	def w_captured
		@all.each do |z|
			unless z == nil
				if z.position == [8,1]
					return z.color
				end
			end
		end
		return " "
	end

	def move(start, destination)
		if @all.any? {|x| start == x.position if x != nil}
			@all.each do |z|
				unless z == nil
					if start == z.position
						if ($coords.include? destination) && (z.moves.include? destination)
							z.position = destination
							z.set_spot(destination)
							puts "piece moved"
						else
							puts "ERROR!!!! your destination isn't valid!"
						end
					end
				end
			end
		else
			puts "ERROR!!!! Your start position isn't a piece!"
		end
	end

end

class Board
	attr_accessor :coords
	def initialize
		$coords = Array.new
		for i in 0...8
			for j in 0...8
				$coords.push([i,j])
			end
		end
	end
end

class Pawn
	attr_accessor :position, :color, :moves
	def initialize(position, color)
		@position = position
		@color = color
		if color == "♟"
			@moves = [[position[0], (position[1] + 2)], [position[0], (position[1] + 1)]]
		elsif color == "♙"
			@moves = [[position[0], (position[1] - 2)], [position[0], (position[1] - 1)]]
		end
	end
	def set_spot(spot)
		@position = spot
		if @color == "♟"
			@moves = [[spot[0], spot[1] + 1]]
		elsif @color == "♙"
			@moves = [[spot[0], spot[1] - 1]]
		end
	end
end


game = Game.new("test")
game.show_board
game.all.each do |z|
	unless z == nil
		if z.color == "♟"
			print z.moves
			puts "\n"
		end
	end
end
game.move([1,1],[1,3])
game.move([0,6],[0,4])
game.show_board