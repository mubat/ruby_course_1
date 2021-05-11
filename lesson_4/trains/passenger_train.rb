# frozen_string_literal: true

require_relative "train"

##
# Describe Train with type 'passanger'
class PassengerTrain < Train
  def initialize(number)
    super number, "пассажирский"
  end
end
