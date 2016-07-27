class Wagon
  include Manufacturer
  include InstanceCounter
  
  def self.find(number)
    @@instances.detect { |t| t.number == number }
  end
  
  attr_reader :number
  attr_reader :attached
  
  def initialize(number)
    @number = number
    @attached = false
    validate!
    register_instance
  end
  
  def valid?
    validate!
  end
  
  def attach
    self.attached = true
  end
  
  def detach
    self.attached = false
  end
  
  protected
  
  attr_writer :attached
  
  def validate!
    raise "Wagon number can't be blank" if @number == "" || @number.nil?
    raise "Wagon number can't be 0" if @number == "0"
    raise "Wagon number should be precisely 3 characters." if @number.length != 3
    raise "Wagon number format is not valid" if @number !~ /[a-z]{1}[0-9]{2}/i
    true
  end
  
end