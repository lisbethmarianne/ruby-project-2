class Game
  attr_reader :output
  def initialize
    @code = [rand(0..9),rand(0..9),rand(0..9),rand(0..9)]
    @output = [" Your guess | correct numbers | correct positions"]
  end

  def correct_numbers
    corr = 0
    check = []
    @code.each { |num| check << num }
    @guess.each do |num|
      if check.include?(num)
        corr +=1 
        check.delete_at(check.index(num))
      end
    end
    corr
  end

  def correct_position
    corr = 0
    @code.each_with_index { |num, ix| corr += 1 if num == @guess[ix] }
    corr
  end

  def winner?
    @code == @guess
  end

  def end?
    @output.length == 13
  end

  def end_of_game
    if winner?
      "Congratulations!"
    else
      "Sorry, try again. The correct code was #{@code}"
    end
  end

  def play
    print "Guess a code with 4 numbers between 0 and 9: "
    input = gets.chomp
    if input.length == 4
      @guess = input.split(//).map { |num| num.to_i }
      @output << "#{@guess}".ljust(15) + "#{correct_numbers}".center(18) + "#{correct_position}".center(18)
    end
  end
end

game = Game.new

until game.winner? || game.end?
  game.play
  game.output.each { |line| puts line }
end

puts game.end_of_game