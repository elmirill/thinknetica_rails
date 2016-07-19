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
    self.stations.delete_if { |s| s.name == station_name && stations.index(s) != 0 && stations.index(s) != stations.size - 1 }
  end

end