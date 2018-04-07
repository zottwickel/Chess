require "yaml"
class Game
	attr_accessor :game_name, :all, :coords, :all, :turn
	def initialize(game_name)
		@game_name = game_name
		@board = Board.new
		@WK = King.new([4,0],"♚")
		@WQ = Queen.new([3,0], "♛")
		@WB1 = Bishop.new([2,0], "♝")
		@WB2 = Bishop.new([5,0], "♝")
		@WK1 = Knight.new([1,0], "♞")
		@WK2 = Knight.new([6,0], "♞")
		@WR1 = Rook.new([7,0], "♜")
		@WR2 = Rook.new([0,0], "♜")
		@WP1 = Pawn.new([0,1], "♟")
		@WP2 = Pawn.new([1,1], "♟")
		@WP3 = Pawn.new([2,1], "♟")
		@WP4 = Pawn.new([3,1], "♟")
		@WP5 = Pawn.new([4,1], "♟")
		@WP6 = Pawn.new([5,1], "♟")
		@WP7 = Pawn.new([6,1], "♟")
		@WP8 = Pawn.new([7,1], "♟")
		@BK = King.new([4,7],"♔")
		@BQ = Queen.new([3,7], "♕")
		@BB1 = Bishop.new([2,7], "♗")
		@BB2 = Bishop.new([5,7], "♗")
		@BK1 = Knight.new([1,7], "♘")
		@BK2 = Knight.new([6,7], "♘")
		@BR1 = Rook.new([7,7], "♖")
		@BR2 = Rook.new([0,7], "♖")
		@BP1 = Pawn.new([0,6], "♙")
		@BP2 = Pawn.new([1,6], "♙")
		@BP3 = Pawn.new([2,6], "♙")
		@BP4 = Pawn.new([3,6], "♙")
		@BP5 = Pawn.new([4,6], "♙")
		@BP6 = Pawn.new([5,6], "♙")
		@BP7 = Pawn.new([6,6], "♙")
		@BP8 = Pawn.new([7,6], "♙")
		$all = [@WK, @WQ, @WB1, @WB2, @WK1, @WK2, @WR1, @WR2, @WP1, @WP2, @WP3, @WP4, @WP5, @WP6, @WP7, @WP8, @BK, @BQ, @BB1, @BB2, @BK1, @BK2, @BR1, @BR2, @BP1, @BP2, @BP3, @BP4, @BP5, @BP6, @BP7, @BP8]
		@all = $all
		@coords = Array.new
		for i in 0...8
			for j in 0...8
				@coords << [i,j]
			end
		end
		$all.each {|x| x.set_spot}
		@turn = "white"
	end

	def show_board
		board_string ="
 ╔═══╦═══╦═══╦═══╦═══╦═══╦═══╦═══╗     Black's captured pieces:
8║▒#{w_space_piece(0,7)}▒║ #{b_space_piece(1,7)} ║▒#{w_space_piece(2,7)}▒║ #{b_space_piece(3,7)} ║▒#{w_space_piece(4,7)}▒║ #{b_space_piece(5,7)} ║▒#{w_space_piece(6,7)}▒║ #{b_space_piece(7,7)} ║    ┏━━━━━━
 ╠═══╬═══╬═══╬═══╬═══╬═══╬═══╬═══╣    ┃#{b_captured}
7║ #{b_space_piece(0,6)} ║▒#{w_space_piece(1,6)}▒║ #{b_space_piece(2,6)} ║▒#{w_space_piece(3,6)}▒║ #{b_space_piece(4,6)} ║▒#{w_space_piece(5,6)}▒║ #{b_space_piece(6,6)} ║▒#{w_space_piece(7,6)}▒║    ┗━━━━━━
 ╠═══╬═══╬═══╬═══╬═══╬═══╬═══╬═══╣
6║▒#{w_space_piece(0,5)}▒║ #{b_space_piece(1,5)} ║▒#{w_space_piece(2,5)}▒║ #{b_space_piece(3,5)} ║▒#{w_space_piece(4,5)}▒║ #{b_space_piece(5,5)} ║▒#{w_space_piece(6,5)}▒║ #{b_space_piece(7,5)} ║   
 ╠═══╬═══╬═══╬═══╬═══╬═══╬═══╬═══╣     Black's score : #{b_score}
5║ #{b_space_piece(0,4)} ║▒#{w_space_piece(1,4)}▒║ #{b_space_piece(2,4)} ║▒#{w_space_piece(3,4)}▒║ #{b_space_piece(4,4)} ║▒#{w_space_piece(5,4)}▒║ #{b_space_piece(6,4)} ║▒#{w_space_piece(7,4)}▒║   
 ╠═══╬═══╬═══╬═══╬═══╬═══╬═══╬═══╣
4║▒#{w_space_piece(0,3)}▒║ #{b_space_piece(1,3)} ║▒#{w_space_piece(2,3)}▒║ #{b_space_piece(3,3)} ║▒#{w_space_piece(4,3)}▒║ #{b_space_piece(5,3)} ║▒#{w_space_piece(6,3)}▒║ #{b_space_piece(7,3)} ║   
 ╠═══╬═══╬═══╬═══╬═══╬═══╬═══╬═══╣     White's score : #{w_score}
