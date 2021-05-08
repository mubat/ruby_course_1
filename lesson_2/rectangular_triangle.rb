### Right triangle.

puts "Введите длины сторон треугольника, каждый на новой строке:"
side1 = gets.to_i
side2 = gets.to_i
side3 = gets.to_i

if !side1.positive? || !side2.positive? || !side3.positive? 
  puts "Неправильное значение. Величина может быть только положительная."
  exit
end


if side1 == side2 && side2 == side3
  puts "Треугольник равнобедренный и равносторонний."
  exit
end

is_usual = true
if side1 == side2 || side2 == side3 || side1 == side3
  is_usual = false
  puts "Треугольник равнобедренный."
end

max_side = [side1, side2, side3].max

if max_side**2 == side1**2 + side2**2  + side3**2 - max_side**2
  is_usual = false
  puts "Треугольник прямоугольный."
end

puts "Попался обычный треугольник." if is_usual