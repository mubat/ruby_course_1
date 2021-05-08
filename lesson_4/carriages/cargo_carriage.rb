class CargoCarriage < Carriage
	attr_reader :taken_volume

  def initialize(volume)
    @type = "грузовой"
    @volume = volume
    @taken_volume = 0
  end

  # take a part of cargo volume.
  # @return [bool] operation result
  def take_volume(amount)
    if self.available_volume < amount
      return false
    end

    @taken_volume += amount
    return true
  end

  # @return [Integer] left available volume
  def available_volume
    @volume - @taken_volume
  end

  def to_s
    "#{carriage.type}. Свободный объём: #{carriage.available_volume.to_s}, занятый объём: #{carriage.taken_volume.to_s}"
  end

end
