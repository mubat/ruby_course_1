# frozen_string_literal: true
require_relative 'errors/validation_error'

##
# add validation functionality to the class
module Validation
  def self.included(init_class)
    init_class.extend ClassModule
    init_class.send :include, InstanceModule
  end
  
  ##
  # includes all declarations for Class
  module ClassModule
    attr_writer :validators

    ##
    # You can register validation rules for each attribute
    # syntax:
    #     validate :number, :format, /A-Z{0,3}/
    #

    def validate(attr, validator, *args)
      validators.push([attr, validator, args])
    end

    def validators
      @validators ||= []
    end
  end

  ##
  # declare all needed instance methods
  module InstanceModule
    ##
    # Allow to call some validator for attribute. May get additional parameters
    def validate!
      self.class.validators.each do |args|
        # puts "debug. Try execute #{args}"
        res = send(args[1], args[0], *args[2])
        raise ValidationError.new(args[0], instance_variable_get("@#{args[0]}".to_sym)) unless res
      end
      true
    end

    def valid? 
      begin 
        res = validate!
        return res
      rescue ValidationError
        return false
      end
    end

    protected

    ##
    # validator. Check attribute value by regexp
    #
    def format(attr, *args)
      value = instance_variable_get("@#{attr}".to_sym)
      return true unless value
      args[0].match?(value)
    end

    ##
    # validator. Check attribute value not nil and not empty
    #
    def presence(attr, *_args)
      value = instance_variable_get("@#{attr}".to_sym)
      !value.nil? && !value.empty?
    end

    ##
    # validator. Check attribute value should by with requested type
    #
    def type(attr, *args)
      instance_variable_get("@#{attr}".to_sym).instance_of? args[0] 
    end
  end
end
