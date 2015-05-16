class Game
  attr_accessor :guess
  attr_reader :code
  def initialize
    @code = [rand(0..9),rand(0..9),rand(0..9),rand(0..9)]
  end

  def correct_numbers
    corr = 0
    @code.each { |num| corr += 1 if guess.include?(num)}
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
end

game = Game.new

lines = [" Your guess | correct numbers | correct positions"]
until game.winner? || lines.length == 12
  print "Guess a code with 4 numbers between 0 and 9: "
  guess = gets.chomp
  if guess.length == 4
    game.guess = guess.split(//).map { |num| num.to_i }
    lines << "#{game.guess}".ljust(15) + "#{game.correct_numbers}".center(18) + "#{game.correct_position}".center(18)
    lines.each { |line| puts line }
  end
end

if game.winner?
  puts "Congratulations!"
else
  puts "Sorry, try again. The correct code was #{game.code}"
end

