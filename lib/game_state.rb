class Game_state
  attr_accessor :secret_word, :guessed, :mistake_count
  def initialize(secret_word,guessed,mistake_count=0)
    @secret_word = secret_word
    @guessed = guessed
    @mistake_count = mistake_count
  end
end