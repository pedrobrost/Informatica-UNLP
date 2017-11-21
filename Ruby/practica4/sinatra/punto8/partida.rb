class Partida

  def initialize(word)
    @word = word
    @tries = 3
    @guessed = []
  end

  def summary
    self.check_win do
      s = "Ahorcado \n\n"
      s << @guessed.to_s << "\n"
      s << "Fallidos: " + (3 - @tries).to_s << "\n"
      s << "Restantes: " + @tries.to_s << "\n"
    end
  end

  def try(char)
    self.check_win do
      if (!@guessed.include?(char) && @word.include?(char))
        @guessed.push char
      else
        @tries -= 1
      end
    end
  end

  def check_win
    if (@tries > 0 && !self.guessed?)
      yield
    elsif (self.guessed?)
      "Ganaste!\n"
    else
      "Perdiste :(\n"
    end
  end

  def guessed?
    @word.size == @guessed.size
  end


end
