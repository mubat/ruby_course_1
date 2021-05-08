# frozen_string_literal: true

##
# Integrates action to validate instance.
# Include 2 methods:
#     1. valid? - returns result of executing validate action
#     1. validate - checks instance state and raise Exceptions when something has incorrect values
module Validate
  def self.included(init_class)
    init_class.send :include, InstanceModule
  end

  ##
  # Module that will be included into target class
  # Has methods described above
  module InstanceModule
    def valid?
      validate
      true
    rescue
      false
    end

    protected

    def validate
    end
  end
end
