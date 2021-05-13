# frozen_string_literal: true

require_relative "controller"
require_relative "../trains/passenger_train"
require_relative "../trains/cargo_train"

##
# Describe all actions that can do with trains
class TrainController < Controller
  def initialize(app_instance)
    super(app_instance)
    init_data_variable("trains")
  end

  def actions
    [
      { "label" => "Добавить поезд", "action" => :add_train },
      { "label" => "Список поездов", "action" => :print_trains },
      { "label" => "Отправить поезд", "action" => :send_train },
      { "label" => "Занять место в вагоне", "action" => :take_place_at_carriage }
    ]
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
    puts "Возникла ошибка при создании записи. Причина: #{e.message}, #{e.backtrace}"
    retry if ask_confirm("Желаете повторить?")
  end

  def print_trains(message = nil)
    puts "Нет зарегистрированных поездов." || return unless @app.trains.length
    print_elements(@app.trains, message || "Список зарегистрированных поездов в системе")
  end

  def send_train
    train = choose_element(@app.trains, "Выберите поезд")

    puts("Поезду не указан маршрут. Сначало выставите маршрут поезду") || return unless train.route?

    choise = choose_element_idx(["в обратном направлении", "в попутном направлении"], "В каком направлении отправить?")
    next_station = choise == 2 ? train.go_forward : train.go_reverse

    puts("Поезд не уехал. Достигнут конец маршрута") || return if next_station.nil?

    puts "Поезд отправлен на станцию #{next_station}."
  end

  def take_place_at_carriage
    return if (train = choose_element(@app.trains, "Выберите поезд из списка.")) ||
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

  def register_train(train)
    train.validate!
    @app.trains.push(train)
    puts "Запись о поезде #{train} создана"
  end
end
