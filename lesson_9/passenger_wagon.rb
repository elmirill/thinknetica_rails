class PassengerWagon < Wagon
  attr_reader :seats
  attr_reader :taken_seats
  
  # Repeat
  validate :number, :presence
  validate :number, :format, NUMBER_FORMAT
  
  validate :seats, :presence
  validate :seats, :greater_than_or_equal_to, 10
  validate :seats, :less_than_or_equal_to, 100

  def initialize(options = {})
    @seats = options[:seats].to_i
    @taken_seats = 0
    super(options[:number])
  end

  def take_seats(take_seats)
    self.taken_seats += take_seats if take_seats <= empty_seats
  end

  def take_seats?(take_seats)
    take_seats(take_seats)
  end

  def empty_seats
    seats - taken_seats
  end

  protected

  attr_writer :seats
  attr_writer :taken_seats
end
