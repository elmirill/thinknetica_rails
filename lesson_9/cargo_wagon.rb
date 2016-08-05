class CargoWagon < Wagon
  attr_reader :capacity
  attr_reader :taken_capacity
  
  # Repeat
  validate :number, :presence
  validate :number, :format, NUMBER_FORMAT
  
  validate :capacity, :presence
  validate :capacity, :greater_than_or_equal_to, 50
  validate :capacity, :less_than_or_equal_to, 200

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
end
