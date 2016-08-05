class Route
  include InstanceCounter
  include Validations
  
  NUMBER_FORMAT = /\d{1,3}/

  def self.find(number)
    instances.detect { |t| t.number == number }
  end

  attr_reader :number
  attr_reader :stations
  
  validate :number, :presence
  validate :number, :format, NUMBER_FORMAT
  validate :stations, :type, Array

  def initialize(options = {})
    @number = options[:number]
    @stations = options[:stations]
    validate!
    register_instance
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
end
