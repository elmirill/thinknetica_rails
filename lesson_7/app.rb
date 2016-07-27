# File for testing purposes

require_relative 'modules/instance_counter.rb'
require_relative 'modules/manufacturer.rb'
require_relative 'station.rb'
require_relative 'route.rb'
require_relative 'train.rb'
require_relative 'passenger_train.rb'
require_relative 'cargo_train.rb'
require_relative 'wagon.rb'
require_relative 'passenger_wagon.rb'
require_relative 'cargo_wagon.rb'

# Creating stations
$kings_cross = Station.new("King's Cross")
$hill_valley = Station.new("Hill Valley")
$chufnell_regis = Station.new("Chufnell Regis")
$westcombe_at_sea = Station.new("Westcombe-on-Sea")
$hogsmeade = Station.new("Hogsmeade")
$worlds_end = Station.new("World's End")

# Creating routes
$kings_cross_to_hogsmeade = Route.new("1", [$kings_cross, $hogsmeade])
$hill_valley_to_worlds_end = Route.new("2", [$hill_valley, $worlds_end])
$worlds_end_to_westcombe_at_sea = Route.new("3", [$worlds_end, $westcombe_at_sea])

# Creating trains
$hogwarts_express = PassengerTrain.new("235-91")
$the_elb = CargoTrain.new("91181")

# Creating wagons
$p_wagon_1 = PassengerWagon.new("g54", 50)
$p_wagon_2 = PassengerWagon.new("k11", 30)
$c_wagon_1 = CargoWagon.new("p30", 135)
$c_wagon_2 = CargoWagon.new("b65", 190)

13.times { $p_wagon_1.take_seat }
30.times { $p_wagon_2.take_seat }
$c_wagon_1.take_capacity(130)
$c_wagon_2.take_capacity(190)

# Adding intermediate stations
$kings_cross_to_hogsmeade.add_intermediates([$chufnell_regis, $westcombe_at_sea])
$hill_valley_to_worlds_end.add_intermediates([$hogsmeade, $kings_cross])
$hill_valley_to_worlds_end.add_intermediates([$chufnell_regis, $hill_valley])

# Setting relations
$kings_cross.accept_train($hogwarts_express)
$kings_cross.accept_train($the_elb)

$the_elb.add_route($hill_valley_to_worlds_end)
$the_elb.move_to_station("World's End")
$the_elb.attach_wagon($c_wagon_1)
$the_elb.attach_wagon($c_wagon_2)

$hogwarts_express.attach_wagon($p_wagon_1)
$hogwarts_express.attach_wagon($p_wagon_2)



# Display stations
# К каждому типу поездов мы цепляем свой тип вагонов, поэтому я не стал указывать тип у каждого вагона.
Station.all.each do |s|
  puts "#{s.name}:"
  if s.trains.size > 0
    s.fetch_trains do |t|
      puts "Train ##{t.number}, #{t.type}, #{t.wagons.count} wagons:"
      t.fetch_wagons do |w|
        if w.is_a? PassengerWagon
          puts " - Wagon ##{w.number}, empty seats: #{w.empty_seats}, taken seats: #{w.taken_seats}"
        elsif w.is_a? CargoWagon
          puts " - Wagon ##{w.number}, empty capacity: #{w.empty_capacity}, taken capacity: #{w.taken_capacity}"
        end
      end
    end
  else
    puts "There are no trains on this station."
  end
  puts "---------------------------------"
end