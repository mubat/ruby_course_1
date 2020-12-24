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
      {'label' => "Добавить вагон поезду", 'action' => :hook_carriage_to_train},
      {'label' => "Отцепить 1 вагон от поезда", 'action' => :unhook_carriage},
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
    print_elements(@stations, "Список зарегистрированных станций")
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
    print_elements(@trains, "Список зарегистрированных поездов в системе")
  end

  def add_route
    puts "Добавление нового маршрута."
    station_start = choose_element(@stations, "Выберите стартовую станцию из списка")
    return if station_start.nil?
    station_end = choose_element(@stations, "Выберите конечную станцию из списка", [station_start])
    return if station_end.nil?
    @routes.push(Route.new(station_start, station_end))
  end

  def print_routes
    if !@routes.length      
      puts "Нет зарегистрированных маршрутов."
      return
    end
    print_elements(@routes, "Список зарегистрированных маршрутов в системе")
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

  def unhook_carriage
    train = choose_element(@trains, "Выберите поезд из списка")
    return if train.nil?

    carriage_to_unhook = choose_element(train.carriages, "Какой вагон отцепить?")
    train.remove_carriage(carriage_to_unhook)

  end

################
  private

  def print_elements(elements_list, text = nil)
    if !elements_list.length      
      puts "Список пуст."
      return
    end
    i = 0
    puts "#{text}:"
    elements_list.each { |object| i += 1; puts "\t#{i}. #{object.to_s}" }
  end

  def choose_element(elements_list, text = nil, except_list = [])
    return nil if elements_list.length == 0

    print_elements(elements_list, text)
    loop do
      choise = gets.chomp.to_i
      if (choise.between?(1, elements_list.length) && (except_list.length == 0 || except_list.index(elements_list[choise-1]).nil?))
        return elements_list[choise-1]
      end
      
      return nil unless ask_confirm("Недопустимый выбор. Желаете повторить?")
    end
  end

  def ask_confirm(message)
    puts "#{message} y/д/+ - да"
    answer = gets.chomp.downcase
    return answer == 'y' || answer == 'д' || answer == '+' 
  end

end