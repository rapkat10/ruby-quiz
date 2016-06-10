#!/usr/bin/env ruby

# array containing the raw list of words
words = Array.new

# array of duplicate 4 letter chunks
duplicates = Array.new

# hash containing :question => :answer
results = Hash.new

File.open("words") do |file|
  file.each do |line|
    word = line.chomp.downcase
    words.push(word)
  end
end

words.each do |word|
  # Only add the words which are longer than four characters
  if word.length >= 4
    chunks_remaining = word.length - 3
    while(chunks_remaining > 0)
      starting_index = chunks_remaining - 1
      chunk = word[starting_index,4]
      if duplicates.include?(chunk)
        # We've already seen this chunk at least once before.
        # Do nothing - move on to the next chunk
      elsif results.has_key?(chunk)
        # We've seen this chunk once before. Remove it from the results,
        # and add it to the duplicates for easy lookup.
        results.delete(chunk)
        duplicates.push(chunk)
      else
        # First time seeing this chunk - add it to the results!
        results[chunk] = word
      end
      chunks_remaining = chunks_remaining - 1
    end
  end
end

# Open our output files
questions = File.new("questions.txt", "w")
answers = File.new("answers.txt", "w")

# Write the output files
results.each do |question,answer|
  questions.puts question
  answers.puts answer
end

# Clean up
questions.close
answers.close