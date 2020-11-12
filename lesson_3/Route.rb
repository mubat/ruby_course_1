# Класс Route (Маршрут):
# Имеет начальную и конечную станцию, а также список промежуточных станций. Начальная и конечная станции указываютсся при создании маршрута, а промежуточные могут добавляться между ними.
# Может добавлять промежуточную станцию в список
# Может удалять промежуточную станцию из списка
# Может выводить список всех станций по-порядку от начальной до конечной

class Route

  def initialize(start_station, end_station)
    @start_station = start_station
    @end_station = end_station
    @way_stations = {}
  end

  def add_way_station(station)
    @way_stations[station.name] = station
  end

  def delete_way_station(station)
    if !@way_stations.has_key?(station.name)
      puts "We already don`t stop on station #{station.name}"
      return
    end

    @way_stations.delete(station.name)
    puts 'Now we skip #{station.name}'
  end

  def print_stations
    print @start_station.name + ' -> '
    @way_stations.each {|name, station|  print @station.name + ' -> '}
    print @end_station.name
  end

end
