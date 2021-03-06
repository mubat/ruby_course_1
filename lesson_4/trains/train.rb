# frozen_string_literal: true

require_relative "../carriages/carriage"
require_relative "../../lesson_6/manufacturer"
require_relative "../../lesson_9/validation"

##
# Describes general actions and information about trains
#
# Can encrease speed, stop, tell a current speed, amount of carriages, hitch/unhitch carriages,
# moves between stations in the route, register route
class Train
  attr_reader :speed, :carriages, :current_station, :type
  attr_accessor :number

  NUMBER_FORMAT = /^[а-я\w\d]{3}-?[а-я\w\d]{2}$/i.freeze

  include Manufacturer
  include Validation

  validate :number, :presence
  validate :number, :has_type, String
  validate :number, :format, NUMBER_FORMAT
  validate :speed, :has_type, Integer
  validate :type, :presence
  validate :type, :has_type, String

  # rubocop: disable Style/ClassVars
  @@registered_trains = []
  # rubocop: enable Style/ClassVars

  def initialize(number, type)
    @number = number
    @carriages = []
    @speed = 0
    @type = type
    @@registered_trains.push(self)
  end

  def speed_encrease(value = 10)
    @speed += value
  end

  def stop
    @speed = 0
  end

  def add_carriage(carriage)
    return if carriage.type != type

    @carriages.push(carriage) if @speed.zero? && @carriages.index(carriage).nil?
  end

  def remove_carriage(carriage)
    return if @carriages.length.zero?

    @carriages.delete(carriage) if @speed.zero? && !@carriages.index(carriage).nil?
  end

  def register_route(route)
    @route = route
    self.current_station = @route.start_station
  end

  def go_forward
    return unless next_station

    @current_station.send_train(self)
    self.current_station = next_station
  end

  def go_reverse
    return unless previous_station

    @current_station.send_train(self)
    self.current_station = next_station
  end

  def current_station=(station)
    @current_station = station
    @current_station.take_train(self)
  end

  def next_station
    @route.way_stations[@route.way_stations.index(@current_station) + 1] if @current_station != @route.end_station
  end

  def previous_station
    @route.way_stations[@route.way_stations.index(@current_station) - 1] if @current_station != @route.start_station
  end

  def route?
    !@route.nil?
  end

  def to_s
    "Номер: \##{@number}, тип: #{@type}, кол-во вагонов:#{@carriages.length}"
  end

  def self.find(number)
    @@registered_trains.find { |train| train.number == number }
  end

  def apply(&block)
    raise LocalJumpError("no block given") unless block_given?

    @carriages.each_with_index do |carriage, i|
      if block.arity == 2
        block.call(i, carriage)
      else
        block.call(carriage)
      end
    end
  end

  # protected

  # def validate
  #   validate_number
  #   validate_speed
  #   validate_type
  # end

  # private

  # def validate_number
  #   raise "Number can't be empty" if @number.nil? || @number == ""
  #   raise "Number should be a string" unless @number.is_a? String
  #   raise "Number has wrong format" if @number !~ NUMBER_FORMAT
  # end

  # def validate_speed
  #   raise "Speed should be a number" unless @speed.is_a? Numeric
  #   raise "Speed should be more than 0 or equal" if @speed.negative?
  # end

  # def validate_type
  #   raise "Type can't be empty" if @type.nil? || @type == ""
  #   raise "Type should be a string" unless @type.is_a? String
  # end
end
