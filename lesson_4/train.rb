class Train
  @@instances = []
  
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
  end
  
  def self.all
    @@instances
  end
  
  def self.where_number_is(number)
    @@instances.detect { |t| t.number == number }
  end
  
  def stop
    self.speed = 0
  end
  
  def attach_wagon(wagon)
    if speed == 0
      self.wagons << wagon
    end
  end
  
  def detach_wagon(wagon)
    if speed == 0
      self.wagons.delete(wagon)
    end
  end
  
  def add_route(route)
    self.route = route
    self.current_station = route.stations.first
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
    "passenger" if self.is_a? PassengerTrain
    "cargo" if self.is_a? CargoTrain
    "generic" if self.is_a Train
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