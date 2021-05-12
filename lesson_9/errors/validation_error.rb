class ValidationError < StandardError
  attr_accessor :attribute, :validator, :arguments, :checked_value


  def initialize(attribute, checked_value, _msg = nil)
    super _msg
    @attribute = attribute
    @checked_value = checked_value
  end

  def to_s
    "Failed validation for attribute '#{@attribute}'. Arguments #{@arguments.inspect}. Checked value '#{@checked_value.inspect}'"
  end
end