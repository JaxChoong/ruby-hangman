# Keeps track of game state, as well as functions relating to game loop
class GameState
  HANGMAN_STAGES = [
    "",
    " O ",
    " O \n | ",
    " O \n/| ",
    " O \n/|\\ ",
    " O \n/|\\\n/",
    " O \n/|\\\n/ \\ "
  ].freeze

  attr_accessor :secret_word, :guessed, :mistake_count

  def initialize(secret_word, guessed, mistake_count = 0)
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
    return if found

    self.mistake_count += 1
  end

  def game_ended?
    mistake_count == 6 || guessed == secret_word
  end

  def print_man
    print "-+-\n"
    print "#{HANGMAN_STAGES[mistake_count]}\n"
  end
end
