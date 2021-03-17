# Создать модуль InstanceCounter, содержащий следующие методы класса и инстанс-методы, которые подключаются автоматически при вызове include в классе:
# Методы класса:
#        - instances, который возвращает кол-во экземпляров данного класса
# Инстанс-методы:
#        - register_instance, который увеличивает счетчик кол-ва экземпляров класса и который можно вызвать из конструктора. При этом данный метод не должен быть публичным.
# Подключить этот модуль в классы поезда, маршрута и станции.
# Примечание: инстансы подклассов могут считаться по отдельности, не увеличивая счетчик инстансев базового класса. 

module InstanceCounter
  def self.included(initClass)
    initClass.instance_variable_set(:@instancesList, [])
    initClass.extend ClassModule
    initClass.send :include, InstanceModule
  end

  module ClassModule
    attr_accessor :instancesList

    def instances_count
      @instancesList.length
    end
  end

  module InstanceModule
    def register_instance(instance)
      self.class.instancesList.push(instance)
    end
  end
end