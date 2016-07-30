module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end
  
  module ClassMethods
    def instances
      @instances ||= []
      @instances
    end
    
    def instances=(instances)
      @instances ||= []
      @instances = instances
    end
  
    def all
      @instances
    end
  end
  
  module InstanceMethods
    protected
    
    def register_instance
      self.class.instances << self
    end
  end
end