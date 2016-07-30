class CargoWagon < Wagon
  attr_reader :capacity
  attr_reader :taken_capacity

  def initialize(options = {})
    @capacity = options[:capacity].to_f
    @taken_capacity = 0
    super(options[:number])
  end

  def take_capacity(take_capacity)
    self.taken_capacity += take_capacity if take_capacity <= empty_capacity
  end

  def take_capacity?(take_capacity)
    take_capacity(take_capacity)
  end

  def empty_capacity
    capacity - taken_capacity
  end

  protected

  attr_writer :capacity
  attr_writer :taken_capacity

  def validate!
    raise "Capacity can't be blank" if @capacity.nil?
    raise "Capacity can't be 0" if @capacity.zero?
    raise "Capacity should be at least 50 and at most 200" if @capacity < 50 || @capacity > 200
    super
  end
end
