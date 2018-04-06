class Game
	attr_accessor :board, :WK, :WQ, :WB1, :WB2, :WK1, :WK2, :WR1, :WR2, :WP1, :WP2, :WP3, :WP4, :WP5, :WP6, :WP7, :WP8, :BK, :BQ, :BB1, :BB2, :BK1, :BK2, :BR1, :BR2, :BP1, :BP2, :BP3, :BP4, :BP5, :BP6, :BP7, :BP8, :b_score, :w_score, :all
	def initialize(game_name)
		@game_name = game_name
		@board = Board.new

		@WK = Knight.new([4,3], "♞")
		@BP = Pawn.new([3,4], "♙")
		$all = [@WK, @BP]
		$b_score = 0
		$w_score = 0
		$all.each {|x| x.set_spot(x.position)}
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
		$b_score
	end

	def w_score
		$w_score
	end

	def w_space_piece(x,y)
		$all.each do |z|
			if z.position == [x,y]
				return z.color
			end
		end
		return "▒"
	end

	def b_space_piece(x,y)
		$all.each do |z|
			if z.position == [x,y]
				return z.color
			end
		end
		return " "
	end

	def b_captured
		captured = Array.new
		$all.each do |z|
			if z.position == [8,0]
				captured << z.color
			end
		end
		return captured.join("")
	end

	def w_captured
		captured = Array.new
		$all.each do |z|
			if z.position == [8,1]
				captured << z.color
			end
		end
		return captured.join("")
	end

	def move(start, destination)
		if  $all.any? {|x| start == x.position}
			$all.each do |z|
				unless z == nil
					if start == z.position
						if ($coords.include? destination) && (z.moves.include? destination)
							if piece_here?(destination)
								piece(destination).capture
							end
							z.set_spot(destination)
							puts "piece moved"
						else
							puts "ERROR!!!! your destination isn't valid!"
						end
					end
				end
			end
			$all.each {|y| y.set_spot(y.position)}
		else
			puts "ERROR!!!! Your start position isn't a piece!"
		end
	end

end
#####################ALL METHODS OUTSIDE GAME######################################
def piece(loc)
	if piece_here?(loc)
		$all.each do |x|
			if x.position == loc
				return x
			end if x != nil
		end
	end
end

def piece_here?(loc)
	if $all.any? {|x| loc == x.position if x != nil}
		return true
	else
		return false
	end
end
#####################ALL CLASSES THAT ARE OUTSIDE GAME############################
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

class King
	attr_accessor :position, :color, :moves
	def initialize(position, color, moves=[])
		@position = position
		@color = color
		@moves = moves
	end
end

class Queen
	attr_accessor :position, :color, :moves
	def initialize(position, color, moves=[])
		@position = position
		@color = color
		@moves = moves
	end
end

class Bishop
	attr_accessor :position, :color, :moves
	def initialize(position, color, moves=[])
		@position = position
		@color = color
		@moves = moves
	end
end

class Knight
	attr_accessor :position, :color, :moves
	def initialize(position, color, moves=[])
		@position = position
		@color = color
		@moves = moves
	end
	def set_spot(spot)
		@position = spot
		@moves = Array.new
		all_on_board = Array.new
		all_spots = [[(@position[0] + 1), (@position[1] + 2)], [(@position[0] + 2), (@position[1] + 1)], [(@position[0] + 2), (@position[1] - 1)], [(@position[0] + 1), (@position[1] - 2)], [(@position[0] - 1), (@position[1] - 2)], [(@position[0] - 2), (@position[1] - 1)], [(@position[0] - 2), (@position[1] + 1)], [(@position[0] - 1), (@position[1] + 2)]]
		all_spots.each do |x|
			all_on_board << x if ($coords.include? x)
		end
		all_on_board.each do |y|
			if piece_here?(y)
				if @color == "♘"
					@moves << y if (["♚", "♛", "♝", "♞", "♜", "♟"].include? piece(y).color)
				elsif @color == "♞"
					@moves << y if (["♔", "♕", "♗", "♘", "♖", "♙"].include? piece(y).color)
				end
			else
				@moves << y
			end
		end
	end
	def capture
		if @color == "♞"
			@position = [8,0]
			$b_score += 3
		elsif @color == "♘"
			@position = [8,1]
			$w_score += 3
		end
	end
end

