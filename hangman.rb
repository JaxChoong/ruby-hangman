require_relative "lib/game_state"
require "yaml"
require "colorize"

def load_game
  # load saved game
  saved_game = File.exist?("game_state.yaml") ? YAML.safe_load_file("game_state.yaml", permitted_classes: [Game_state]) : (puts "No saved game! Creating new game.")
end

def save_game(current_state)
  yaml_string = YAML.dump(current_state)
  File.open("game_state.yaml", "w") do |file|
    file.write(yaml_string)
  end
end

def create_game
  puts "Creating new game..."
  words = []
  File.open("google-10000-english-no-swears.txt", "r") do |file|
    file.each_line do |line|
      words << line if line.chomp.length.between?(5, 12)
    end
  end
  secret_word = words[rand(words.length)].chomp
  guessed = secret_word.gsub(/[a-z]/i, "_")
  Game_state.new(secret_word, guessed)
end
def main
  print "Load saved game? (Y/N): "
  load_saved = gets.chomp.upcase
  # load saved game if selected, else just create new game
  current_state = load_saved == "Y" ? load_game : create_game
  
  while !current_state.game_ended?
    current_state.print_man
    print "Current guess: #{current_state.guessed}\n"
    print "Save Game? (Y/N): "
    save = gets.chomp.upcase
    save_game(current_state) if save == "Y"
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
    current_state.print_man
    print("Game Over! You lose!\n")
  end
end

main