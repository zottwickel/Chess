class Game
	def initialize(game_name)
		@game_name = game_name
		@board = Board.new
		@WK = King.new([4,0],"♚")
		
		@WR1 = Rook.new([7,0], "♜")
		@WR2 = Rook.new([0,0], "♜")
		
		@BK = King.new([4,7],"♔")
		
		@BR1 = Rook.new([7,7], "♖")
		@BR2 = Rook.new([0,7], "♖")
		
		$all = [@WK, @WR1, @WR2, @BK, @BR1, @BR2]
		$b_score = 0
		$w_score = 0
		$all.each {|x| x.set_spot}
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
		if  piece(start).moves.include? destination
			if $coords.include? destination
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
						puts "Piece moved"
					end
				end
			else
				puts "ERROR!!!! your destination isn't valid!"
			end
		else
			puts "ERROR!!!! Your start position isn't a valid!"
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
						puts "Castled"
					end
				end
			else
				puts "Unable to castle there!"
			end
		elsif (color == "white") && (direction == "right")
			if ($all.any? {|x| [[5, 0], [6, 0]].include? x.position}) == false
				if (@WR1.moved == false) && (@WK.moved == false) && (w_check? == false)
					unless $all.any? {|x| ((x.moves.include? [6, 0]) || (x.moves.include? [5, 0])) && (["♔", "♕", "♗", "♘", "♖", "♙"].include? x.color)}
						@WK.position = [6, 0]
						@WR1.position = [5, 0]
						$all.each {|y| y.set_spot}
						puts "Castled"
					end
				end
			else
				puts "Unable to castle there!"
			end
		elsif (color == "black") && (direction == "right")
			if ($all.any? {|x| [[5, 7], [6, 7]].include? x.position}) == false
				if (@BR1.moved == false) && (@BK.moved == false) && (b_check? == false)
					unless $all.any? {|x| ((x.moves.include? [6, 7]) || (x.moves.include? [5, 7])) && (["♚", "♛", "♝", "♞", "♜", "♟"].include? x.color)}
						@BK.position = [6, 7]
						@BR1.position = [5, 7]
						$all.each {|y| y.set_spot}
						puts "Castled"
					end
				end
			else
				puts "Unable to castle there!"
			end
		elsif (color == "black") && (direction == "left")
			if ($all.any? {|x| [[1, 7], [2, 7], [3, 7]].include? x.position} == false)
				if (@BR2.moved == false) && (@BK.moved == false) && (b_check? == false)
					unless $all.any? {|x| ((x.moves.include? [1, 7]) || (x.moves.include? [2, 7]) || (x.moves.include? [3, 7])) && (["♚", "♛", "♝", "♞", "♜", "♟"].include? x.color)}
						@BK.position = [2, 7]
						@BR2.position = [3, 7]
						$all.each {|y| y.set_spot}
						puts "Castled"
					end
				end
			else
				puts "Unable to castle there!"
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
#####################ALL METHODS OUTSIDE GAME######################################
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
			$b_score += 9
		elsif @color == "♕"
			@position = [8,1]
			$w_score += 9
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
			$b_score += 3
		elsif @color == "♗"
			@position = [8,1]
			$w_score += 3
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
			$b_score += 3
		elsif @color == "♘"
			@position = [8,1]
			$w_score += 3
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
	def set_spot(spot=@position)
		@moves = Array.new
		@position = spot
		if @position[1] == 7
			@color = "♛"
		end
		if @position[1] == 0
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
			$b_score += 1
		elsif @color == "♙"
			@position = [8,1]
			$w_score += 1
		elsif @color == "♛"
			@color = "♟"
			$b_score += 1
		elsif @color == "♕"
			@color = "♙"
			@position = [8,1]
			$w_score += 1
		end
	end
end

game = Game.new("test")
game.show_board
