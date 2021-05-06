## Класс Station (Станция):
# Имеет название, которое указывается при ее создании
# Может принимать поезда (по одному за раз)
# Может возвращать список всех поездов на станции, находящиеся в текущий момент
# Может возвращать список поездов на станции по типу (см. ниже): кол-во грузовых, пассажирских
# Может отправлять поезда (по одному за раз, при этом, поезд удаляется из списка поездов, находящихся на станции).
require_relative '../lesson_6/instance_counter'
require_relative '../lesson_7/validate'

class Station
  attr_reader :name, :trains
  @@all_stations = []

  include InstanceCounter
  include Validate


  def initialize(name)
    @name = name
    @trains = []
    @@all_stations.push(self)
    self.register_instance(self)
    validate
  end

  def take_train(train)
    @trains.push(train)
  end

  def trains_on_station_by_type(type)
    trains_by_type = {}
    @trains.filter {|train| train.type == type}
  end

  def send_train(train)
    @trains.delete(train)
  end

  def to_s
    @name
  end

  def self.all
    @@all_stations
  end

  protected

  def validate
    raise "Station should has name" if @name.nil? || @name == ''
    raise "Station should be a string" if !@name.is_a? String
    @trains.each do |train|
      raise "Station should contain only Train objects as trains" if !train.is_a? Train
    end
  end

  def apply(&block)
    if !block_given?
      raise LocalJumpError("no block given")
    end

    @trains.each {|train| block.call(train)}
  end
end
