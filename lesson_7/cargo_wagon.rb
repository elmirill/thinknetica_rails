class CargoWagon < Wagon
  attr_reader :capacity
  attr_reader :taken_capacity
  
  def initialize(number, capacity)
    @capacity = capacity.to_f
    @taken_capacity = 0
    super(number)
  end
  
  def take_capacity(take_capacity)
    if take_capacity <= empty_capacity
      self.taken_capacity += take_capacity
    end
  end
  
  def empty_capacity
    capacity - taken_capacity
  end
  
  protected
  attr_writer :capacity
  attr_writer :taken_capacity
  
  def validate!
    raise "Capacity can't be blank" if @capacity == nil
    raise "Capacity can't be 0" if @capacity == 0
    raise "Capacity should be at least 50 and at most 200" if @capacity < 50 || @capacity > 200
    super
  end
end