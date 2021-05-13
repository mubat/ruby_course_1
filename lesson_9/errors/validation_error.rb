# frozen_string_literal: true

##
# Exception uses in Validation module to describe failed validation.
# Contains information about validation step: attribute, validator name, value to check
class ValidationError < StandardError
  attr_accessor :attribute, :validator, :arguments, :checked_value

  def initialize(attribute, checked_value, msg = nil)
    super msg
    @attribute = attribute
    @checked_value = checked_value
  end

  def to_s
    "Failed validation for attribute '#{@attribute}'. " \
    "Arguments #{@arguments.inspect}. Checked value '#{@checked_value.inspect}'"
  end
end
