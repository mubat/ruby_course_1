# frozen_string_literal: true

### Triangle square

puts "Введите значение основания: "
a = gets.to_i
puts "Введите значение высоты: "
h = gets.to_i

if a.negative? || h.negative?
  puts "Невозможно вычислить площадь - входные параметры должны быть положительными числами"
  exit(1)
end

puts "Площадь треугольника S = #{1.0 / (2 * a * h)}."
