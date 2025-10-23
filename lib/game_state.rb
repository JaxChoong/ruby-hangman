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
end