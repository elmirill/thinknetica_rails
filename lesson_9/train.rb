class Train
  extend Accessors
  include Manufacturer
  include InstanceCounter
  include Validations
  
  NUMBER_FORMAT = /[a-z0-9]{3}-?[a-z0-9]{2}/i

  def self.find(number)
    instances.detect { |t| t.number == number }
  end

  attr_reader :number
  attr_reader :wagons
  attr_reader :route
  attr_reader :current_station
  
  strong_attr_accessor :speed, Fixnum
  
  validate :number, :presence
  validate :number, :format, NUMBER_FORMAT

  def initialize(number)
    @number = number
    @speed = 0
    @wagons = []
    validate!
    register_instance
  end

  def stop
    self.speed = 0
  end

  def attach_wagon(wagon)
    false unless speed.zero?
    wagon.attach
    wagons << wagon
  end

  def attach_wagon?(wagon)
    attach_wagon(wagon)
  end

  def detach_wagon(wagon)
    false unless speed.zero?
    wagon.detach
    wagons.delete(wagon)
  end

  def detach_wagon?(wagon)
    detach_wagon(wagon)
  end

  def add_route(route)
    self.route = route
    self.current_station = route.stations.first
    current_station.accept_train(self)
  end

  def add_route?(route)
    add_route(route)
  end

  def route?
    !!route
  end

  def move_to_station(station)
    if route? && route.stations.any? { |s| s == station }
      self.current_station = station
      station.accept_train(self)
    else
      false
    end
  end

  def move_to_station?(station_name)
    move_to_station(station_name)
  end

  def previous_station
    false unless route? && current_station_index.nonzero?
    route.stations[current_station_index - 1]
  end

  def next_station
    false unless route? && current_station_index != route.stations.size - 1
    route.stations[current_station_index + 1]
  end

  def type
    if is_a? PassengerTrain
      "passenger"
    elsif is_a? CargoTrain
      "cargo"
    end
  end

  def fetch_wagons
    wagons.each { |w| yield(w) }
  end

  protected

  attr_writer :wagons
  attr_writer :route
  attr_writer :current_station

  def current_station_index
    route.stations.find_index(current_station) if route?
  end
end
