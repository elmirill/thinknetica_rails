class PassengerTrain < Train
  
  # Repeat
  validate :number, :presence
  validate :number, :format, NUMBER_FORMAT
  
  def attach_wagon(wagon)
    super(wagon) if wagon.is_a? PassengerWagon
  end
end
