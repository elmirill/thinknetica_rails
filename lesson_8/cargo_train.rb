class CargoTrain < Train
  def attach_wagon(wagon)
    super(wagon) if wagon.is_a? CargoWagon
  end
end
