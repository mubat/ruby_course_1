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
  end
end