class Rook
	attr_accessor :position, :color, :moves
	def initialize(position, color, moves=[])
		@position = position
		@color = color
		@moves = moves
	end
	def set_spot(spot)
		@position = spot
		@moves = Array.new
		for i in 1..7
			if piece_here?([@position[0], (@position[1] + i)])
				if (@color == "♖") && (["♚", "♛", "♝", "♞", "♜", "♟"].include? piece([@position[0], (@position[1] + i)]).color)
					@moves << [@position[0], (@position[1] + i)]
				elsif (@color == "♜") && (["♔", "♕", "♗", "♘", "♖", "♙"].include? piece([@position[0], (@position[1] + i)]).color)
					@moves << [@position[0], (@position[1] + i)]
				end
				break
			elsif (($coords.include? [@position[0], (@position[1] + i)]) == false)
				break
			end
			@moves << [@position[0], (@position[1] + i)]
		end
		for j in 1..7
			if piece_here?([@position[0], (@position[1] - j)])
				if (@color == "♖") && (["♚", "♛", "♝", "♞", "♜", "♟"].include? piece([@position[0], (@position[1] - j)]).color)
					@moves << [@position[0], (@position[1] - j)]
				elsif (@color == "♜") && (["♔", "♕", "♗", "♘", "♖", "♙"].include? piece([@position[0], (@position[1] - j)]).color)
					@moves << [@position[0], (@position[1] - j)]
				end
				break
			elsif (($coords.include? [@position[0], (@position[1] - j)]) == false)
				break
			end
			@moves << [@position[0], (@position[1] - j)]
		end
		for k in 1..7
			if piece_here?([(@position[0] + k), @position[1]])
				if (@color == "♖") && (["♚", "♛", "♝", "♞", "♜", "♟"].include? piece([(@position[0] + k), @position[1]]).color)
					@moves << [(@position[0] + k), @position[1]]
				elsif (@color == "♜") && (["♔", "♕", "♗", "♘", "♖", "♙"].include? piece([(@position[0] + k), @position[1]]).color)
					@moves << [(@position[0] + k), @position[1]]
				end
				break
			elsif (($coords.include? [(@position[0] + k), @position[1]]) == false)
				break
			end
			@moves << [(@position[0] + k), @position[1]]
		end
		for l in 1..7
			if piece_here?([(@position[0] - l), @position[1]])
				if (@color == "♖") && (["♚", "♛", "♝", "♞", "♜", "♟"].include? piece([(@position[0] - l), @position[1]]).color)
					@moves << [(@position[0] - l), @position[1]]
				elsif (@color == "♜") && (["♔", "♕", "♗", "♘", "♖", "♙"].include? piece([(@position[0] - l), @position[1]]).color)
					@moves << [(@position[0] - l), @position[1]]
				end
				break
			elsif (($coords.include? [(@position[0] - l), @position[1]]) == false)
				break
			end
			@moves << [(@position[0] - l), @position[1]]
		end

	end
	def capture
		if @color == "♜"
			@position = [8,0]
			$b_score += 5
		elsif @color == "♖"
			@position = [8,1]
			$w_score += 5
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
		@moves = Array.new
		@position = spot
		if @color == "♟"
			if piece_here?([@position[0], (@position[1] + 1)]) == false
				@moves << [@position[0], (@position[1] + 1)]
				if @position[1] == 1 && piece_here?([@position[0], (@position[1] + 2)]) == false
					@moves << [@position[0], (@position[1] + 2)]
				end
			end
			if piece_here?([(@position[0] + 1), (@position[1] + 1)]) &&  (["♔", "♕", "♗", "♘", "♖", "♙"].include? piece([(@position[0] + 1), (@position[1] + 1)]).color)
				@moves << [(@position[0] + 1), (@position[1] + 1)]
			end
			if piece_here?([(@position[0] - 1), (@position[1] + 1)]) && (["♔", "♕", "♗", "♘", "♖", "♙"].include? piece([(@position[0] - 1), (@position[1] + 1)]).color)
				@moves << [(@position[0] - 1), (@position[1] + 1)]
			end
		elsif @color == "♙" 
			if piece_here?([@position[0], (@position[1] -1)]) == false
				@moves << [@position[0], (@position[1] - 1)]
				if @position[1] == 6 && piece_here?([@position[0], (@position[1] -2)]) == false
					@moves << [@position[0], (@position[1] - 2)]
				end
			end
			if piece_here?([(@position[0] + 1), (@position[1] - 1)]) &&  (["♚", "♛", "♝", "♞", "♜", "♟"].include? piece([(@position[0] + 1), (@position[1] - 1)]).color)
				@moves << [(@position[0] + 1), (@position[1] - 1)]
			end
			if piece_here?([(@position[0] - 1), (@position[1] - 1)]) && (["♚", "♛", "♝", "♞", "♜", "♟"].include? piece([(@position[0] - 1), (@position[1] - 1)]).color)
				@moves << [(@position[0] - 1), (@position[1] - 1)]
			end
		end
		@moves
	end

	def capture
		if @color == "♟"
			@position = [8,0]
			$b_score += 1
		elsif @color == "♙"
			@position = [8,1]
			$w_score += 1
		end
	end
end

game = Game.new("test")
#$all.each {|x| x.set_spot(x.position)}
game.show_board
game.move([3,4], [4,3])
game.show_board