3║ #{b_space_piece(0,2)} ║▒#{w_space_piece(1,2)}▒║ #{b_space_piece(2,2)} ║▒#{w_space_piece(3,2)}▒║ #{b_space_piece(4,2)} ║▒#{w_space_piece(5,2)}▒║ #{b_space_piece(6,2)} ║▒#{w_space_piece(7,2)}▒║   
 ╠═══╬═══╬═══╬═══╬═══╬═══╬═══╬═══╣
2║▒#{w_space_piece(0,1)}▒║ #{b_space_piece(1,1)} ║▒#{w_space_piece(2,1)}▒║ #{b_space_piece(3,1)} ║▒#{w_space_piece(4,1)}▒║ #{b_space_piece(5,1)} ║▒#{w_space_piece(6,1)}▒║ #{b_space_piece(7,1)} ║     White's captured pieces:
 ╠═══╬═══╬═══╬═══╬═══╬═══╬═══╬═══╣    ┏━━━━━━
1║ #{b_space_piece(0,0)} ║▒#{w_space_piece(1,0)}▒║ #{b_space_piece(2,0)} ║▒#{w_space_piece(3,0)}▒║ #{b_space_piece(4,0)} ║▒#{w_space_piece(5,0)}▒║ #{b_space_piece(6,0)} ║▒#{w_space_piece(7,0)}▒║    ┃#{w_captured}
 ╚═══╩═══╩═══╩═══╩═══╩═══╩═══╩═══╝    ┗━━━━━━
   a   b   c   d   e   f   g   h"
   		puts board_string
	end

	def b_score
		b_score = 0
		captured = Array.new
		$all.each do |x| 
			if x.position == [8,0] 
				captured << x
			end
		end
		captured.each do |y|
			if y.color == "♟"
				b_score += 1
			elsif y.color == "♜"
				b_score += 5
			elsif y.color == "♞"
				b_score += 3
			elsif y.color == "♝"
				b_score += 3
			elsif y.color == "♛"
				b_score += 9
			end
		end
		return b_score
	end

	def w_score
		w_score = 0
		captured = Array.new
		$all.each do |x|
			if x.position == [8,1]
				captured << x
			end
		end
		captured.each do |y|
			if y.color == "♙"
				w_score += 1
			elsif y.color == "♖"
				w_score += 5
			elsif y.color == "♘"
				w_score += 3
			elsif y.color == "♗"
				w_score += 3
			elsif y.color == "♕"
				w_score += 9
			end
		end
		return w_score
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
		if ["♔", "♕", "♗", "♘", "♖", "♙"].include? piece(start).color
			piece(start).position = [8, 2]
			$all.each {|x| x.set_spot}
			if b_check?
				piece([8, 2]).position = start
				$all.each {|x| x.set_spot}
				puts "ERROR!!!! This would put your king in check!!!"
			else
				if piece_here?(destination)
					piece(destination).capture
				end
				piece([8, 2]).position = destination
				$all.each {|x| x.set_spot}
				if ["♖", "♔"].include? piece(destination).color
					piece(destination).moved = true
				end
				system "clear"
				puts "Piece moved"
			end
		elsif ["♚", "♛", "♝", "♞", "♜", "♟"].include? piece(start).color
			piece(start).position = [8, 2]
			$all.each {|x| x.set_spot}
			if w_check?
				piece([8, 2]).position = start
				$all.each {|x| x.set_spot}
				puts "ERROR!!!! This would put your king in check!!!"
			else
				if piece_here?(destination)
					piece(destination).capture
				end
				piece([8, 2]).position = destination
				$all.each {|x| x.set_spot}
				if ["♜", "♚"].include? piece(destination).color
					piece(destination).moved = true
				end
				system "clear"
				puts "Piece moved"
			end
		end
	end

	def castle(color, direction)
		if (color == "white") && (direction == "left")
			if ($all.any? {|x| [[1, 0], [2, 0], [3, 0]].include? x.position} == false)
				if (@WR2.moved == false) && (@WK.moved == false) && (w_check? == false)
					unless $all.any? {|x| ((x.moves.include? [1, 0]) || (x.moves.include? [2, 0]) || (x.moves.include? [3, 0])) && (["♔", "♕", "♗", "♘", "♖", "♙"].include? x.color)}
						@WK.position = [2, 0]
						@WR2.position = [3, 0]
						$all.each {|y| y.set_spot}
						system "clear"
						puts "Castled"
					else
						system "clear"
						puts "Unable to castle there!"
						white_turn
					end
				else
					system "clear"
					puts "Unable to castle there!"
					white_turn
				end
			else
				system "clear"
				puts "Unable to castle there!"
				white_turn
			end
		elsif (color == "white") && (direction == "right")
			if ($all.any? {|x| [[5, 0], [6, 0]].include? x.position}) == false
				if (@WR1.moved == false) && (@WK.moved == false) && (w_check? == false)
					unless $all.any? {|x| ((x.moves.include? [6, 0]) || (x.moves.include? [5, 0])) && (["♔", "♕", "♗", "♘", "♖", "♙"].include? x.color)}
						@WK.position = [6, 0]
						@WR1.position = [5, 0]
						$all.each {|y| y.set_spot}
						system "clear"
						puts "Castled"
					else
						system "clear"
						puts "Unable to castle there"
						white_turn
					end
				else
					system "clear"
					puts "Unable to castle there"
					white_turn
				end
			else
				system "clear"
				puts "Unable to castle there!"
				white_turn
			end
		elsif (color == "black") && (direction == "right")
			if ($all.any? {|x| [[5, 7], [6, 7]].include? x.position}) == false
				if (@BR1.moved == false) && (@BK.moved == false) && (b_check? == false)
					unless $all.any? {|x| ((x.moves.include? [6, 7]) || (x.moves.include? [5, 7])) && (["♚", "♛", "♝", "♞", "♜", "♟"].include? x.color)}
						@BK.position = [6, 7]
						@BR1.position = [5, 7]
						$all.each {|y| y.set_spot}
						system "clear"
						puts "Castled"
					else
						system "clear"
						puts "Unable to castle there!"
						black_turn
					end
				else
					system "clear"
					puts "Unable to castle there!"
					black_turn
				end
			else
				system "clear"
				puts "Unable to castle there!"
				black_turn
			end
		elsif (color == "black") && (direction == "left")
			if ($all.any? {|x| [[1, 7], [2, 7], [3, 7]].include? x.position} == false)
				if (@BR2.moved == false) && (@BK.moved == false) && (b_check? == false)
					unless $all.any? {|x| ((x.moves.include? [1, 7]) || (x.moves.include? [2, 7]) || (x.moves.include? [3, 7])) && (["♚", "♛", "♝", "♞", "♜", "♟"].include? x.color)}
						@BK.position = [2, 7]
						@BR2.position = [3, 7]
						$all.each {|y| y.set_spot}
						system "clear"
						puts "Castled"
					else
						system "clear"
						puts "Unable to castle here"
						black_turn
					end
				else

					system "clear"
					puts "Unable to castle here"
					black_turn
				end
			else
				system "clear"
				puts "Unable to castle there!"
				black_turn
			end
		end
	end

	def w_check?
		if $all.any? {|x| (x.moves.include? @WK.position) && (["♔", "♕", "♗", "♘", "♖", "♙"].include? x.color)}
			return true
		else
			return false
		end
	end

	def b_check?
		if $all.any? {|x| (x.moves.include? @BK.position) && (["♚", "♛", "♝", "♞", "♜", "♟"].include? x.color)}
			return true
		else
			return false
		end
	end

	def checkmate?
		statement = true
		if w_check? == true
			$all.each do |x|
				if ["♚", "♛", "♝", "♞", "♜", "♟"].include? x.color
					starting = x.position
					x.moves.each do |y|
						x.position = y
						$all.each {|z| z.set_spot}
						if w_check? == false
							x.position = starting
							statement = false
						end
						x.position = starting
						$all.each {|z| z.set_spot}
					end
				end
			end
			return statement
		elsif b_check? == true
			$all.each do |x|
				if ["♔", "♕", "♗", "♘", "♖", "♙"].include? x.color
					starting = x.position
					x.moves.each do |y|
						x.position = y
						$all.each {|z| z.set_spot}
						if b_check? == false
							x.position = starting
							statement = false
						end
						x.position = starting
						$all.each {|z| z.set_spot}
					end
				end
			end
			return statement
		else
			statement = false
			return statement
		end
	end
