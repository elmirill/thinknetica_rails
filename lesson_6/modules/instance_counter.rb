module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end
  
  module ClassMethods
    def count
      @count ||= 0
      @count
    end
    
    def count=(count)
      @count ||= 0
      @count = count
    end
  end
  
  module InstanceMethods
    protected
    
    def count_instance
      self.class.count += 1
    end
  end
end