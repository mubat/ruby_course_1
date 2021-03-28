# Класс Route (Маршрут):
# Имеет начальную и конечную станцию, а также список промежуточных станций. Начальная и конечная станции указываютсся при создании маршрута, а промежуточные могут добавляться между ними.
# Может добавлять промежуточную станцию в список
# Может удалять промежуточную станцию из списка
# Может выводить список всех станций по-порядку от начальной до конечной
require_relative '../lesson_7/validate'
require_relative 'station'

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
      puts "We already don`t stop on station #{station.name}"
      return
    elsif @way_stations.length <= 2 || @way_stations[0] == station || @way_stations.last == station
      puts "There is no way stations"
      return
    end

    @way_stations.reject!(station)
    puts 'Now we skip #{station.name}'
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
    raise "Number should be a string" if (!@way_stations[0].is_a? Station) || (!@way_stations[@way_stations.length-1].is_a? Station)
  end
end
