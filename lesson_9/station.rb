class Station
  extend Accessors
  include InstanceCounter
  include Validations
  
  NAME_FORMAT = /[\w']{3,30}/

  def self.find(name)
    instances.detect { |t| t.name == name }
  end

  attr_reader :name
  attr_reader :trains
  attr_reader :passenger_trains
  attr_reader :cargo_trains
  
  attr_accessor_with_history :income_per_day
  attr_accessor_with_history :tickets_per_day
  
  strong_attr_accessor :rating, Float
  
  validate :name, :presence
  validate :name, :type, String
  validate :name, :format, NAME_FORMAT
  
  def initialize(name)
    @name = name
    @trains = []
    @passenger_trains = []
    @cargo_trains = []
    validate!
    register_instance
  end

  def accept_train(train)
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
end
