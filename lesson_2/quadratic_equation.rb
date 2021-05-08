### Quadratic equation.

def fill_value(value_name)
  puts "Введите \"#{value_name}\":"
  value = gets.chomp.to_i
  if value == nil
    puts "Некоректное значение. Прощайте."
    exit
  end
  value
end

def process_discriminant(b, a, c)
  b * b - 4 * a * c
end

def process_result(a, b, discriminant, is_add_radical = true)
	puts "discriminant #{discriminant}"
  (-b + (is_add_radical ? 1 : -1) * Math.sqrt(discriminant)) / (2.0 * a)
end

a = fill_value("a")
b = fill_value("b")
c = fill_value("c")

discriminant = process_discriminant(b, a, c)
if discriminant < 0
  puts "Корней нет"
elsif discriminant == 0
  puts "D = #{discriminant}, x1 = x2 = #{-b / (2.0 * a)}"
elsif discriminant > 0
  puts "D = #{discriminant}, x1 = #{process_result(a,b,discriminant)}, x2 = #{process_result(a,b,discriminant, false)}"

end
