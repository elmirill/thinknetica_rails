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
  def remove_intermediate(station)
    self.stations.delete(station) if stations.index(station) != 0 && stations.index(station) != stations.size - 1
  end

end