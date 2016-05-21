class Route
  attr_accessor :stations
  
  def initialize(stations)
    @stations = stations
  end
  
  def add_intermediate(station)
    if !stations.any? { |s| s.name == station.name }
      self.stations.insert(-2, station)
    end
  end
  
  # Also checking if we are not remowing dispatch or destination stations
  def remove_intermediate(station_name)
    if stations.any? { |s| s.name == station_name }
      self.stations.delete_if { |station| station.name == station_name && station.index != 0 && station.index != stations.size - 1 }
    end
  end

end