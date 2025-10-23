require_relative "lib/game_state"
require "yaml"
require "colorize"

def load_game
  # load saved game
  saved_game = YAML.load_file("game_state.yaml")

  # if no saved game, create new game
  unless saved_game
    words = []
    File.open("google-10000-english-no-swears.txt", "r") do |file|
      file.each_line do |line|
        words << line if line.chomp.length.between?(5, 12)
      end
    end
    secret_word = words[rand(words.length)].chomp
    guessed = secret_word.gsub(/[a-z]/i, "_")
    current_state = Game_state.new(secret_word, guessed)
  else
    current_state = Game_state.new(saved_game[:secret_word], saved_game[:guessed], saved_game[:mistake_count])
  end
end

def main
  current_state = load_game
  while !current_state.game_ended?
    print "actual word: #{current_state.secret_word}\n"
    print "Current guess: #{current_state.guessed}\n"
    print "Guess a letter: "
    letter = gets.chomp.downcase
    until letter.length == 1
      print "Invalid input! \n".colorize(:red) +"Guess a letter: "
      letter = gets.chomp.downcase
    end
    current_state.check_letter(letter)
  end
  if current_state.guessed == current_state.secret_word
    print("Congratulatiuons! You won!\n")
  else
    print("Game Over! You lose!\n")
  end
end

main