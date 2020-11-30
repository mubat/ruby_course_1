# Заполнить хеш гласными буквами, где значением будет являтся порядковый номер буквы в алфавите (a - 1).

hash_entity = {}

vowels = ['a','e','i','o','u']
counter = 1
('a'..'z').each do |letter|
  if vowels.include? letter 
    hash_entity[letter] = counter
  end
  counter += 1
end

hash_entity.each { |k, v| puts k + " " + v.to_s }