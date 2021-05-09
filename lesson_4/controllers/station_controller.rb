# frozen_string_literal: true

require_relative "controller"
require_relative "../station"

##
# Describe all actions that can do with stations
class StationController < Controller
  def initialize(app_instance)
    super(app_instance)
    init_data_variable("stations")
  end

  def actions
    [
      { "label" => "Добавить станцию", "action" => :add_station },
      { "label" => "Список всех станций", "action" => :print_stations },
      { "label" => "Вывести список поездов на станции", "action" => :print_trains_at_station }
    ]
  end

  def add_station
    printf "Добавление новой станции.\n\tВведите название станции: "
    @app.stations.push(Station.new(gets.chomp))
  end

  def print_stations
    puts("Нет зарегистрированных станций.") || return unless @app.stations.length

    print_elements(@app.stations, "Список зарегистрированных станций")

    return unless ask_confirm("Желаете увидеть поезда на станции?")

    station_to_show = choose_element(@app.stations)
    puts "На данный момент на станции зарегистрированны следующие поезда:"
    print_elements(station_to_show.trains_on_station_by_type("пассажирский"), "Пассажирские поезда")
    print_elements(station_to_show.trains_on_station_by_type("грузовой"), "Грузовые поезда")
  end

  def print_trains_at_station
    station = choose_element(@app.stations, "Выберите станцию из списка.")
    puts("Станция не выбрана") || return unless station
    puts("На станции нет поездов") || return if station.trains.length.zero?

    station.apply { |i, train| puts "\t\t#{i}. #{train}" }
  end
end
