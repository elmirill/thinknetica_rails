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
    puts "Halt!"
    puts "Current speed is #{speed}."
  end
  
  def attach_wagon(detach = false)
    if speed == 0 && detach == false
      self.wagons += 1
      puts "One wagon attached. Currently there are(is) #{wagons} wagon(s)."
    elsif speed == 0 && detach == true
      unless wagons < 1
        self.wagons -= 1
        puts "One wagon detached. Currently there are(is) #{wagons} wagon(s)."
      else
        puts "There are no wagons to detach!"
      end
    else
      puts "First stop the train, please."
    end
  end
  
  def add_route(route)
    if route.class == Route
      self.route = route
    else
      puts "Add a valid route."
    end
  end
  
  def move_to_station(station)
    unless route == nil
      self.current_station = route.stations.find { |s| s.name == station }
      
      if current_station.nil?
        puts "There's no such station on this route."
      else
        puts "Train moved to the #{current_station.name} station."
      end
    else
      puts "Add a route first."
    end
  end
  
  # Arguments may be "current", "previous" and "next"
  def show_station(station = "current")
    self.current_station ||= route.stations.first
    current_station_index = route.stations.find_index(current_station)
    
    if station == "current"
      puts "Current station is #{current_station.name}."
    elsif station == "previous"
      if current_station_index == 0
        puts "There was no previous station since this station is first."
      else
        puts "Previous station was #{route.stations[current_station_index - 1].name}."
      end
    elsif station == "next"
      if current_station_index == route.stations.size - 1
        puts "There would not be next station since this station is last."
      else
        puts "Next station would be #{route.stations[current_station_index + 1].name}."
      end
    else
      puts "Argument should be blank, \"previous\" or \"next\"."
    end
  end
end