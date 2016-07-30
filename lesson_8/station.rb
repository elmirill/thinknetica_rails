class Station
  include InstanceCounter

  def self.find(name)
    instances.detect { |t| t.name == name }
  end

  attr_reader :name
  attr_reader :trains
  attr_reader :passenger_trains
  attr_reader :cargo_trains

  def initialize(name)
    @name = name
    @trains = []
    @passenger_trains = []
    @cargo_trains = []
    validate!
    register_instance
  end

  def valid?
    validate!
  end

  def accept_train(train)
    # How do we check if it's a proper Train object?
    trains << train
    if train.is_a? PassengerTrain
      passenger_trains << train
    elsif train.is_a? CargoTrain
      cargo_trains << train
    end
  end

  def trains_by_type(type)
    if type == "passenger"
      trains.filter { |t| t.is_a? PassengerTrain }
    elsif type == "cargo"
      trains.filter { |t| t.is_a? CargoTrain }
    else
      false
    end
  end

  def send_train(train_number)
    trains.delete_if { |train| train.number == train_number }
  end

  def fetch_trains
    trains.each { |t| yield(t) }
  end

  protected

  attr_writer :trains
  attr_writer :passenger_trains
  attr_writer :cargo_trains

  def validate!
    raise "Station name can't be blank" if @name == "" || @name.nil?
    raise "Station name should be at least 3 and at most 30 characters" if @name.length < 3 || @name.length > 30
    raise "Station name format is not valid" if @name !~ /[\w']{3,30}/
    true
  end
end
