# frozen_string_literal: true

##
# Describes Carriage with type "cargo"
# has additional required option "volume"
# can take some volume and show available lost
class CargoCarriage < Carriage
  attr_reader :taken_volume

  def initialize(volume)
    super()
    @type = "грузовой"
    @volume = volume
    @taken_volume = 0
  end

  # take a part of cargo volume.
  # @return [bool] operation result
  def take_volume(amount)
    return false if available_volume < amount

    @taken_volume += amount
    true
  end

  # @return [Integer] left available volume
  def available_volume
    @volume - @taken_volume
  end

  def to_s
    "#{@type}. Свободный объём: #{@available_volume}, занятый объём: #{@taken_volume}"
  end
end
