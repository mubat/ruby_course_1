# frozen_string_literal: true

##
# Count all new instance of class where included
# You can get amount of created instances from `instances_count`
module InstanceCounter
  def self.included(init_class)
    init_class.extend ClassModule
    init_class.send :include, InstanceModule
  end

  ##
  # module with need options and methods for target class
  module ClassModule
    attr_writer :instances_count

    def instances_count
      @instances_count ||= 0
    end
  end

  ##
  # module with need options and methods for target instance
  module InstanceModule
    def register_instance()
      self.class.instances_count += 1
    end
  end
end
