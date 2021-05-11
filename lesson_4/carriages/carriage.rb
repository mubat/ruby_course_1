# frozen_string_literal: true

##
# General class for all carriages. Has common actions
class Carriage
  attr_reader	:type

  def initialize
    @type = "basic"
  end

  def to_s
    @type
  end
end
