
module InstanceCounter
  def self.included(init_class)
    init_class.extend ClassModule
    init_class.send :include, InstanceModule
  end

  module ClassModule
    attr_writer :instances_count

    def instances_count
      @instances_count ||= 0
    end
  end

  module InstanceModule
    def register_instance(instance)
      self.class.instances_count += 1
    end
  end
end