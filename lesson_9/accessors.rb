# frozen_string_literal: true

##
# use add custom attr_accessor that stores all changes history for published attributes.
# Usage in class declaration:
#       attr_accessor_with_history :attr_one, :attr_two
module Accessors
  def self.included(init_class)
    init_class.extend ClassModule
    init_class.send :include, InstanceModule
  end

  ##
  # includes all declarations for Class
  module ClassModule
    ##
    # Dynamically creates getters and setter. Save all change history for each attribute
    def attr_accessor_with_history(*attrs)
      attrs.each do |attr|
        attr_name = "@#{attr}".to_sym

        define_method(attr) do
          instance_variable_get(attr_name).last
        end

        define_method("#{attr}=".to_sym) do |value|
          new_value = instance_variable_get(attr_name) || []
          instance_variable_set(attr_name.to_sym, new_value.push(value))
        end
      end
    end

    ##
    # Creates getter and setter. But you can populate values type for attribute. And it will be set if type is correct
    # Raise TypeError if type of new value differs from populated at initialization
    def strong_attr_accessor(attr, type)
      attr_name = "@#{attr}".to_sym

      define_method(attr) do
        instance_variable_get(attr_name)
      end

      define_method("#{attr}=".to_sym) do |value|
        unless type == value.class
          raise TypeError, "Wrong type of publised value. Should be #{type}, got  #{value.class}"
        end

        instance_variable_set(attr_name.to_sym, value || nil)
      end
    end
  end

  ##
  # declare all needed instance methods
  module InstanceModule
    def method_missing(method_name, *args, &block)
      # check is requested method contains '_history' suffix
      attr = method_name.match(/^([\w_]+)_history$/)
      return instance_variable_get("@#{attr[1]}".to_s) unless attr.nil?

      super
    end

    def respond_to_missing?(method_name, *args)
      method_name.match(/^([\w_]+)_history$/) || super
    end
  end
end
