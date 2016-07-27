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
require_relative 'railway_manager.rb'

m = RailwayManager.new

m.run