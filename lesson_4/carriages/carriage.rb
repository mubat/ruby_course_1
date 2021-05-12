# frozen_string_literal: true

require_relative "../../lesson_9/validation"

##
# General class for all carriages. Has common actions
class Carriage
  attr_reader	:type

  include Validation

  validate :type, :presence
  validate :type, :has_type, String

  def initialize
    @type = "basic"
  end

  def to_s
    @type
  end
end
