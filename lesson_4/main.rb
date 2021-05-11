# frozen_string_literal: true

# Start point of the program
require_relative "controllers/controller"
require_relative "controllers/train_controller"
require_relative "controllers/route_controller"
require_relative "controllers/station_controller"
require_relative "controllers/carriage_controller"

##
# Class initialize whole application
# Performs role of database, to store all registered objects
class App
  def initialize
    @controllers = []
    @actions = []
    register_controller(TrainController.new(self))
    register_controller(RouteController.new(self))
    register_controller(StationController.new(self))
    register_controller(CarriageController.new(self))
  end

  def run
    puts "Чтобы выйти из приложения, в меню введите абракадабру."
    loop do
      print_menu
      choise = gets.chomp.to_i
      break unless action?(choise)

      call(choise)
    end
    puts "Приложение завершило работу."
  end

  def print_menu
    puts "Меню:"
    @actions.each_with_index { |menu_item, i| puts "\t#{i + 1}. #{menu_item['label']}" }
  end

  def register_controller(controller)
    @controllers.push(controller)
    controller.actions.map do |action|
      action["controller"] = controller
      @actions.push action
    end
  end

  def action?(index)
    !@actions[index - 1].nil?
  end

  def call(index)
    @actions[index - 1]["controller"].send(@actions[index - 1]["action"])
  end
end

App.new.run
