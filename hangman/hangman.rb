class Hangman
  def gallows
    lines = []
    lines[0] = "  +---+"
    lines[1] = "  |   |"
    lines[2] = "      |"
    lines[3] = "      |"
    lines[4] = "      |"
    lines[5] = "      |"
    lines[6] = "========="
    lines
  end

  def head
    head = gallows
    head[2] = "  o   |"
    head
  end

  def body
    body = head
    body[3] = "  |   |"
    body
  end

  def left_arm
    left_arm = body
    left_arm[3] = " \\|   |"
    left_arm
  end

  def right_arm
    right_arm = left_arm
    right_arm[3] = " \\|/  |"
    right_arm
  end

  def left_leg
    left_leg = right_arm
    left_leg[4] = " /    |"
    left_leg
  end

  def right_leg
    right_leg = left_leg
    right_leg[4] = " / \\  |"
    right_leg
  end

  def hanged
    [gallows, head, body, left_arm, right_arm, left_leg, right_leg]
  end
end

class Word
  def choose_word
    words = File.read("5desk.txt").split("\n")
    words.select { |word| word.length > 5 && word.length < 12 }
    words.shuffle!
    words[0].upcase.strip
  end
end

class Game
  attr_reader :choosen_word
  def initialize
    @choosen_word = Word.new.choose_word.split(//)
  end

  def word(guesses)
    word = @choosen_word.map do |letter|
      unless guesses.any? { |guess| guess == letter } 
        letter = "_"
      else 
        letter
      end
    end
    word.join(" ")
  end
end

game = Game.new
guesses = []
false_guesses = []

hangman = Hangman.new
puts hangman.gallows
puts "Word: #{game.word(guesses)}"
try = 0

until !game.word(guesses).include?("_") || try == 6
  print "Guess a letter: "

  guess = gets.chomp
  guesses << guess.upcase
  if game.word(guesses).include?(guess.upcase)
    puts hangman.hanged[try]
    puts "Word: #{game.word(guesses)}"
    puts "False Guesses: #{false_guesses.join(" ") unless false_guesses.empty?}"
  else
    try += 1
    puts hangman.hanged[try]
    puts "Word: #{game.word(guesses)}"
    false_guesses << guess
    puts "False Guesses: #{false_guesses.join(" ")}"
  end
end

if !game.word(guesses).include?("_")
  puts "You won. Congratulations."
else
  puts "Oh no. You lost."
  puts "The word was #{game.choosen_word.join(" ")}."
end