end
############ALL METHODS OUTSIDE GAME USED BY GAME & PIECES#######################
def piece(loc)
	if piece_here?(loc)
		$all.each do |x|
			if x.position == loc
				return x
			end
		end
	end
end

def piece_here?(loc)
	if $all.any? {|x| loc == x.position}
		return true
	else
		return false
	end
end
#####################ALL CLASSES THAT ARE PIECES############################
class Board
	attr_accessor :coords
	def initialize
		$coords = Array.new
		for i in 0...8
			for j in 0...8
				$coords << [i,j]
			end
		end
	end
end

class King
	attr_accessor :position, :color, :moves, :moved
	def initialize(position, color, moves=[])
		@position = position
		@color = color
		@moves = moves
		@moved = false
	end
	def set_spot(spot=@position)
		@position = spot
		@moves = Array.new
		all_on_board = Array.new
		all_spots = [[(@position[0]), (@position[1] + 1)], [(@position[0] + 1), (@position[1] + 1)], [(@position[0] + 1), (@position[1])], [(@position[0] + 1), (@position[1] - 1)], [(@position[0]), (@position[1] - 1)], [(@position[0] - 1), (@position[1] - 1)], [(@position[0] - 1), (@position[1])], [(@position[0] - 1), (@position[1] + 1)]]
		all_spots.each do |x|
			all_on_board << x if ($coords.include? x)
		end
		all_on_board.each do |y|
			if piece_here?(y) == true
				if @color == "♔"
					@moves << y if (["♚", "♛", "♝", "♞", "♜", "♟"].include? piece(y).color)
				elsif @color == "♚"
					@moves << y if (["♔", "♕", "♗", "♘", "♖", "♙"].include? piece(y).color)
				end
			else
				@moves << y
			end
		end
		if ($all.count {|z| z.position == spot}) >= 2
			@moves.clear
		end
	end
