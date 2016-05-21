class Train
  attr_reader :number
  attr_reader :type
  attr_accessor :wagons
  attr_accessor :speed
  attr_accessor :route
  attr_accessor :current_station
  
  def initialize(number, type, wagons)
    @number = number
    @type = type
    @wagons = wagons
    @speed = 0
  end
  
  def stop
    self.speed = 0
  end
  
  def attach_wagon
    if speed == 0
      self.wagons += 1
    end
  end
  
  def detach_wagon
    if speed == 0
      unless wagons < 1
        self.wagons -= 1
      end
    end
  end
  
  def add_route(route)
    self.route = route
    self.current_station = route.stations.first
  end
  
  def route?
    route != nil
  end
  
  def current_station_index
    if route?
      route.stations.find_index(current_station)
    end
  end
  
  def move_to_station(station_name)
    if route?
      destination_station = route.stations.find { |s| s.name == station_name }
      self.current_station = destination_station
      destination_station.accept_train(self)
    end
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
end