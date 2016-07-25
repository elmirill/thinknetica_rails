class Train
  include Manufacturer
  
  @@instances = []
  
  def self.all
    @@instances
  end
  
  def self.find(number)
    @@instances.detect { |t| t.number == number }
  end
  
  attr_reader :number
  attr_reader :wagons
  attr_reader :route
  attr_reader :current_station
  # У нас пока нет другого метода, который бы управлял изменением скорости, и я не вижу необходимости в его создании, поэтому оставляем доступ на изменение публичным.
  attr_accessor :speed
  
  def initialize(number)
    @number = number
    @speed = 0
    @wagons = []
    @@instances << self
    validate!
  end
  
  def validate!
    raise "Train number can't be blank" if @number == "" || @number.nil?
    raise "Train number can't be 0" if @number == "0"
    raise "Train number should be at least 5 and at most 6 characters" if @number.length < 5 || @number.length > 6
    raise "Train format is not valid" if @number !~ /[a-z0-9]{3}-?[a-z0-9]{2}/i
    true
  end
  
  def valid?
    validate!
  end
  
  def stop
    self.speed = 0
  end
  
  def attach_wagon(wagon)
    if speed == 0
      wagon.attach
      self.wagons << wagon
    end
  end
  
  def attach_wagon?(wagon)
    attach_wagon(wagon)
  end
  
  def detach_wagon(wagon)
    if speed == 0
      wagon.detach
      self.wagons.delete(wagon)
    end
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
    route != nil
  end
  
  def move_to_station(station_name)
    if route?
      destination_station = route.stations.find { |s| s.name == station_name }
      self.current_station = destination_station
      destination_station.accept_train(self)
    else 
      false
    end
  end
  
  def move_to_station?(station_name)
    move_to_station(station_name)
  end
      
  def previous_station
    if route? && current_station_index != 0
      route.stations[current_station_index - 1]
    end
  end
  
  def next_station
    if route? && current_station_index != route.stations.size - 1
      route.stations[current_station_index + 1]
    end
  end
  
  def type
    if self.class == PassengerTrain
      "passenger"
    elsif self.class == CargoTrain
      "cargo"
    end
  end
  
  # Остальные методы (те, что выше) могут быть полезны для клиентского кода и не нарушают принципов инкапсуляции.
  protected
  
  # Для этих атрибутов есть специальные методы, которые управляют их изменениями.
  attr_writer :wagons
  attr_writer :route
  attr_writer :current_station
  
  # Вспомогательный метод, используется для получения предыдущей и следующей станции, сам по себе пользы не несет.
  def current_station_index
    if route?
      route.stations.find_index(current_station)
    end
  end
  
end