end

class Queen
	attr_accessor :position, :color, :moves
	def initialize(position, color, moves=[])
		@position = position
		@color = color
		@moves = moves
	end
	def set_spot(spot=@position)
		@position = spot
		@moves = Array.new
		#UP
		for i in 1..7
			if piece_here?([@position[0], (@position[1] + i)])
				if (@color == "♕") && (["♚", "♛", "♝", "♞", "♜", "♟"].include? piece([@position[0], (@position[1] + i)]).color)
					@moves << [@position[0], (@position[1] + i)]
				elsif (@color == "♛") && (["♔", "♕", "♗", "♘", "♖", "♙"].include? piece([@position[0], (@position[1] + i)]).color)
					@moves << [@position[0], (@position[1] + i)]
				end
				break
			elsif (($coords.include? [@position[0], (@position[1] + i)]) == false)
				break
			end
			@moves << [@position[0], (@position[1] + i)]
		end
		#RIGHT-UP
		for j in 1..7
			if piece_here?([@position[0] + j, (@position[1] + j)])
				if (@color == "♕") && (["♚", "♛", "♝", "♞", "♜", "♟"].include? piece([@position[0] + j, (@position[1] + j)]).color)
					@moves << [@position[0] + j, (@position[1] + j)]
				elsif (@color == "♛") && (["♔", "♕", "♗", "♘", "♖", "♙"].include? piece([@position[0] + j, (@position[1] + j)]).color)
					@moves << [@position[0] + j, (@position[1] + j)]
				end
				break
			elsif (($coords.include? [@position[0] + j, (@position[1] + j)]) == false)
				break
			end
			@moves << [@position[0] + j, (@position[1] + j)]
		end
		#RIGHT
		for k in 1..7
			if piece_here?([(@position[0] + k), @position[1]])
				if (@color == "♕") && (["♚", "♛", "♝", "♞", "♜", "♟"].include? piece([(@position[0] + k), @position[1]]).color)
					@moves << [(@position[0] + k), @position[1]]
				elsif (@color == "♛") && (["♔", "♕", "♗", "♘", "♖", "♙"].include? piece([(@position[0] + k), @position[1]]).color)
					@moves << [(@position[0] + k), @position[1]]
				end
				break
			elsif (($coords.include? [(@position[0] + k), @position[1]]) == false)
				break
			end
			@moves << [(@position[0] + k), @position[1]]
		end
		#RIGHT-DOWN
		for l in 1..7
			if piece_here?([@position[0] + l, (@position[1] - l)])
				if (@color == "♕") && (["♚", "♛", "♝", "♞", "♜", "♟"].include? piece([@position[0] + l, (@position[1] - l)]).color)
					@moves << [@position[0] + l, (@position[1] - l)]
				elsif (@color == "♛") && (["♔", "♕", "♗", "♘", "♖", "♙"].include? piece([@position[0] + l, (@position[1] - l)]).color)
					@moves << [@position[0] + l, (@position[1] - l)]
				end
				break
			elsif (($coords.include? [@position[0] + l, (@position[1] - l)]) == false)
				break
			end
			@moves << [@position[0] + l, (@position[1] - l)]
		end
		#DOWN
		for m in 1..7
			if piece_here?([@position[0], (@position[1] - m)])
				if (@color == "♕") && (["♚", "♛", "♝", "♞", "♜", "♟"].include? piece([@position[0], (@position[1] - m)]).color)
					@moves << [@position[0], (@position[1] - m)]
				elsif (@color == "♛") && (["♔", "♕", "♗", "♘", "♖", "♙"].include? piece([@position[0], (@position[1] - m)]).color)
					@moves << [@position[0], (@position[1] - m)]
				end
				break
			elsif (($coords.include? [@position[0], (@position[1] - m)]) == false)
				break
			end
			@moves << [@position[0], (@position[1] - m)]
		end
		#LEFT-DOWN
		for n in 1..7
			if piece_here?([(@position[0] - n), @position[1] - n])
				if (@color == "♕") && (["♚", "♛", "♝", "♞", "♜", "♟"].include? piece([(@position[0] - n), @position[1] - n]).color)
					@moves << [(@position[0] - n), @position[1] - n]
				elsif (@color == "♛") && (["♔", "♕", "♗", "♘", "♖", "♙"].include? piece([(@position[0] - n), @position[1] - n]).color)
					@moves << [(@position[0] - n), @position[1] - n]
				end
				break
			elsif (($coords.include? [(@position[0] - n), @position[1] - n]) == false)
				break
			end
			@moves << [(@position[0] - n), @position[1] - n]
		end
		#LEFT
		for o in 1..7
			if piece_here?([(@position[0] - o), @position[1]])
				if (@color == "♕") && (["♚", "♛", "♝", "♞", "♜", "♟"].include? piece([(@position[0] - o), @position[1]]).color)
					@moves << [(@position[0] - o), @position[1]]
				elsif (@color == "♛") && (["♔", "♕", "♗", "♘", "♖", "♙"].include? piece([(@position[0] - o), @position[1]]).color)
					@moves << [(@position[0] - o), @position[1]]
				end
				break
			elsif (($coords.include? [(@position[0] - o), @position[1]]) == false)
				break
			end
			@moves << [(@position[0] - o), @position[1]]
		end
		#LEFT-UP
		#p prints so we skip p
		for q in 1..7
			if piece_here?([(@position[0] - q), (@position[1] + q)])
				if (@color == "♕") && (["♚", "♛", "♝", "♞", "♜", "♟"].include? piece([(@position[0] - q), (@position[1] + q)]).color)
					@moves << [(@position[0] - q), (@position[1] + q)]
				elsif (@color == "♛") && (["♔", "♕", "♗", "♘", "♖", "♙"].include? piece([(@position[0] - q), (@position[1] + q)]).color)
					@moves << [(@position[0] - q), (@position[1] + q)]
				end
				break
			elsif (($coords.include? [(@position[0] - q), (@position[1] + q)]) == false)
				break
			end
			@moves << [(@position[0] - q), (@position[1] + q)]
		end
		if ($all.count {|z| z.position == spot}) >= 2
			@moves.clear
		end
	end
	def capture
		if @color == "♛"
			@position = [8,0]
		elsif @color == "♕"
			@position = [8,1]
		end
	end
	
