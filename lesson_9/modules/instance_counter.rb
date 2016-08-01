module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_accessor :instances

    def instances
      @instances ||= []
    end

    alias all instances
  end

  module InstanceMethods
    protected

    def register_instance
      self.class.instances << self
    end
  end
end
