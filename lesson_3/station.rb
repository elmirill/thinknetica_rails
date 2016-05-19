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
  
  def show_trains_by_type
    passenger_trains = trains.select { |train| train.type == "Passenger" }
    cargo_trains = trains.select { |train| train.type == "Cargo" }
    
    puts passenger_trains
    puts "Total passenger trains: #{passenger_trains.size}"
    puts cargo_trains
    puts "Total cargo trains: #{cargo_trains.size}"
  end
  
  def send_train(train_number)
    train = trains.select { |t| t.number == train_number }
    self.trains = trains - train
    train
  end
end