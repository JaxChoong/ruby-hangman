words = []
File.open("google-10000-english-no-swears.txt", "r") do |file|
  file.each_line do |line|
    words << line if line.chomp.length.between?(5, 12)
  end
end

secret_word = words[rand(words.length)].chomp
p secret_word
