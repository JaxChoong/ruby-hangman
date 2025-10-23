require_relative "lib/game_state"
require "yaml"
require "colorize"

def load_game
  # load saved game
  if File.exist?("game_state.yaml")
    YAML.safe_load_file("game_state.yaml",
                        permitted_classes: [GameState])
  else
    (puts "No saved game! Creating new game.")
  end
end

def save_game(current_state)
  yaml_string = YAML.dump(current_state)
  File.write("game_state.yaml", yaml_string)
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
  GameState.new(secret_word, guessed)
end

def input_letter
  print "Guess a letter: "
  letter = gets.chomp.downcase
  until letter.length == 1
    print "#{"Invalid input! \n".colorize(:red)}Guess a letter: "
    letter = gets.chomp.downcase
  end
  letter
end

def play_turn(current_state)
  current_state.print_man
  print "Current guess: #{current_state.guessed}\n"
  print "Save Game? (Y/N): "
  save = gets.chomp.upcase
  save_game(current_state) if save == "Y"
  letter = input_letter
  current_state.check_letter(letter)
end

def display_end_game(current_state)
  if current_state.guessed == current_state.secret_word
    print("Congratulations! You won!\n")
  else
    current_state.print_man
    print("Game Over! You lose!\n")
  end
end

def main
  print "Load saved game? (Y/N): "
  load_saved = gets.chomp.upcase
  current_state = load_saved == "Y" ? load_game : create_game

  play_turn(current_state) until current_state.game_ended?
  display_end_game(current_state)
end

main
