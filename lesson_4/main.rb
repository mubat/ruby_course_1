# Создать программу в файле main.rb, которая будет позволять пользователю через текстовый интерфейс делать следующее:
  # - Создавать станции
  # - Создавать поезда
  # - Создавать маршруты и управлять станциями в нем (добавлять, удалять)
  # - Назначать маршрут поезду
  # - Добавлять вагоны к поезду
  # - Отцеплять вагоны от поезда
  # - Перемещать поезд по маршруту вперед и назад
  # - Просматривать список станций и список поездов на станции
def add_station
  puts "Здесь будет добавляться станция" #TODO implement
end


menu_def = [
  {'label' => "Добавить станцию", 'action' => :add_station}
]

def print_menu(menu_def)
  puts "Выберите одно из действий:"
  i = 0
  menu_def.each do |menu_item|
    puts "\t#{i+1}. #{menu_item['label']}"
  end
  puts "Чтобы выйти из приложения, введите абракадабру."
end

loop do
  print_menu menu_def
  
  choise = gets.chomp.to_i
  puts "Выбрано: #{choise.to_s}";
  if(menu_def[choise-1].nil?)
    break
  end
  
  method(menu_def[choise-1]['action']).call
  
end

puts "Приложение завершило работу."