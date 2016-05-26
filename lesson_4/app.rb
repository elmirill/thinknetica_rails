# File for testing purposes

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
$kings_cross_to_hogsmeade = Route.new([$kings_cross, $hogsmeade])
$hill_valley_to_worlds_end = Route.new([$hill_valley, $worlds_end])
$worlds_end_to_westcombe_at_sea = Route.new([$worlds_end, $westcombe_at_sea])

# Creating trains
$hogwarts_express = PassengerTrain.new(8)
$the_elb = CargoTrain.new(1)

# Creating wagons
$p_wagon_1 = PassengerWagon.new(1)
$p_wagon_2 = PassengerWagon.new(2)
$c_wagon_1 = CargoWagon.new(1)
$c_wagon_2 = CargoWagon.new(2)

# Adding intermediate stations
$kings_cross_to_hogsmeade.add_intermediate($chufnell_regis)
$kings_cross_to_hogsmeade.add_intermediate($westcombe_at_sea)
$hill_valley_to_worlds_end.add_intermediate($hogsmeade)
$hill_valley_to_worlds_end.add_intermediate($kings_cross)
$hill_valley_to_worlds_end.add_intermediate($chufnell_regis)
$worlds_end_to_westcombe_at_sea.add_intermediate($hill_valley)

# Setting relations
$kings_cross.accept_train($hogwarts_express)
$kings_cross.accept_train($the_elb)

$the_elb.add_route($hill_valley_to_worlds_end)
$the_elb.move_to_station("World's End")
$the_elb.attach_wagon($c_wagon_1)
$the_elb.attach_wagon($c_wagon_2)

$hogwarts_express.attach_wagon($p_wagon_1)
$hogwarts_express.attach_wagon($p_wagon_2)
