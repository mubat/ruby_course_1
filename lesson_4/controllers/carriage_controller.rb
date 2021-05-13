# frozen_string_literal: true

require_relative "controller"
require_relative "../carriages/passenger_carriage"
require_relative "../carriages/cargo_carriage"

##
# Describe all actions that can do with carriages
class CarriageController < Controller
  def actions
    [
      { "label" => "Добавить вагон поезду", "action" => :hook_carriage_to_train },
      { "label" => "Отцепить 1 вагон от поезда", "action" => :unhook_carriage },
      { "label" => "Вывести список вагонов у поезда", "action" => :print_carriages_at_train }
    ]
  end

  def hook_carriage_to_train
    train = choose_element(@app.trains, "Выберите поезд из списка:")
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
    train = choose_element(@app.trains, "Выберите поезд из списка")
    return if train.nil?

    carriage_to_unhook = choose_element(train.carriages, "Какой вагон отцепить?")
    train.remove_carriage(carriage_to_unhook)
  end

  def print_carriages_at_train
    train = choose_element(@app.trains, "Выберите поезд из списка.")
    return unless train

    puts "Список вагонов поезда \##{train.number}:"
    train.apply { |i, carriage| puts "\t#{i + 1}. #{carriage} " }
  end
end
