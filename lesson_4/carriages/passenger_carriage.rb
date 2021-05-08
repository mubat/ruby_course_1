# frozen_string_literal: true

##
# Describes Carriage with type "passanger"
# has additional required option "number of seats"
# You can take on seat of get number of available seats or taken seats
class PassengerCarriage < Carriage
  attr_reader :available_seats

  def initialize(seat_numbers)
    raise ArgumentError("seat_numbers can't be equal or less than 0") if seat_numbers <= 0

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
    "#{carriage.type}. Свободных мест: #{carriage.available_seats}, занято мест: #{carriage.taken_seats}"
  end
end
