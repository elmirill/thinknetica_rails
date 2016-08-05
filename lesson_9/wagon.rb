class Wagon
  include Manufacturer
  include InstanceCounter
  include Validations
  
  NUMBER_FORMAT = /[a-z]{1}[0-9]{2}/i

  def self.find(number)
    instances.detect { |t| t.number == number }
  end

  attr_reader :number
  attr_reader :attached
  
  validate :number, :presence
  validate :number, :format, NUMBER_FORMAT

  def initialize(number)
    @number = number
    @attached = false
    validate!
    register_instance
  end

  def attach
    self.attached = true
  end

  def detach
    self.attached = false
  end

  protected

  attr_writer :attached
end
