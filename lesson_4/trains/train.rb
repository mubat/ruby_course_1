require_relative '../carriages/carriage.rb'
require_relative '../../lesson_6/manufacturer'
require_relative '../../lesson_7/validate'

##
# Describes general actions and information about trains
# 
# Can encrease speed, stop, tell a current speed, amount of carriages, hitch/unhitch carriages, 
# moves between stations in the route, register route
class Train
  attr_reader :speed, :carriages, :current_station, :type
  attr_accessor :number 

  NUMBER_FORMAT = /^[а-я\w\d]{3}\-?[а-я\w\d]{2}$/i

  include Manufacturer
  include Validate

  @@registered_trains = []

  def initialize(number, type)
    @number = number
    @carriages = []
    @speed = 0
    @type = type
    @@registered_trains.push(self)
    validate
  end

  def speed_encrease(value = 10)
    @speed = @speed + value
  end

  def stop
    @speed = 0
  end

  def add_carriage(carriage)
    return if carriage.type != self.type
    @carriages.push(carriage) if @speed == 0 && @carriages.index(carriage).nil?
  end

  def remove_carriage(carriage)
    return if @carriages.length == 0
    @carriages.delete(carriage) if @speed == 0 && !@carriages.index(carriage).nil?
  end

  def register_route(route)
    @route = route
    self.current_station = @route.start_station
  end

  def go_forward
    next_station = get_next_station
    return unless next_station

    @current_station.send_train(self)
    self.current_station = next_station
  end

  def go_reverse
    next_station = get_previous_station
    return unless next_station

    @current_station.send_train(self)
    self.current_station = next_station
  end

  def current_station=(station)
    @current_station = station
    @current_station.take_train(self)
  end

  def get_next_station
    if @current_station != @route.end_station
      @route.way_stations[@route.way_stations.index(@current_station) + 1]
    end
  end

  def get_previous_station
    if @current_station != @route.start_station
      @route.way_stations[@route.way_stations.index(@current_station) - 1]
    end
  end

  def route?
    !@route.nil?
  end

  def to_s
    "Номер: \##{train.number}, тип: #{train.type}, кол-во вагонов:#{train.carriages.length}"
  end

  def self.find(number)
    @@registered_trains.find{|train| train.number == number}
  end

  def apply(&block)
    if !block_given?
      raise LocalJumpError("no block given")
    end

    @carriages.each_with_index do |carriage, i| 
      if block.arity == 2
        block.call(i, carriage)
      else
        block.call(carriage)
      end
    end
  end

  protected

  def validate
    raise "Number can't be empty" if @number.nil? || @number == ''
    raise "Number should be a string" if !@number.is_a? String
    raise "Number has wrong format" if @number !~ NUMBER_FORMAT

    raise "Speed should be a number" if !@speed.is_a? Numeric
    raise "Speed should be more than 0 or equal" if @speed < 0

    raise "Type can't be empty" if @type.nil? || @type == ''
    raise "Type should be a string" if !@type.is_a? String
  end
end
