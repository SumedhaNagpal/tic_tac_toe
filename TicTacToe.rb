def startGame
	puts "Enter size of grid"
	n=gets.to_i
	if n==0 
		n=startGame
	end
	return n
end

class Player
	attr_accessor :name, :symbol
	def initialize(symbol, name)
		@name=name
		@symbol=symbol
	end
end

class Board
	attr_accessor :size
	def initialize n
		@size=n
		@board=Array.new(size) {Array.new(size, " ")}
	end

	def printBoard 	
		(0..@size-1).each do |i|
			for j in (0..@size-1)
				print"   #{@board[i][j]}    "
				print" | " unless j==@size-1
			end
			puts "\n"		
			for j in (0..@size-1)
				print "----------" unless i==@size-1
			end
			puts "\n"
		end
		puts "\n"
	end

	def printBoardFirst	
		for i in (0..@size-1)
			for j in (0..@size-1)
				print"      #{i*size + (j+1)}      "
				print" | " unless j==@size-1
			end
			puts "\n"		
			for j in (0..@size-1)
				print "---------------" unless i==@size-1
			end
			puts "\n"
		end
		puts "\n"
	end

	def status 
		#rows
		(0..@size-1).each do |i|
			
			if(@board[i][0]=="x")
				j=0
				while j<@size && @board[i][j]=="x"
					j+=1
				end
				if j==@size
					return @board[i][0]
				end			
			elsif(@board[i][0]=="o")
				j=0
				while j<@size && @board[i][j]=="o"
					j+=1
				end
				if j==@size
					return @board[i][0]
				end
			end
		end

		#columns
		(0..@size-1).each do |j|
			if @board[0][j]=="x"
				i=0
				while i<@size && @board[i][j]=="x"
					i+=1
				end
				if i==@size
					return @board[0][j]
				end
			elsif @board[0][j]=="o"
				i=0
				while i<@size && @board[i][j]=="o"
					i+=1
				end
				if i==@size
					return @board[0][j]
				end
			end
		end

		#diagonals	
		if @board[0][0]==@board[1][1]
			i=0
			if @board[0][0]=="x"
				while i<@size && @board[i][i]==@board[0][0]
					i+=1
				end
				if i==@size
					return @board[0][0]	
				end
			elsif @board[0][0]=="o"
				while i<@size && @board[i][i]==@board[0][0]
					i+=1
				end
				if i==@size
					return @board[0][0]	
				end
			end
		end

		if @board[0][@size-1]==@board[1][@size-2]
			if(@board[0][@size-1]=="x")
				i=0
				while i<@size && @board[i][@size-1-i]==@board[0][@size-1]
					i+=1
				end
				if i==@size
					return @board[0][@size-1]
				end
			elsif(@board[0][@size-1]=="o")
				i=0
				while i<@size && @board[i][@size-1-i]==@board[0][@size-1]
					i+=1
				end
				if i==@size
					return @board[0][@size-1]
				end
			end
		end

		#checkTie
		return "c" unless isTie

		#game is tied
		return false
	end

	def isTie
		return @board.join.split('').include?(" ")		#returns true when game is not tied
	end


	def makeMove symbol, move
		if validMove(move)
			x = (move-1)/@size
			y = (move % @size) - 1
			@board[x][y]=symbol 
			return true
		else
			puts "Invalid Move"
			return false
		end
	end	

	def validMove move
		x = (move-1)/@size
		y = (move % @size) - 1
		if x>=@size || y>=@size 
			then return false
		end
		return @board[x][y]==" " && move<=@size*@size && move>=0
	end
end




############################################################################################



puts "Enter first player's name"
name1 = gets
p1=Player.new('x', name1.chomp)
puts "Enter second player's name"
name2 = gets
p2=Player.new('o', name2.chomp)
n=startGame

board=Board.new(n)

board.printBoardFirst

p1_turn=true
puts board.status

while not board.status
	done=false
	if(p1_turn) 
		print "#{p1.name}'s turn. Enter cell.\n"
		move = gets.to_i
		unless move==0 
		 	done=board.makeMove(p1.symbol, move)
		end
	else 
		print "#{p2.name}'s turn. Enter cell.\n"
		move = gets.to_i
		unless move==0 
			done=board.makeMove(p2.symbol, move)
		end
	end
	if(done)
		board.printBoard
		p1_turn=!p1_turn
	end
end


if board.status=="x"
	puts "#{p1.name} Won!"
elsif board.status=="o"
	puts"#{p2.name} Won!"
elsif board.status=="c"
	puts "Game Over"
end

