class Route
  include InstanceCounter
  
  def self.find(number)
    instances.detect { |t| t.number == number }
  end
  
  attr_reader :number
  attr_reader :stations
  
  def initialize(number, stations)
    @number = number
    @stations = stations
    validate!
    register_instance
  end
  
  def valid?
    validate!
  end
  
  def add_intermediates(int_stations)
    if int_stations.all? { |s| s.valid? }
      already_exist = false
      int_stations.each do |is|
        if stations.any? { |s| s.name == is.name }
          already_exist = true
        end
      end

      if !already_exist
        self.stations.insert(1, int_stations).flatten!
      else
        false
      end
    end
  end
  
  def add_intermediates?(int_stations)
    add_intermediates(int_stations)
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
  
  def validate!
    raise "Route number can't be blank" if @number == "" || @number.nil?
    raise "Route number can't be 0" if @number == "0"
    raise "Route number format is not valid." if @number !~ /\d{1,3}/
    if !@stations.is_a? Array || !@stations.all? { |s| s.is_a? Station || !@stations.all? { |s| s.valid? } }
      raise "Please add valid stations"
    end
    raise "Route should have at least two stations" if @stations.nil? || @stations.size < 2
    true
  end
end