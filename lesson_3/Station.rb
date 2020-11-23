## Класс Station (Станция):
# Имеет название, которое указывается при ее создании
# Может принимать поезда (по одному за раз)
# Может возвращать список всех поездов на станции, находящиеся в текущий момент
# Может возвращать список поездов на станции по типу (см. ниже): кол-во грузовых, пассажирских
# Может отправлять поезда (по одному за раз, при этом, поезд удаляется из списка поездов, находящихся на станции).

class Station
  attr_reader :name
  @trains = []

  def initialize(name)
    @name = name
  end

  def take_train(train)
    @trains.push(train)
  end

  def trains_on_station
    @trains
  end

  def trains_on_station_by_type(type)
    trains_by_type = {}
    @trains.each {|train| trains_by_type.push(train) if train.type == type}
  end

  def send_train(train)
    train.go_forward
    puts "Go go #{number} train."
    @trains.delete(train)
  end

end