end

class Bishop
	attr_accessor :position, :color, :moves
	def initialize(position, color, moves=[])
		@position = position
		@color = color
		@moves = moves
	end
	def set_spot(spot=@position)
		@position = spot
		@moves = Array.new
		#RIGHT-UP
		for i in 1..7
			if piece_here?([@position[0] + i, (@position[1] + i)])
				if (@color == "♗") && (["♚", "♛", "♝", "♞", "♜", "♟"].include? piece([@position[0] + i, (@position[1] + i)]).color)
					@moves << [@position[0] + i, (@position[1] + i)]
				elsif (@color == "♝") && (["♔", "♕", "♗", "♘", "♖", "♙"].include? piece([@position[0] + i, (@position[1] + i)]).color)
					@moves << [@position[0] + i, (@position[1] + i)]
				end
				break
			elsif (($coords.include? [@position[0] + i, (@position[1] + i)]) == false)
				break
			end
			@moves << [@position[0] + i, (@position[1] + i)]
		end
		#RIGHT-DOWN
		for j in 1..7
			if piece_here?([@position[0] + j, (@position[1] - j)])
				if (@color == "♗") && (["♚", "♛", "♝", "♞", "♜", "♟"].include? piece([@position[0] + j, (@position[1] - j)]).color)
					@moves << [@position[0] + j, (@position[1] - j)]
				elsif (@color == "♝") && (["♔", "♕", "♗", "♘", "♖", "♙"].include? piece([@position[0] + j, (@position[1] - j)]).color)
					@moves << [@position[0] + j, (@position[1] - j)]
				end
				break
			elsif (($coords.include? [@position[0] + j, (@position[1] - j)]) == false)
				break
			end
			@moves << [@position[0] + j, (@position[1] - j)]
		end
		#LEFT-DOWN
		for k in 1..7
			if piece_here?([(@position[0] - k), @position[1] - k])
				if (@color == "♗") && (["♚", "♛", "♝", "♞", "♜", "♟"].include? piece([(@position[0] - k), @position[1] - k]).color)
					@moves << [(@position[0] - k), @position[1] - k]
				elsif (@color == "♝") && (["♔", "♕", "♗", "♘", "♖", "♙"].include? piece([(@position[0] - k), @position[1] - k]).color)
					@moves << [(@position[0] - k), @position[1] - k]
				end
				break
			elsif (($coords.include? [(@position[0] - k), @position[1] - k]) == false)
				break
			end
			@moves << [(@position[0] - k), @position[1] - k]
		end
		#LEFT-UP
		for l in 1..7
			if piece_here?([(@position[0] - l), (@position[1] + l)])
				if (@color == "♗") && (["♚", "♛", "♝", "♞", "♜", "♟"].include? piece([(@position[0] - l), (@position[1] + l)]).color)
					@moves << [(@position[0] - l), (@position[1] + l)]
				elsif (@color == "♝") && (["♔", "♕", "♗", "♘", "♖", "♙"].include? piece([(@position[0] - l), (@position[1] + l)]).color)
					@moves << [(@position[0] - l), (@position[1] + l)]
				end
				break
			elsif (($coords.include? [(@position[0] - l), (@position[1] + l)]) == false)
				break
			end
			@moves << [(@position[0] - l), (@position[1] + l)]
		end
		if ($all.count {|z| z.position == spot}) >= 2
			@moves.clear
		end
	end
	def capture
		if @color == "♝"
			@position = [8,0]
		elsif @color == "♗"
			@position = [8,1]
		end
	end
