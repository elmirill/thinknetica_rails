module Accessors
  def attr_accessor_with_history(*names)
    names.each do |name|
      var_name = "@#{name}".to_sym
      var_name_history = "@#{name}_history".to_sym
      
      define_method(name) { instance_variable_get(var_name) }
      
      define_method("#{name}_history") do
        instance_variable_get(var_name_history) ||
        instance_variable_set(var_name_history, [])
      end
      
      define_method("#{name}=".to_sym) do |value|
        instance_variable_set(var_name, value)
        instance_variable_set(var_name_history, []) if instance_variable_get(var_name_history).nil?
        instance_variable_get(var_name_history) << value
      end
    end
  end
  
  def strong_attr_accessor(name, class_name)
    var_name = "@#{name}".to_sym
    
    define_method(name) { instance_variable_get(var_name) }
    define_method("#{name}=".to_sym) do |value|
      if value.is_a? class_name
        instance_variable_set(var_name, value)
      else
        raise "#{name} should be #{class_name}!"
      end
    end
  end
end