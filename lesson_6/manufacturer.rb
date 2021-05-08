# frozen_string_literal: true

##
# Store a manufacturer name for some class
module Manufacturer
  def manufacturer_name=(name)
    @manufacturer_name = name
  end

  def manufacturer_name
    @manufacturer_name
  end
end
