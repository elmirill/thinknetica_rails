class Station
  attr_accessor :name
  attr_accessor :trains
  
  def initialize(name)
    @name = name
    @trains = []
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