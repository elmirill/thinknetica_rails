class Station
  @@instances = []
  
  attr_reader :name
  attr_reader :trains
  
  def initialize(name)
    @name = name
    @trains = []
    @passenger_trains = []
    @cargo_trains = []
    @@instances << self
  end
  
  def self.all
    @@instances
  end
  
  def accept_train(train)
    self.trains << train
    if train.is_a? PassengerTrain
      self.passenger_trains << train
    elsif train.is_a? CargoTrain
      self.cargo_trains << train
    end
  end
  
  def trains_by_type(type)
    if type == "passenger"
      trains.filter { |t| t.is_a? PassengerTrain }
    elsif type == "cargo"
      trains.filter { |t| t.is_a? CargoTrain }
    else
      puts "Type is not exist"
      false
    end
  end
  
  def send_train(train_number)
    trains.delete_if { |train| train.number == train_number }
  end
  
  protected
  
  attr_writer :trains
end