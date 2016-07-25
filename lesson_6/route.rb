class Route
  attr_reader :number
  attr_reader :stations
  
  def initialize(number, stations)
    @number = number
    @stations = stations
    validate!
  end
  
  def validate!
    raise "Route number can't be blank" if @number == "" || @number.nil?
    raise "Route number can't be 0" if @number == "0"
    raise "Route number format is not valid." if @number !~ /\d{1,3}/
    if !@stations.is_a? Array || !@stations.all? { |s| s.is_a? Station }
      raise "Please add valid stations"
    end
    raise "Route should have at least two stations" if @stations.nil? || @stations.size < 2
    true
  end
  
  def valid?
    validate!
  end
  
  def add_intermediates(stations_names)
    already_exist = false
    stations_names.each do |sn|
      if stations.any? { |s| s.name == sn }
        already_exist = true
      end
    end
    
    if !already_exist
      self.stations.insert(1, stations_names).flatten!
    else
      false
    end
  end
  
  def add_intermediates?(stations_names)
    add_intermediates(stations_names)
  end
  
  # Also checking if we are not remowing dispatch or destination stations
  def remove_intermediate(station_name)
    self.stations.delete_if { |s| s.name == station_name && stations.index(s) != 0 && stations.index(s) != stations.size - 1 }
  end
  
  def list_stations_names
    names_list = []
    stations.each do |s|
      names_list << s.name 
    end
    names_list.join(", ")
  end

  protected
  
  attr_writer :stations
end