end

class Knight
	attr_accessor :position, :color, :moves
	def initialize(position, color, moves=[])
		@position = position
		@color = color
		@moves = moves
	end
	def set_spot(spot=@position)
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
		if ($all.count {|z| z.position == spot}) >= 2
			@moves.clear
		end
	end
	def capture
		if @color == "♞"
			@position = [8,0]
		elsif @color == "♘"
			@position = [8,1]
		end
	end
end

class Rook
	attr_accessor :position, :color, :moves, :moved
	def initialize(position, color, moves=[])
		@position = position
		@color = color
		@moves = moves
		@moved = false
	end
	def set_spot(spot=@position)
		@position = spot
		@moves = Array.new
		#UP
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
		#DOWN
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
		#RIGHT
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
		#LEFT
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
		if ($all.count {|z| z.position == spot}) >= 2
			@moves.clear
		end
	end
	def capture
		if @color == "♜"
			@position = [8,0]
		elsif @color == "♖"
			@position = [8,1]
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
	def set_spot(spot=@position)
		@moves = Array.new
		@position = spot
		if @position[1] == 7
			@color = "♛"
		end
		if (@position[1] == 0) && (@position[0] != 8)
			@color = "♕"
		end
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
		#########This code will only engage as a result of pawn promotion#########
		if (@color == "♕") || (@color == "♛")
			#UP
			for i in 1..7
				if piece_here?([@position[0], (@position[1] + i)])
					if (@color == "♕") && (["♚", "♛", "♝", "♞", "♜", "♟"].include? piece([@position[0], (@position[1] + i)]).color)
						@moves << [@position[0], (@position[1] + i)]
					elsif (@color == "♛") && (["♔", "♕", "♗", "♘", "♖", "♙"].include? piece([@position[0], (@position[1] + i)]).color)
						@moves << [@position[0], (@position[1] + i)]
					end
					break
				elsif (($coords.include? [@position[0], (@position[1] + i)]) == false)
					break
				end
				@moves << [@position[0], (@position[1] + i)]
			end
			#RIGHT-UP
			for j in 1..7
				if piece_here?([@position[0] + j, (@position[1] + j)])
					if (@color == "♕") && (["♚", "♛", "♝", "♞", "♜", "♟"].include? piece([@position[0] + j, (@position[1] + j)]).color)
						@moves << [@position[0] + j, (@position[1] + j)]
					elsif (@color == "♛") && (["♔", "♕", "♗", "♘", "♖", "♙"].include? piece([@position[0] + j, (@position[1] + j)]).color)
						@moves << [@position[0] + j, (@position[1] + j)]
					end
					break
				elsif (($coords.include? [@position[0] + j, (@position[1] + j)]) == false)
					break
				end
				@moves << [@position[0] + j, (@position[1] + j)]
			end
			#RIGHT
			for k in 1..7
				if piece_here?([(@position[0] + k), @position[1]])
					if (@color == "♕") && (["♚", "♛", "♝", "♞", "♜", "♟"].include? piece([(@position[0] + k), @position[1]]).color)
						@moves << [(@position[0] + k), @position[1]]
					elsif (@color == "♛") && (["♔", "♕", "♗", "♘", "♖", "♙"].include? piece([(@position[0] + k), @position[1]]).color)
						@moves << [(@position[0] + k), @position[1]]
					end
					break
				elsif (($coords.include? [(@position[0] + k), @position[1]]) == false)
					break
				end
				@moves << [(@position[0] + k), @position[1]]
			end
			#RIGHT-DOWN
			for l in 1..7
				if piece_here?([@position[0] + l, (@position[1] - l)])
					if (@color == "♕") && (["♚", "♛", "♝", "♞", "♜", "♟"].include? piece([@position[0] + l, (@position[1] - l)]).color)
						@moves << [@position[0] + l, (@position[1] - l)]
					elsif (@color == "♛") && (["♔", "♕", "♗", "♘", "♖", "♙"].include? piece([@position[0] + l, (@position[1] - l)]).color)
						@moves << [@position[0] + l, (@position[1] - l)]
					end
					break
				elsif (($coords.include? [@position[0] + l, (@position[1] - l)]) == false)
					break
				end
				@moves << [@position[0] + l, (@position[1] - l)]
			end
			#DOWN
			for m in 1..7
				if piece_here?([@position[0], (@position[1] - m)])
					if (@color == "♕") && (["♚", "♛", "♝", "♞", "♜", "♟"].include? piece([@position[0], (@position[1] - m)]).color)
						@moves << [@position[0], (@position[1] - m)]
					elsif (@color == "♛") && (["♔", "♕", "♗", "♘", "♖", "♙"].include? piece([@position[0], (@position[1] - m)]).color)
						@moves << [@position[0], (@position[1] - m)]
					end
					break
				elsif (($coords.include? [@position[0], (@position[1] - m)]) == false)
					break
				end
				@moves << [@position[0], (@position[1] - m)]
			end
			#LEFT-DOWN
			for n in 1..7
				if piece_here?([(@position[0] - n), @position[1] - n])
					if (@color == "♕") && (["♚", "♛", "♝", "♞", "♜", "♟"].include? piece([(@position[0] - n), @position[1] - n]).color)
						@moves << [(@position[0] - n), @position[1] - n]
					elsif (@color == "♛") && (["♔", "♕", "♗", "♘", "♖", "♙"].include? piece([(@position[0] - n), @position[1] - n]).color)
						@moves << [(@position[0] - n), @position[1] - n]
					end
					break
				elsif (($coords.include? [(@position[0] - n), @position[1] - n]) == false)
					break
				end
				@moves << [(@position[0] - n), @position[1] - n]
			end
			#LEFT
			for o in 1..7
				if piece_here?([(@position[0] - o), @position[1]])
					if (@color == "♕") && (["♚", "♛", "♝", "♞", "♜", "♟"].include? piece([(@position[0] - o), @position[1]]).color)
						@moves << [(@position[0] - o), @position[1]]
					elsif (@color == "♛") && (["♔", "♕", "♗", "♘", "♖", "♙"].include? piece([(@position[0] - o), @position[1]]).color)
						@moves << [(@position[0] - o), @position[1]]
					end
					break
				elsif (($coords.include? [(@position[0] - o), @position[1]]) == false)
					break
				end
				@moves << [(@position[0] - o), @position[1]]
			end
			#LEFT-UP
			#p prints so we skip p
			for q in 1..7
				if piece_here?([(@position[0] - q), (@position[1] + q)])
					if (@color == "♕") && (["♚", "♛", "♝", "♞", "♜", "♟"].include? piece([(@position[0] - q), (@position[1] + q)]).color)
						@moves << [(@position[0] - q), (@position[1] + q)]
					elsif (@color == "♛") && (["♔", "♕", "♗", "♘", "♖", "♙"].include? piece([(@position[0] - q), (@position[1] + q)]).color)
						@moves << [(@position[0] - q), (@position[1] + q)]
					end
					break
				elsif (($coords.include? [(@position[0] - q), (@position[1] + q)]) == false)
					break
				end
				@moves << [(@position[0] - q), (@position[1] + q)]
			end
		end
		if ($all.count {|z| z.position == spot}) >= 2
			@moves.clear
		end
	end
	def capture
		if @color == "♟"
			@position = [8,0]
		elsif @color == "♙"
			@position = [8,1]
		elsif @color == "♛"
			@color = "♟"
			@position = [8,0]
		elsif @color == "♕"
			@color = "♙"
			@position = [8,1]
		end
	end
