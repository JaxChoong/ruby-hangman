require_relative "lib/game_state"
require "yaml"

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

p current_state.secret_word
p current_state.guessed