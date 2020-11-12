### Класс Train (Поезд):
# Имеет номер (произвольная строка) и тип (грузовой, пассажирский) и количество вагонов, эти данные указываются при создании экземпляра класса
# Может набирать скорость
# Может возвращать текущую скорость
# Может тормозить (сбрасывать скорость до нуля)
# Может возвращать количество вагонов
# Может прицеплять/отцеплять вагоны (по одному вагону за операцию, метод просто увеличивает или уменьшает количество вагонов). Прицепка/отцепка вагонов может осуществляться только если поезд не движется.
# Может принимать маршрут следования (объект класса Route). 
# При назначении маршрута поезду, поезд автоматически помещается на первую станцию в маршруте.
# Может перемещаться между станциями, указанными в маршруте. Перемещение возможно вперед и назад, но только на 1 станцию за раз.
# Возвращать предыдущую станцию, текущую, следующую, на основе маршрута

class Train
  attr_reader :speed, :carriage_amount

  def initialize(nubmer, type, carriage_amount = 0)
    @nubmer = nubmer
    @type = type
    @carriage_amount = carriage_amount
  end

  def encrease_speed(value = 10)
    @speed = @speed + value
  end

  def stop
    @speed = 0
  end

  def add_carriage
    if @speed > 0
      puts 'Can\'t add carriage to train on it way' 
      return
    end
    @carriage_amount += 1
  end

  def remove_carriage
    if @speed > 0
      puts 'Can\'t remove carriage to train on it way' 
      return
    end
    
    if @carriage_amount <= 0
      puts 'There is no carriages'
      return
    end

    @carriage_amount -= 1
  end

end
