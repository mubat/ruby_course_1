# frozen_string_literal: true
### Ideal weight.

puts "Как Вас зовут?"
user_name = gets.chomp

puts "Каков ваш рост?"
current_height = gets.chomp.to_i

ideal_weight = (current_height - 110) * 1.15

if ideal_weight.positive?
  puts user_name + ", идеальный вес для Вас #{ideal_weight.round} кг."
else
  puts "Ваш вес уже оптимальный"
end
