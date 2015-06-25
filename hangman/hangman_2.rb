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
    left_arm[3] = " /|   |"
    left_arm
  end

  def right_arm
    right_arm = left_arm
    right_arm[3] = " /|\\  |"
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
  attr_reader :guesses, :try, :leave
  def initialize
    @choosen_word = Word.new.choose_word.split(//)
    @guesses = []
    @false_guesses = []
    @try = 0
    @leave = false
  end

  def hangman 
    hangman = Hangman.new
  end

  def word(guesses)
    word = @choosen_word.map do |letter|
      unless @guesses.any? { |guess| guess == letter } 
        letter = "_"
      else 
        letter
      end
    end
    word.join(" ")
  end

  def winner?
    !word(@guesses).include?("_") 
  end

  def lost?
    @try == 6
  end

  def start_output
    system "clear"
    puts "Welcome to HANGMAN. Created by Piri."
    puts "Do you want to open a saved game? (y/n)"
    open = gets.chomp
    if open == "y"
      open_game 
    end
    puts hangman.hanged[@try]
    puts "Word: #{word(@guesses)}"
    puts "False Guesses: #{@false_guesses.join(" ") unless @false_guesses.empty?}"
  end

  def open_game
    puts "Opening old game."
    saved = File.read("saved.txt").split("\n")
  
    @choosen_word = saved[0].split("")
    @guesses = saved[1].split("")
    @false_guesses = saved[2].split("")
    @try = saved.last.to_i
  end

  def play
    print "Guess a letter (or save game by entering 'save'): "

    guess = gets.chomp
    if guess == 'save'
      save_game
      @leave = true
    else
      @guesses << guess.upcase
      if word(@guesses).include?(guess.upcase)
        puts hangman.hanged[@try]
        puts "Word: #{word(@guesses)}"
        puts "False Guesses: #{@false_guesses.join(" ") unless @false_guesses.empty?}"
      else
        @try += 1
        puts hangman.hanged[@try]
        puts "Word: #{word(@guesses)}"
        @false_guesses << guess
        puts "False Guesses: #{@false_guesses.join(" ")}"
      end
    end
  end

  def save_game
    File.open('saved.txt', 'w') do |f|
      f.puts "#{@choosen_word.join('')}\n#{@guesses.join('')}\n#{@false_guesses.join('')}\n#{@try}"
    end
  end

  def final_output
    if winner?
      "You won. Congratulations."
    elsif lost?
      "Oh no. You lost.\nThe word was #{@choosen_word.join(" ")}."
    else
      "Game saved. See you soon. Bye bye."
    end
  end
end

game = Game.new

game.start_output

until game.winner? || game.lost? || game.leave
  game.play
end

puts game.final_output



