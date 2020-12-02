require_relative 'train'

class CargoTrain < Train

  def initialize(number)
    super number, 'passenger'
  end
end
