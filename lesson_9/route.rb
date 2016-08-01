class Route
  include InstanceCounter

  def self.find(number)
    instances.detect { |t| t.number == number }
  end

  attr_reader :number
  attr_reader :stations

  def initialize(options = {})
    @number = options[:number]
    @stations = options[:stations]
    validate!
    register_instance
  end

  def valid?
    validate!
  end

  def add_intermediates(int_stations)
    already_exist = false
    int_stations.each do |is|
      already_exist = true if stations.any? { |s| s.name == is.name }
    end

    !already_exist ? stations.insert(1, int_stations).flatten! : false
  end

  def add_intermediates?(int_stations)
    add_intermediates(int_stations)
  end

  def remove_intermediate(station_name)
    stations.delete_if do |s|
      s.name == station_name &&
        stations.index(s).nonzero? &&
        stations.index(s) != stations.size - 1
    end
  end

  def list_stations_names
    names_list = []
    stations.each { |s| names_list << s.name }
    names_list.join(", ")
  end

  protected

  attr_writer :stations

  def validate!
    raise "Route number can't be blank" if @number == "" || @number.nil?
    raise "Route number can't be 0" if @number == "0"
    raise "Route number format is not valid." if @number !~ /\d{1,3}/
    unless (@stations.is_a? Array) || @stations.all? { |s| s.is_a? Station } || @stations.all?(&:valid?)
      raise "Please add valid stations"
    end
    raise "Route should have at least two stations" if @stations.nil? || @stations.size < 2
    true
  end
end
