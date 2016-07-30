class PassengerWagon < Wagon
  attr_reader :seats
  attr_reader :taken_seats

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

  def validate!
    raise "Seats can't be blank" if @seats.nil?
    raise "Seats can't be 0" if @seats.zero?
    raise "Number of seats should be between 10 and 100" if @seats < 10 || @seats > 100
    super
  end
end
