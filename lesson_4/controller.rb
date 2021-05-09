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
  ACTIONS = [
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
    { "label" => "Занять место в вагоне", "action" => :take_place_at_carriage }
  ].freeze

  def initialize
    @stations = []
    @trains = []
    @routes = []
  end

  def print_menu
    puts "Меню:"
    i = 0
    ACTIONS.each do |menu_item|
      i += 1
      puts "\t#{i}. #{menu_item['label']}"
    end
  end

  def action?(index)
    !ACTIONS[index - 1].nil?
  end

  def call(index)
    method(ACTIONS[index - 1]["action"]).call
  end

  def add_station
    printf "Добавление новой станции.\n\tВведите название станции: "
    @stations.push(Station.new(gets.chomp))
  end

  def print_stations
    puts("Нет зарегистрированных станций.") || return unless @stations.length

    print_elements(@stations, "Список зарегистрированных станций")

    return unless ask_confirm("Желаете увидеть поезда на станции?")

    station_to_show = choose_element(@stations)
    puts "На данный момент на станции зарегистрированны следующие поезда:"
    print_elements(station_to_show.trains_on_station_by_type("пассажирский"), "Пассажирские поезда")
    print_elements(station_to_show.trains_on_station_by_type("грузовой"), "Грузовые поезда")
  end

  def add_train
    train_number = prompt "\tВведите номер поезда: "

    case choose_element(%w[пассажирский грузовой], "Какого типа поезд?\t 1 - пассажирский, 2 - грузовой")
    when "пассажирский"
      register_train(PassengerTrain.new(train_number))
    when "грузовой"
      register_train(CargoTrain.new(train_number))
    end
  rescue StandardError => e
    puts "Возникла ошибка при создании записи. Причина: #{e.message}"
    retry if ask_confirm("Желаете повторить?")
  end

  def print_trains(message = nil)
    puts "Нет зарегистрированных поездов." || return unless @trains.length
    print_elements(@trains, message || "Список зарегистрированных поездов в системе")
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
    puts("Нет зарегистрированных маршрутов.") || return unless @routes.length

    print_elements(@routes, "Список зарегистрированных маршрутов в системе")
  end

  def register_router_for_train
    train = choose_element(@trains, "Выберите поезд из списка:")
    return unless train

    route = choose_element(@routes, "Выберите маршрут из списка:")
    return unless route

    train.register_route(route)
    puts "Зарегистрирован маршрут #{route} для поезда \##{train.number}"
  end

  def hook_carriage_to_train
    train = choose_element(@trains, "Выберите поезд из списка:")
    return unless train

    if train.type == "грузовой"
      puts "\tВведите общий объём вагона: "
      train.add_carriage(CargoCarriage.new(gets.chomp.to_i))
      return
    end
    puts "\tВведите пассажировместимость вагона: "
    train.add_carriage(PassengerCarriage.new(gets.chomp.to_i))
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
    unless [1, 2].include?(choise)
      puts "Некорректный выбор"
      return
    end

    puts("Поезду не указан маршрут. Сначало выставите маршрут поезду") || return unless train.route?
    next_station = choise == 2 ? train.go_forward : train.go_reverse

    puts("Поезд не уехал. Достигнут конец маршрута") || return if next_station.nil?

    puts "Поезд отправлен на станцию #{next_station}."
  end

  def print_carriages_at_train
    train = choose_element(@trains, "Выберите поезд из списка.")
    return unless train

    train.apply { |i, carriage| puts "\t\t#{i}. #{carriage} " }
  end

  def print_trains_at_station
    station = choose_element(@stations, "Выберите станцию из списка.")
    puts("Станция не выбрана") || return unless station
    puts("На станции нет поездов") || return if station.trains.length.zero?

    station.apply { |i, train| puts "\t\t#{i}. #{train}" }
  end

  def take_place_at_carriage
    return if (train = choose_element(@trains, "Выберите поезд из списка.")) ||
              train.carriages.length.zero? ||
              (carriage = choose_element(train.carriages, "Выберите вагон."))

    case carriage.type
    when "грузовой"
      take_place_at_cargo_carriage
    when "пассажирский"
      take_place_at_passanger_carriage
    end
  end

  ################
  private

  def print_elements(elements_list, text = nil)
    puts "#{text}:" unless text.nil?
    puts("\tСписок пуст.") || return if elements_list.length.zero? || elements_list.nil?

    i = 0
    elements_list.each { |object| i += 1; puts "\t#{i}. #{object}" }
  end

  def choose_element(elements_list, text = nil, except_list = [])
    puts("Список пуст") || return if elements_list.length.zero?

    print_elements(elements_list, text)
    loop do
      choise = gets.chomp.to_i
      if choise.between?(1, elements_list.length) &&
         (except_list.length.zero? || except_list.index(elements_list[choise - 1]).nil?)
        return elements_list[choise - 1]
      end

      return nil unless ask_confirm("Недопустимый выбор. Желаете повторить?")
    end
  end

  def choose_element_idx(elements_list, text = nil, except_list = [])
    elements_list.index(choose_element(elements_list, text, except_list))
  end

  def ask_confirm(message)
    puts "#{message} y/д/+ - да"
    answer = gets.chomp.downcase
    ["y", "д", "+"].include?(answer)
  end

  # dont want to create split controller for each type. Just create separate actions
  def take_place_at_cargo_carriage
    puts "\tОставшееся свобоное место: #{carriage.available_volume}."
    puts("Нет свободного пространства") || return if carriage.available_volume <= 0

    printf "\tСколько хотите занять? "
    puts carriage.take_volume(gets.chomp.to_i) ? "Успешно" : "не удалось застолбить место"
  end

  def take_place_at_passanger_carriage
    puts "\tОставшееся свобоное место: #{carriage.available_seats}."
    puts carriage.take_seat ? " Место записано за вами" : " Нет свободных мест"
  end

  def register_train
    @trains.push(train)
    puts "Запись о поезде #{train} создана"
  end

  def prompt(*args)
    print(*args)
    gets.chomp
  end
end
