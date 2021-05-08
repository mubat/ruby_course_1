# frozen_string_literal: true

module Validate
  def self.included(init_class)
    init_class.send :include, InstanceModule
  end

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
