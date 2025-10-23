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
end

p secret_word
p guessed