# делать следующее:
  # - Создавать станции
  # - Создавать поезда
  # - Создавать маршруты и управлять станциями в нем (добавлять, удалять)
  # - Назначать маршрут поезду
  # - Добавлять вагоны к поезду
  # - Отцеплять вагоны от поезда
  # - Перемещать поезд по маршруту вперед и назад
  # - Просматривать список станций и список поездов на станции
require_relative 'station'
require_relative 'trains/passenger_train'
require_relative 'trains/cargo_train'
require_relative 'carriages/passenger_carriage'
require_relative 'carriages/cargo_carriage'
require_relative 'route'

class Controller
  
  def initialize
    @stations = []
    @trains = []
    @routes = []
    @actions = [
      {'label' => "Добавить станцию", 'action' => :add_station},
      {'label' => "Список всех станций", 'action' => :print_stations},
      {'label' => "Добавить поезд", 'action' => :add_train},
      {'label' => "Список поездов", 'action' => :print_trains},
      {'label' => "Добавить маршрут", 'action' => :add_route},
      {'label' => "Cписок маршрутов", 'action' => :print_routes},
      {'label' => "Назначить маршрут поезду", 'action' => :register_router_for_train},
      {'label' => "Добавить вагон поезду", 'action' => :add_carriage_to_train},
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
    if !@stations.length
      puts "Нет зарегистрированных станций."
      return
    end
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

  def print_trains
    if !@trains.length      
      puts "Нет зарегистрированных поездов."
      return
    end
    i = 0
    puts "Список зарегистрированных поездов в системе:"
    @trains.each { |train| i += 1; puts "\t#{i}. \##{train.number} - #{train.type}"}
  end

  def add_route
    puts "Добавление нового маршрута."
    printf "Выберите стартовую станцию из списка: "
    station_start = choose_station
    return if station_start.nil?
    printf "Выберите конечную станцию из списка: "
    station_end = choose_station([station_start])
    return if station_end.nil?
    @routes.push(Route.new(station_start, station_end))
  end

  def print_routes
    if !@routes.length      
      puts "Нет зарегистрированных маршрутов."
      return
    end
    i = 0
    puts "Список зарегистрированных маршрутов в системе:"
    @routes.each { |route| i += 1; puts "\t#{i}. '#{route.start_station.name} - #{route.end_station.name}'" }
  end


  def register_router_for_train
    puts "Выберите поезд из списка:"
    print_trains
    train = gets.chomp.to_i
    if train > 0 && train <= @trains.length 
      train = @trains[train-1]
    else
      puts "Недопустимое значение"
      return
    end

    puts "Выберите маршрут из списка:"
    print_routes
    route = gets.chomp.to_i
    if route > 0 && route <= @routes.length 
      route = @routes[route-1]
    else
      puts "Недопустимое значение"
      return
    end

    train.register_route(route)
    puts "Зарегистрирован маршрут для поезда \##{train.number}"
  end

  def hook_carriage_to_train
    puts "Выберите поезд из списка:"
    print_trains
    train = gets.chomp.to_i
    if train > 0 && train <= @trains.length 
      train = @trains[train-1]
    else
      puts "Недопустимое значение"
      return
    end
    puts train.carriages.inspect

    if train.type == 'грузовой'
      train.add_carriage(CargoCarriage.new)
    else 
      train.add_carriage(PassengerCarriage.new)
    end
    puts train.carriages.inspect
  end

################
  private

  def choose_station (except_stations = [])
    return nil if @stations.length == 0
    loop do
      print_stations
      choise = gets.chomp.to_i
      if (choise.between?(1, @stations.length) && (except_stations.length == 0 || except_stations.index(@stations[choise-1]).nil?))
        return @stations[choise-1]
      end

      puts "Выбор неправильный. Желаете повторить? y/д/+ - да"
      is_continue = gets.chomp.downcase
      return nil unless is_continue == 'y' || is_continue == 'д' || is_continue == '+' 
    end
  end
end