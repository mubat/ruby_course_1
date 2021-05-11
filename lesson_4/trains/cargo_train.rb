# frozen_string_literal: true

require_relative "train"

##
# Describe Train with type 'cargo'
class CargoTrain < Train
  def initialize(number)
    super number, "грузовой"
  end
end
