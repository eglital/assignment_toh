# Welcome to Tower of Hanoi!
# Instructions:
# Enter where you'd like to move from and to
# in the format '1,3'. Enter 'q' to quit.
# Current Board:
# o
# oo
# ooo
# 1    2    3
# Enter move >
# ...
class TowerofHanoi
  def initialize(height)
    @towers = height
    @board = [(1..@towers).to_a, [], []]
    @original = @board[0].dup
    @player_input = ""
    @player_move = []
  end

  def render
    puts "Current board: "
    puts @board.inspect
  end

  def is_valid?
    if @player_input == "q"
      exit
    end
    @player_move = @player_input.split(',')
    if @player_move.length == 2
      @player_move = @player_move.map { |e|  e.to_i }
    else
      puts "Please enter the move in the format '1,3'."
      return false
    end
    if @player_move.all?{ |item| item >= 1 && item <= 3 }
      if @board[@player_move[1] - 1].empty?
        return true
      elsif @board[@player_move[0]-1].empty?
        puts "You can not move a disk from an empty row."
        return false
      elsif @board[@player_move[1]-1][0] > @board[@player_move[0]-1][0]
        return true
      else
        puts "Larger disk can not go on top of the smaller disk. Please re-enter your move."
        return false
      end
    else
      puts "The moves can be only between 1 and 3."
      return false
    end
  end

  def get_user_input
    until is_valid?
      puts "Enter move: "
      puts "> "
      @player_input = gets.chomp
    end
  end

  def move
    @board[@player_move[1]-1].unshift(@board[@player_move[0]-1].shift)
    @player_input = ""
    @player_move = []
  end

  def check_win?
    @board[1] == @original || @board[2] == @original
  end

  def play

    puts "Welcome to Tower of Hanoi!"
    puts "Instructions:"
    puts "Enter where you'd like to move from and toin the format '1,3'. Enter 'q' to quit."
    render

    until check_win? 
      get_user_input

      move
      render

      puts "Congratulations! You won!" if check_win?

    end
    exit
  end

end

t = TowerofHanoi.new(3)
t.play