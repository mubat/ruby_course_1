# frozen_string_literal: true

# Start point of the program
require_relative "controller"

puts "Чтобы выйти из приложения, в меню введите абракадабру."

controller = Controller.new
loop do
  controller.print_menu

  choise = gets.chomp.to_i
  break unless controller.has_action?(choise)

  controller.call(choise)
end

puts "Приложение завершило работу."
