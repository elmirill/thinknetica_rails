module Validations
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end
  
  module ClassMethods
    attr_accessor :validations
    
    def validate(name, *args)
      self.validations ||= {}
      self.validations[name] ||= []
      self.validations[name] << args
    end
  end
  
  module InstanceMethods
    def validate!
      self.class.validations.each do |name, args|
        value = instance_variable_get("@#{name}")
        args.each do |v_params|
          send("validate_#{v_params[0]}", value, v_params[1..-1].first)
        end
      end
      true
    end
    
    def valid?
      validate!
    rescue
      false
    end
    
    private
    
    def validate_presence(value, *args)
      raise ArgumentError, "Attribute can't be nil or empty" if value.nil? || value == ""
    end
    
    def validate_type(value, *args)
      raise ArgumentError, "Attribute should be a #{args.first}" unless value.is_a? args.first
    end
    
    def validate_format(value, *args)
      raise ArgumentError, "Invalid attribute format" if value !~ args.first
    end
    
    def validate_less_than_or_equal_to(value, *args)
      raise ArgumentError, "Attribute should be #{args.first} at most" if value > args.first
    end
    
    def validate_greater_than_or_equal_to(value, *args)
      raise ArgumentError, "Attribute should be #{args.first} at least" if value < args.first
    end
  end
  
end