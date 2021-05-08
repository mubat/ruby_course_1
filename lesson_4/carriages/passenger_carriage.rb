# frozen_string_literal: true
class PassengerCarriage < Carriage
  attr_reader :available_seats

  def initialize(seat_numbers)
    if seat_numbers <= 0
      raise ArgumentError("seat_numbers can't be equal or less than 0")
    end

    @type = "пассажирский"
    @available_seats = @seat_numbers = seat_numbers
  end

  # decrease amount of available seats and return action result in bool
  def take_seat
    return false if @available_seats <= 0
    @available_seats -= 1
    true
  end

  # return amount of taken seats
  def taken_seats
    @seat_numbers - @available_seats
  end

  def to_s
    "#{carriage.type}. Свободных мест: #{carriage.available_seats.to_s}, занято мест: #{carriage.taken_seats.to_s}"
  end
end
