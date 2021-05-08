# frozen_string_literal: true

require_relative "../lesson_7/validate"
require_relative "station"

##
# Describe Route information and actions.
#
# Stores a list of stations that train should visit
# Can add/remove station from the list (but not first and last), print a list of registered stations
#
#
class Route
  attr_reader :way_stations

  include Validate

  def initialize(start_station, end_station)
    @way_stations = [start_station, end_station]
    validate
  end

  def add_way_station(station)
    @way_stations.insert(-2, station)
  end

  def delete_way_station(station)
    if @way_stations.find_index(station.name).nil?
      return
    elsif @way_stations.length <= 2 || @way_stations[0] == station || @way_stations.last == station
      return
    end

    @way_stations.reject!(station)
  end

  def start_station
    @way_stations[0]
  end

  def end_station
    @way_stations.last
  end

  def to_s
    "#{self.start_station.name} - #{self.end_station.name}"
  end

  protected

  def validate
    raise "Route should has start and end station" if @way_stations.nil? || @way_stations.length <= 1
    if (!@way_stations[0].is_a? Station) || (!@way_stations[@way_stations.length - 1].is_a? Station)
      raise "Number should be a string"
    end
  end
end
