# frozen_string_literal: true

require_relative "station"
require_relative "trains/passenger_train"
require_relative "trains/cargo_train"
require_relative "carriages/passenger_carriage"
require_relative "carriages/cargo_carriage"
require_relative "route"

##
# Has all actions that user can execute.
# Can print main menu. User should choose one of them. To exit - print some bullshit
class Controller
  def initialize
    @stations = []
    @trains = []
    @routes = []
    @actions = [
      { "label" => "Добавить станцию", "action" => :add_station },
      { "label" => "Список всех станций", "action" => :print_stations },
      { "label" => "Добавить поезд", "action" => :add_train },
      { "label" => "Список поездов", "action" => :print_trains },
      { "label" => "Отправить поезд", "action" => :send_train },
      { "label" => "Добавить маршрут", "action" => :add_route },
      { "label" => "Cписок маршрутов", "action" => :print_routes },
      { "label" => "Назначить маршрут поезду", "action" => :register_router_for_train },
      { "label" => "Добавить вагон поезду", "action" => :hook_carriage_to_train },
      { "label" => "Отцепить 1 вагон от поезда", "action" => :unhook_carriage },
      { "label" => "Вывести список вагонов у поезда", "action" => :print_carriages_at_train },
      { "label" => "Вывести список поездов на станции", "action" => :print_trains_at_station },
      { "label" => "Занять место в вагоне", "action" => :take_place_at_carriage },
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

  def action?(index)
    !@actions[index - 1].nil?
  end

  def call(index)
    method(@actions[index - 1]["action"]).call
  end

  def add_station
    printf "Добавление новой станции.\n\tВведите название станции: "
    @stations.push(Station.new(gets.chomp))
  end

  def print_stations
    unless @stations.length
      puts "Нет зарегистрированных станций."
      return
    end
    print_elements(@stations, "Список зарегистрированных станций")

    return unless ask_confirm("Желаете увидеть поезда на станции?")
    station_to_show = choose_element(@stations)
    puts "На данный момент на станции зарегистрированны следующие поезда:"
    print_elements(station_to_show.trains_on_station_by_type("пассажирский"), "Пассажирские поезда")
    print_elements(station_to_show.trains_on_station_by_type("грузовой"), "Грузовые поезда")
  end

  def add_train
    puts "Добавление поезда."

    begin
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
    rescue StandardError => e
      puts "Возникла ошибка при создании записи. Причина: #{e.message}"
      printf "Желаете повторить? (y - да): "
      retry if gets.chomp == "y"
      return
    end
    @trains.push(train)
    puts "Запись о поезде #{train} создана"
  end

  def print_trains
    unless @trains.length
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
    unless @routes.length
      puts "Нет зарегистрированных маршрутов."
      return
    end
    print_elements(@routes, "Список зарегистрированных маршрутов в системе")
  end

  def register_router_for_train
    puts "Выберите поезд из списка:"
    print_trains
    train = gets.chomp.to_i
    if train.positive? && train <= @trains.length
      train = @trains[train - 1]
    else
      puts "Недопустимое значение"
      return
    end

    puts "Выберите маршрут из списка:"
    print_routes
    route = gets.chomp.to_i
    if route.positive? && route <= @routes.length
      route = @routes[route - 1]
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
    if train.positive? && train <= @trains.length
      train = @trains[train - 1]
    else
      puts "Недопустимое значение"
      return
    end
    puts train.carriages.inspect

    if train.type == "грузовой"
      puts "\tВведите общий объём вагона: "
      train.add_carriage(CargoCarriage.new(gets.chomp.to_i))
    else
      puts "\tВведите пассажировместимость вагона: "
      train.add_carriage(PassengerCarriage.new(gets.chomp.to_i))
    end
    puts train.carriages.inspect
  end

  def unhook_carriage
    train = choose_element(@trains, "Выберите поезд из списка")
    return if train.nil?

    carriage_to_unhook = choose_element(train.carriages, "Какой вагон отцепить?")
    train.remove_carriage(carriage_to_unhook)

  end

  def send_train
    train = choose_element(@trains, "Выберите поезд")
    unless train.route?
      puts "Поезду не указан маршрут. Сначало выставите маршрут поезду"
      return
    end
    puts "В каком направлении отправить? 1 - в обратном направлении, 2 - в попутном направлении"
    choise = gets.chomp.to_i
    unless choise == 1 || choise == 2
      puts "Некорректный выбор"
      return
    end
    next_station = choise == 2 ? train.go_forward : train.go_reverse
    if next_station.nil?
      puts "Поезд не уехал. Достигнут конец маршрута"
      return
    end
    puts "Поезд отправлен на станцию #{next_station.to_s}."
  end

  def print_carriages_at_train
    train = choose_element(@trains, "Выберите поезд из списка.")
    return unless train
    train.apply { |i, carriage| puts "\t\t#{i}. #{carriage.to_s} " }
  end

  def print_trains_at_station
    station = choose_element(@stations, "Выберите станцию из списка.")
    unless (station)
      puts "Станция не выбрана"
      return
    end
    if (station.trains.length.zero?)
      puts "На станции нет поездов"
      return
    end

    station.apply { |i, train| puts "\t\t#{i}. #{train.to_s}" }
  end

  def take_place_at_carriage
    train = choose_element(@trains, "Выберите поезд из списка.")
    unless (train)
      puts "Поезд не выбран"
      return
    end
    if (train.carriages.length.zero?)
      puts "У поезда нет вагонов"
      return
    end

    carriage = choose_element(train.carriages, "Выберите вагон.")
    unless (train)
      puts "Вагон не выбран"
      return
    end

    if (carriage.type == "грузовой")
      puts "\tОставшееся свобоное место: #{carriage.available_volume}."
      if carriage.available_volume <= 0
        puts "Нет свободного пространства"
        return
      end
      printf "\tСколько хотите занять? "
      printf "\t\t"
      puts (carriage.take_volume(gets.chomp.to_i) ? "Успешно" : "не удалось застолбить место")
    end
    if (carriage.type == "пассажирский")
      puts "\tОставшееся свобоное место: #{carriage.available_seats}."
      printf "\t\t"
      puts (carriage.take_seat ? "Место записано за вами" : "Нет свободных мест")
    end
  end

################
  private

  def print_elements(elements_list, text = nil)
    puts "#{text}:" unless text.nil?
    if elements_list.length.zero? || elements_list.nil?
      puts "\tСписок пуст."
      return
    end

    i = 0
    elements_list.each { |object| i += 1; puts "\t#{i}. #{object.to_s}" }
  end

  def choose_element(elements_list, text = nil, except_list = [])
    return nil if elements_list.length.zero?

    print_elements(elements_list, text)
    loop do
      choise = gets.chomp.to_i
      if (choise.between?(1, elements_list.length) && (except_list.length.zero? || except_list.index(elements_list[choise - 1]).nil?))
        return elements_list[choise - 1]
      end

      return nil unless ask_confirm("Недопустимый выбор. Желаете повторить?")
    end
  end

  def ask_confirm(message)
    puts "#{message} y/д/+ - да"
    answer = gets.chomp.downcase
    return answer == "y" || answer == "д" || answer == "+"
  end
end