end

##############METHODS FOR THE PROCESS#####################

def new_game
	puts "Welcome to the wonderful game of chess!"
	if Dir.entries("save").length > 2
		puts "You have unfinished games!"
		puts "\n"
		save_dir = Dir.entries("save")
		save_dir.each {|x| puts x.chomp(".yaml") + "\n" unless (x == ".") || (x == "..") || (x == ".ignoreme")}
		puts "\n"
		puts "Type the name of the game you want to resume, or type NEW to make a new one!"
		print "File: "
		file_name = gets.chomp
		if file_name == "NEW"
			puts "What would you like to name your new game?"
			print "Name: "
			game_name = gets.chomp.downcase
			if Dir.entries("save").include? (game_name + ".yaml")
				while Dir.entries("save").include? (game_name + ".yaml")
					puts "Game name already exists! Please try again!"
					print "Name: "
					game_name = gets.chomp.downcase
				end
			end
			$game = Game.new(game_name)
		elsif save_dir.include? file_name + ".yaml"
			$game = YAML.load(File.read( "save/" + file_name + ".yaml"))
			$all = $game.all
			$coords = $game.coords
		end
	else
		puts "What would you like to name your new game?"
		print "Name: "
		game_name = gets.chomp.downcase
		if Dir.entries("save").include? (game_name + ".yaml")
			while Dir.entries("save").include? (game_name + ".yaml")
				puts "Game name already exists! Please try again!"
				print "Name: "
				game_name = gets.chomp.downcase
			end
		end
		$game = Game.new(game_name)
	end
end

