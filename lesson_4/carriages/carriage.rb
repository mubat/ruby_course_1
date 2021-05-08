# frozen_string_literal: true
class Carriage
  attr_reader	:type

  def initialize
    @type = "basic"
  end

  def to_s
    @type
  end
end
