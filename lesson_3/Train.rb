### Класс Train (Поезд):
## Имеет номер (произвольная строка) и тип (грузовой, пассажирский) и количество вагонов, эти данные указываются при создании экземпляра класса
## Может набирать скорость
## Может возвращать текущую скорость
## Может тормозить (сбрасывать скорость до нуля)
## Может возвращать количество вагонов
## Может прицеплять/отцеплять вагоны (по одному вагону за операцию, метод просто увеличивает или уменьшает количество вагонов). Прицепка/отцепка вагонов может осуществляться только если поезд не движется.
## Может принимать маршрут следования (объект класса Route). 
# При назначении маршрута поезду, поезд автоматически помещается на первую станцию в маршруте.
# Может перемещаться между станциями, указанными в маршруте. Перемещение возможно вперед и назад, но только на 1 станцию за раз.
# Возвращать предыдущую станцию, текущую, следующую, на основе маршрута

class Train
  attr_reader :speed, :carriage_amount, :current_station, :number

  def initialize(number, type, carriage_amount = 0)
    @number = number
    @type = type
    @carriage_amount = carriage_amount
    @speed = 0
  end

  def speed_encrease(value = 10)
    @speed = @speed + value
  end

  def stop
    @speed = 0
  end

  def add_carriage
    @carriage_amount += 1 if @speed == 0
  end

  def remove_carriage
    return @carriage_amount <= 0
    
    @carriage_amount -= 1  if @speed == 0
  end

  def register_route(route)
    @route = route
    self.current_station = @route.start_station
  end

  def go_forward
    next_station = get_previous_station
    return unless next_station

    @current_station.send_train(self)
    self.current_station = next_station
  end

  def go_reverse
    next_station = get_next_station
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

end
