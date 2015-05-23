class Grid
  def row(content)
    content.map! { |cell| " #{cell} " }
    content.join("|")
  end

  def separator
    "---|---|---"
  end

  def format(cells)
    lines = [
      row(cells[0..2]),
      separator,
      row(cells[3..5]),
      separator,
      row(cells[6..8]),
    ]
    lines.join("\n")
  end
end

class Game
  attr_reader :grid
  def initialize
    @grid = Grid.new
    @cells = [1,2,3,4,5,6,7,8,9]
    @player = [1,2]
    @xo = ["o", "x"]
  end

  def winner?
    wins = [
      [1,2,3],[4,5,6],[7,8,9],
      [1,4,7],[2,5,8],[3,6,9],
      [1,5,9],[3,5,7]
    ]

    wins.map! do |win|
      win.map! do |position|
        @cells[position-1]
      end
    end
    
    if wins.include?(["x","x","x"]) || wins.include?(["o","o","o"])
      true
    else
      false
    end
  end

  def ending?
    @cells.uniq == ["o", "x"]
  end

  def play
    puts grid.format(@cells)
    print "input Player #{@player[0]}: "
    input = gets.chomp
    while @cells[input.to_i - 1] == "o" || @cells[input.to_i - 1] == "x"
      puts "input not valid, new input:"
      input = gets.chomp
    end
    @cells[input.to_i - 1] = "#{@xo[0]}"

    @player.reverse!
    @xo.reverse!
  end

  def final_output
    puts grid.format(@cells)
    if winner?
      puts "Player #{@player[1]} wins."
    elsif ending?
      puts "No possibilities left. No winner."
    end
  end
end

game = Game.new

until game.winner? || game.ending?
  game.play
end

game.final_output
