class PassengerTrain < Train
  def attach_wagon(wagon)
    super(wagon) if wagon.is_a? PassengerWagon
  end
end
