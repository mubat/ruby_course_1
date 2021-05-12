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
      current_class = self.class
      loop do
        break if current_class.nil? || current_class.ancestors.index(Validation).nil?

        execute_validators(current_class.validators)
        current_class = current_class.superclass
      end
      true
    end

    def valid?
      validate!
    rescue ValidationError
      false
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
    # rubocop: disable Naming/PredicateName - because proposed name is not suitable here
    def has_type(attr, *args)
      instance_variable_get("@#{attr}".to_sym).instance_of?(args[0])
    end
    # rubocop: enable Naming/PredicateName

    private

    def execute_validators(validators)
      validators.each do |args|
        res = send(args[1], args[0], *args[2])
        raise ValidationError.new(args[0], instance_variable_get("@#{args[0]}".to_sym)) unless res
      end
    end
  end
end
