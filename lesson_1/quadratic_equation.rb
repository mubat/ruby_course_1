### Квадратное уравнение. 
# Пользователь вводит 3 коэффициента a, b и с. Программа вычисляет дискриминант (D) и корни
# уравнения (x1 и x2, если они есть) и выводит значения дискриминанта и корней на экран. При
# этом возможны следующие варианты:
#   Если D > 0, то выводим дискриминант и 2 корня
#   Если D = 0, то выводим дискриминант и 1 корень (т.к. корни в этом случае равны)
#   Если D < 0, то выводим дискриминант и сообщение "Корней нет"

def fillValue(valueName)
	puts "Введите \"#{valueName}\":"
	value = gets.chomp.to_i
	if value == nil
		puts "Некоректное значение. Прощайте."
		exit
	end
	return value
end

def processDiscriminant(b, a, c)
	return b * b - 4 * a * c
end

def processResult(a, b, discriminant, isAddRadical = true)
	return -b + (isAddRadical ? 1 : -1)*Math.sqrt(discriminant)/2.0*a
end

a = fillValue('a')
b = fillValue('b')
c = fillValue('c')

discriminant = processDiscriminant(b, a, c)
if discriminant < 0
	puts "Корней нет"
elsif discriminant == 0
	puts "D = #{discriminant}, x1 = x2 = #{-b/2.0*a}"
elsif discriminant > 0
	puts "D = #{discriminant}, x1 = #{processResult(a,b,discriminant)}, x2 = #{processResult(a,b,discriminant, false)}"
	
end


