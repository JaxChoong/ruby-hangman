class Game_state
  attr_accessor :secret_word, :guessed, :mistake_count
  def initialize(secret_word,guessed,mistake_count=0)
    @secret_word = secret_word
    @guessed = guessed
    @mistake_count = mistake_count
  end

  def check_letter(letter)
    found = false
    secret_word.chars.each_with_index do |lett, index|
      if lett == letter
        guessed[index] = letter
        found = true
      end
    end
    unless found
      self.mistake_count += 1
    end
  end

  def game_ended?
    mistake_count == 6 || guessed == secret_word
  end

  def print_man
    print "-+-\n"
    case self.mistake_count
    when 1
      print " O \n"
    when 2
      print " O \n | \n"
    when 3
      print " O \n/| \n"
    when 4
      print " O \n/|\\ \n"
    when 5
      print " O \n/|\\\n/"
    when 6
      print " O \n/|\\\n/ \\ \n"
    else
      nil
    end
  end
end