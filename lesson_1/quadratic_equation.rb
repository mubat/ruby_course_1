### Квадратное уравнение. 
# Пользователь вводит 3 коэффициента a, b и с. Программа вычисляет дискриминант (D) и корни
# уравнения (x1 и x2, если они есть) и выводит значения дискриминанта и корней на экран. При
# этом возможны следующие варианты:
#   Если D > 0, то выводим дискриминант и 2 корня
#   Если D = 0, то выводим дискриминант и 1 корень (т.к. корни в этом случае равны)
#   Если D < 0, то выводим дискриминант и сообщение "Корней нет"

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

a = fill_value('a')
b = fill_value('b')
c = fill_value('c')

discriminant = process_discriminant(b, a, c)
if discriminant < 0
  puts "Корней нет"
elsif discriminant == 0
  puts "D = #{discriminant}, x1 = x2 = #{-b / (2.0 * a)}"
elsif discriminant > 0
  puts "D = #{discriminant}, x1 = #{process_result(a,b,discriminant)}, x2 = #{process_result(a,b,discriminant, false)}"
  
end


