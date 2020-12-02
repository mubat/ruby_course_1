require_relative 'station'
require_relative 'trains/passenger_train'
require_relative 'trains/cargo_train'

class Controller
  
  def initialize
    @stations = []
    @trains = []
    @actions = [
      {'label' => "Добавить станцию", 'action' => :add_station},
      {'label' => "Список всех станций", 'action' => :print_stations},
      {'label' => "Добавить поезд", 'action' => :add_train},
    ]
  end

  def print_menu
    puts "Меню:"
    i = 0
    @actions.each do |menu_item|
      i += 1
      puts "\t#{i}. #{menu_item['label']}"
    end
  end

  def has_action?(index)
    !@actions[index-1].nil?
  end

  def call(index)
    method(@actions[index-1]['action']).call
  end

  def add_station
    printf "Добавление новой станции.\n\tВведите название станции: " 
    @stations.push(Station.new(gets.chomp))
  end

  def print_stations
    i = 0
    puts "Список зарегистрированных станций:"
    @stations.each { |station| i += 1; puts "\t#{i}. #{station.name}"}
  end

  def add_train
    puts "Добавление поезда."
    printf "\tВведите номер поезда: "
    train_number = gets.chomp

    printf "\tКакого типа поезд? 1 - пассажирский, 2 - грузовой: "
    train_type = gets.chomp.to_i
    if train_type == 1
      train = PassengerTrain.new train_number
    elsif train_type == 2 
      train = CargoTrain.new train_number
    else
      puts "Тип не поддерживается."
      return
    end

    @trains.push(train)
  end

end