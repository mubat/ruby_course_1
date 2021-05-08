# frozen_string_literal: true

require_relative "../lesson_6/instance_counter"
require_relative "../lesson_7/validate"

##
# Describe Station activity and it options.
#
# Has name.
# Can take trains, give a list of trains on it, send trains along the route
#
class Station
  attr_reader :name, :trains

  @@all_stations = []

  include InstanceCounter
  include Validate

  def initialize(name)
    @name = name
    @trains = []
    @@all_stations.push(self)
    register_instance(self)
    validate
  end

  def take_train(train)
    @trains.push(train)
  end

  def trains_on_station_by_type(type)
    @trains.filter { |train| train.type == type }
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

  def apply(&block)
    raise LocalJumpError("no block given") unless block_given?

    @trains.each_with_index do |train, i|
      if block.arity == 2
        block.call(i, train)
      else
        block.call(train)
      end
    end
  end

  protected

  def validate
    raise "Station should has name" if @name.nil? || @name == ""
    raise "Station should be a string" unless @name.is_a? String

    @trains.each do |train|
      raise "Station should contain only Train objects as trains" unless train.is_a? Train
    end
  end
end
