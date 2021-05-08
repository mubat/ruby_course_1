# frozen_string_literal: true

# Create hash with letter and it position number

hash_entity = {}

vowels = ["a","e","i","o","u"]
counter = 1
("a".."z").each do |letter|
  if vowels.include? letter
    hash_entity[letter] = counter
  end
  counter += 1
end

hash_entity.each { |k, v| puts k + " " + v.to_s }
