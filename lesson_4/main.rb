# Start point of the program 
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