def white_turn
	if $game.turn == "white"
		$game.show_board
		puts "It's white's turn, please input your move in the letter-number format i.e e2e4."
		puts "You can also put SAVE to save & quit or QUIT to quit without saving."
		if $game.w_check? == true
			puts "You are in check!"
		end
		print "Your move: "
		string = gets.chomp
		if string == "QUIT"
			puts "Goodbye!"
			exit
		elsif string == "SAVE"
			$game.all = $all
			$game.coords = $coords
			game_dump = YAML.dump($game)
			File.new("save/" + $game.game_name + ".yaml", "w").write(game_dump)
			exit
		elsif string == "O-O"
			$game.castle("white", "right")
		elsif string == "O-O-O"
			$game.turn = "black"
			$game.castle("white", "left")
			$game.turn = "black"
		elsif string.length == 4
			letters = ["a", "b", "c", "d", "e", "f", "g", "h"]
			numbers = ["1", "2", "3", "4", "5", "6", "7", "8"]
			if (letters.include? string[0]) && (letters.include? string[2]) && (numbers.include? string[1]) && (numbers.include? string[3])
				start = Array.new
				dest = Array.new
				start << letters.index(string[0])
				start << numbers.index(string[1])
				dest << letters.index(string[2])
				dest << numbers.index(string[3])
				if piece_here?(start) == true
					if ["♚", "♛", "♝", "♞", "♜", "♟"].include? piece(start).color
						if piece(start).moves.include? dest
							piece(start).position = [8, 2]
							$all.each {|x| x.set_spot}
							if $game.w_check? == true
								piece([8, 2]).position = start
								$all.each {|x| x.set_spot}
								system "clear"
								puts "ERROR!!!! This would put your king in check!!!"
								white_turn
							else
								if piece_here?(dest)
									piece(dest).capture
								end
								piece([8, 2]).position = dest
								$all.each {|x| x.set_spot}
								if ["♜", "♚"].include? piece(dest).color
									piece(dest).moved = true
								end
								$game.turn = "black"
								system "clear"
								puts "Piece moved"
							end

							if $game.checkmate? == true
								system "clear"
								puts "White has checkmated black!"
								$game.show_board
								exit
							end
						else
							system "clear"
							puts "Your destination was not valid!"
							white_turn
						end
					else
						system "clear"
						puts "You can't move your enemy's piece!"
						white_turn
					end
				else
					system "clear"
					puts "There's nothing at your start point!"
					white_turn
				end
			else
				system "clear"
				puts "ERROR!!! Wrong format!"
				white_turn
			end
		else
			system "clear"
			puts "ERROR!!! Please put it in the correct format. (O-O-O or O-O for castling)"
			white_turn
		end
	end
end

def black_turn
	if $game.turn == "black"
		$game.show_board
		puts "It's black's turn, please input your move in the letter-number format i.e e7e6."
		puts "You can also put SAVE to save & quit or QUIT to quit without saving."
		if $game.b_check? == true
			puts "You are in check!"
		end
		print "Your move: "
		string = gets.chomp
		if string == "QUIT"
			puts "Goodbye!"
			exit
		elsif string == "SAVE"
			$game.all = $all
			$game.coords = $coords
			game_dump = YAML.dump($game)
			File.new("save/" + $game.game_name + ".yaml", "w").write(game_dump)
			exit
		elsif string == "O-O"
			$game.castle("black", "right")
			$game.turn = "white"
		elsif string == "O-O-O"
			$game.turn = "white"
			$game.castle("black", "left")
		elsif string.length == 4
			letters = ["a", "b", "c", "d", "e", "f", "g", "h"]
			numbers = ["1", "2", "3", "4", "5", "6", "7", "8"]
			if (letters.include? string[0]) && (letters.include? string[2]) && (numbers.include? string[1]) && (numbers.include? string[3])
				start = Array.new
				dest = Array.new
				start << letters.index(string[0])
				start << numbers.index(string[1])
				dest << letters.index(string[2])
				dest << numbers.index(string[3])
				if piece_here?(start) == true
					if ["♔", "♕", "♗", "♘", "♖", "♙"].include? piece(start).color
						if piece(start).moves.include? dest
							piece(start).position = [8, 2]
							$all.each {|x| x.set_spot}
							if $game.w_check? == true
								piece([8, 2]).position = start
								$all.each {|x| x.set_spot}

								system "clear"
								puts "ERROR!!!! This would put your king in check!!!"
								black_turn
							else
								if piece_here?(dest)
									piece(dest).capture
								end
								piece([8, 2]).position = dest
								$all.each {|x| x.set_spot}
								if ["♖", "♔"].include? piece(dest).color
									piece(dest).moved = true
								end
								$game.turn = "white"
								system "clear"
								puts "Piece moved"
							end

							if $game.checkmate? == true

								system "clear"
								puts "Black has checkmated white!"
								$game.show_board
								exit
							end
						else
							system "clear"
							puts "Your move was not valid!"
							black_turn
						end
					else
						system "clear"
						puts "You can't move your enemy's piece!"
						black_turn
					end
				else
					system "clear"
					puts "There's nothing at your start point!"
					black_turn
				end
			else
				system "clear"
				puts "ERROR!!! Wrong format!"
				black_turn
			end
		else
			system "clear"
			puts "ERROR!!! Please put it in the correct format. (O-O-O or O-O for castling)"
			black_turn
		end
	end
end


new_game

while 1
	white_turn
	black_turn
end