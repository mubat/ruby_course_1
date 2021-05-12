# frozen_string_literal: true

##
# add validation functionality to the class
module Validation
  def self.included(init_class)
    init_class.send :include, InstanceModule
  end

  ##
  # declare all needed instance methods
  module InstanceModule
    ##
    # Allow to call some validator for attribute. May get additional parameters
    # syntax:
    #     validate :number, :format, /A-Z{0,3}/
    #
    def validate(attr, validator, *args)
      send(validator, attr, *args)
    end

    protected

    ##
    # validator. Check attribute value by regexp
    #
    def format(attr, *args)
      args[0].match(instance_variable_get("@#{attr}".to_sym))
    end
  end
end
