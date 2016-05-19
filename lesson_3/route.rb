class Route
  attr_reader :dispatch_station
  attr_reader :destination_station
  attr_accessor :intermediate_stations
  
  def initialize(dispatch_station, destination_station, intermediate_stations = [])
    @dispatch_station = dispatch_station
    @destination_station = destination_station
    @intermediate_stations = intermediate_stations
  end
  
  def current_intermediate_list
    puts "Current list is:"
    puts intermediate_stations.each { |s| puts s.name }
  end
  
  def station_present?(station)
    if station.class == String
      intermediate_stations.any? { |s| s.name == station }
    else station.class == Station
      intermediate_stations.any? { |s| s.name == station.name }
    end
  end
  
  def add_intermediate(station)
    if station.class == Station && !station_present?(station)
      self.intermediate_stations << station
      puts "#{station.name} added to the list of intermediate stations."
      current_intermediate_list
    elsif station.class == Station && station_present?(station)
      puts "This station is already in the list."
    else
      puts "Please enter a valid station."
    end
  end
  
  def remove_intermediate(station_name)
    if station_present?(station_name)
      self.intermediate_stations.delete_if { |station| station.name == station_name }
      puts "#{station_name} removed from the list of intermediate stations."
      current_intermediate_list
    else
      puts "There's no such station in the list"
    end
  end
  
  def stations
    stations = [dispatch_station] + intermediate_stations + [destination_station]
#    puts "The whole route is:"
#    stations.each { |s| puts s.name }
  end
end