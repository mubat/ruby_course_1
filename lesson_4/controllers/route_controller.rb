# frozen_string_literal: true

require_relative "controller"
require_relative "../route"

##
# Describe all actions that can do with routes
#
class RouteController < Controller
  def initialize(app_instance)
    super(app_instance)
    init_data_variable("routes")
  end

  def actions
    [
      { "label" => "Добавить маршрут", "action" => :add_route },
      { "label" => "Cписок маршрутов", "action" => :print_routes },
      { "label" => "Назначить маршрут поезду", "action" => :register_router_for_train }
    ]
  end

  def add_route
    puts "Добавление нового маршрута."
    station_start = choose_element(@app.stations, "Выберите стартовую станцию из списка")
    return if station_start.nil?

    station_end = choose_element(@app.stations, "Выберите конечную станцию из списка", [station_start])
    return if station_end.nil?

    @app.routes.push(Route.new(station_start, station_end))
  end

  def print_routes
    puts("Нет зарегистрированных маршрутов.") || return unless @app.routes.length

    print_elements(@app.routes, "Список зарегистрированных маршрутов в системе")
  end

  def register_router_for_train
    train = choose_element(@app.trains, "Выберите поезд из списка:")
    return unless train

    route = choose_element(@app.routes, "Выберите маршрут из списка:")
    return unless route

    train.register_route(route)
    puts "Зарегистрирован маршрут #{route} для поезда \##{train.number}"
  end
end
