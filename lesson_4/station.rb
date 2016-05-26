class Station
  @@instances = []
  
  attr_accessor :name
  attr_accessor :trains
  
  def initialize(name)
    @name = name
    @trains = []
    @@instances << self
  end
  
  def self.all
    @@instances
  end
  
  def self.where_name_is(name)
    @@instances.detect { |s| s.name == name }
  end
  
  def accept_train(train)
    self.trains << train
  end
  
  def trains_by_type(type)
    trains.select { |train| train.type == type }
  end
  
  def send_train(train_number)
    trains.delete_if { |train| train.number == train_number }
  end
end