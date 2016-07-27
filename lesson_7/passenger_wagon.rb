class PassengerWagon < Wagon
  attr_reader :seats
  attr_reader :taken_seats
  
  def initialize(number, seats)
    @seats = seats.to_i
    @taken_seats = 0
    super(number)
  end
  
  def take_seat
    if empty_seats > 0
      self.taken_seats += 1
    end
  end
  
  def empty_seats
    seats - taken_seats
  end
  
  protected
  attr_writer :seats
  attr_writer :taken_seats
  
  def validate!
    raise "Seats can't be blank" if @seats == nil
    raise "Seats can't be 0" if @seats == 0
    raise "Number of seats should be between 10 and 100" if @seats < 10 || @seats > 100
    super
  end
  
end