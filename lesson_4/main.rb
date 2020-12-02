# Создать программу в файле main.rb, которая будет позволять пользователю через текстовый интерфейс делать следующее:
  # - Создавать станции
  # - Создавать поезда
  # - Создавать маршруты и управлять станциями в нем (добавлять, удалять)
  # - Назначать маршрут поезду
  # - Добавлять вагоны к поезду
  # - Отцеплять вагоны от поезда
  # - Перемещать поезд по маршруту вперед и назад
  # - Просматривать список станций и список поездов на станции
require_relative 'controller'

puts "Чтобы выйти из приложения, в меню введите абракадабру."

controller = Controller.new
loop do
    controller.print_menu
    
    choise = gets.chomp.to_i
    if(!controller.has_action?(choise))
      break
    end
    
    controller.call(choise)

end

puts "Приложение завершило работу."