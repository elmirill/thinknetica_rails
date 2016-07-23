class Wagon
  include Manufacturer
  
  attr_reader :number
  attr_reader :attached
  
  def initialize(number)
    @number = number
    @attached = false
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