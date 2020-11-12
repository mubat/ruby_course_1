## Класс Station (Станция):
# Имеет название, которое указывается при ее создании
# Может принимать поезда (по одному за раз)
# Может возвращать список всех поездов на станции, находящиеся в текущий момент
# Может возвращать список поездов на станции по типу (см. ниже): кол-во грузовых, пассажирских
# Может отправлять поезда (по одному за раз, при этом, поезд удаляется из списка поездов, находящихся на станции).

class Station
  @@trains = {}

  def initialize(name)
    @name = name
  end

  def take_train(train)
    @@trains[train.number] = train
  end

  def trains_on_station
    @@trains
  end

  def trains_on_station_by_type(type)
    trains_by_type = {}
    @@trains.each {|number, train| trains_by_type[number] = train if train.type == type}
  end

  def send_train(number)
    if !@@trains.has_key?(number)
      puts "No one train with number #{number} found"
      return
    end

    puts "Go go #{number} train."
    @@trains.delete(number)
  end

end
