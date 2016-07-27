class RailwayManager
  
  def initialize
    @trains = []
    @passenger_trains = []
    @cargo_trains = []
    @wagons = []
    @passenger_wagons = []
    @cargo_wagons = []
    @stations = []
    @routes = []
    @input_train = nil
    @input_route = nil
    @input_wagon = nil
  end
  
  def run
    loop do
      puts "---------------------------------"
      puts "What would you like to do?"
      puts "---------------------------------"
      puts "1. Create a station"
      puts "2. Create a train"
      puts "3. Create a route"
      puts "4. Assign the route to the train"
      puts "5. Create a wagon"
      puts "6. Attach wagons"
      puts "7. Detach wagons"
      puts "8. Move trains to the station"
      puts "9. List stations and trains on them"
      puts "10. List all the trains and wagons attached"
      puts "11. Exit"
      puts "---------------------------------"

      input_top = gets.chomp.to_i
      break if input_top == 11

      case input_top
        when 1
          create_station
        when 2
          create_train
        when 3
          create_route
        when 4
          assign_route
        when 5
          create_wagon
        when 6
          attach_wagons
        when 7
          detach_wagons
        when 8
          move_to_station
        when 9
          list_stations_and_trains
        when 10
          list_trains
      end
    end
  end
  
  protected
  
  attr_accessor :trains
  attr_accessor :passenger_trains
  attr_accessor :cargo_trains
  attr_accessor :wagons
  attr_accessor :passenger_wagons
  attr_accessor :cargo_wagons
  attr_accessor :stations
  attr_accessor :routes
  attr_accessor :input_train
  attr_accessor :input_route
  attr_accessor :input_wagon
  
  def create_station
    input_station_name = nil
    loop do
      puts "Enter the station's name:"
      input_station_name = gets.chomp
      break if input_station_name != "" && !stations.any? { |s| s.name == input_station_name }
      if stations.any? { |s| s.name == input_station_name }
        puts "Station with this name is already exist. Pick another name."
      end
    end
    
    s = Station.new(input_station_name)
    
    self.stations << s
    puts "A new station \"#{input_station_name}\" has been created."
  end
  
  def create_train
    input_train_number = nil

    loop do
      puts "Enter the train's number:"
      input_train_number = gets.chomp
      break if input_train_number != 0 && !trains.any? { |t| t.number == input_train_number }
      if trains.any? { |t| t.number == input_train_number }
        puts "Train with this number is already exist. Pick another number."
      end
    end

    input_train_type = nil
    loop do
      puts "Would it be a passenger or a cargo train?"
      puts "---------------------------------"
      puts "1. A passenger train"
      puts "2. A cargo train"
      puts "---------------------------------"

      input_train_type = gets.chomp.to_i
      
      if input_train_type == 1 || input_train_type == 2
        case input_train_type
          when 1
            p = PassengerTrain.new(input_train_number)
            self.passenger_trains << p
            self.trains << p
            puts "A new passenger train ##{input_train_number} has been created."
            break
          when 2
            c = CargoTrain.new(input_train_number)
            self.cargo_trains << c
            self.trains << c
            puts "A new cargo train ##{input_train_number} has been created."
            break
        end
      else
        puts "There's no such type of train. Please pick 1 or 2."
      end
    end
  rescue RuntimeError
    puts "Train number format is not valid. It should look like 4d1-33 or 2957l. Please try again."
    retry  
  end
  
  def create_route
    input_route_number = nil
    loop do
      puts "Enter the route's number:"
      input_route_number = gets.chomp
      break if input_route_number != 0 && !routes.any? { |r| r.number == input_route_number }
      if routes.any? { |r| r.number == input_route_number }
        puts "Route with this number is already exist. Pick another number."
      end
    end
    
    input_base_stations = nil
    loop do
      puts "Enter dispatch and destination stations names (comma separated):"
      puts "List of stations:"
      list_stations
      input_base_stations = gets.chomp.split(", ")
      
      bs_list = []
      input_base_stations.each do |bs|
        bs_list << stations.detect { |s| s.name == bs }
      end
      input_base_stations = bs_list
      
      break if !input_base_stations.include?(nil) && input_base_stations.size == 2
      if input_base_stations.include?(nil) || input_base_stations.size != 2
        puts "An error occured. Perhaps you misspelled one or more of the stations."
      end
    end
    
    r = Route.new(input_route_number, input_base_stations)
    
    input_intermediate_stations = nil
    loop do
      puts "Enter intermediate stations names (comma separated) if any. Otherwise type \"exit\"."
      puts "List of stations:"
      list_stations
      input_intermediate_stations = gets.chomp.split(", ")
      
      break if input_intermediate_stations == ["exit"]
      
      is_list = []
      input_intermediate_stations.each do |is|
        is_list << stations.detect { |s| s.name == is }
      end
      input_intermediate_stations = is_list

      break if !input_intermediate_stations.include?(nil)
      if input_intermediate_stations.include?(nil)
        puts "An error occured. Perhaps you misspelled one or more of the stations."
      end
    end
    
    if input_intermediate_stations != ["exit"]
      if r.add_intermediates?(input_intermediate_stations)
        puts "#{input_intermediate_stations.join(", ")} stations added to the route."
      else
        puts "An error occured. Intermediate stations weren't added to the route."
      end
    end
    
    self.routes << r
    puts "Route ##{r.number} has been created (#{r.list_stations_names})."
  end
  
  def assign_route
    select_train ("Pick a train by number:")
    select_route ("Pick a route by number")

    if input_train.add_route?(input_route)
      puts "Route ##{input_route.number} assigned to Train ##{input_train.number}."
    else
      puts "An error occured!"
    end
  end
  
  def create_wagon
    input_wagon_number = nil
    loop do
      puts "Enter the wagons's number:"
      input_wagon_number = gets.chomp
      break if input_wagon_number != 0 && !wagons.any? { |w| w.number == input_wagon_number }
      if wagons.any? { |w| w.number == input_wagon_number }
        puts "Wagon with this number is already exist. Pick another number."
      end
    end

    puts "Would it be a passenger or a cargo wagon?"
    puts "---------------------------------"
    puts "1. A passenger wagon"
    puts "2. A cargo wagon"
    puts "---------------------------------"

    input_wagon_type = gets.chomp.to_i

    case input_wagon_type
      when 1
        w = PassengerWagon.new(input_wagon_number)
        self.passenger_wagons << w
        self.wagons << w
        puts "A new passenger wagon ##{input_wagon_number} has been created."
      when 2
        w = CargoWagon.new(input_wagon_number)
        self.cargo_wagons << w
        self.wagons << w
        puts "A new cargo wagon ##{input_wagon_number} has been created."
    end
    wagons.each { |w| puts w.number }
  end
  
  def attach_wagons
    select_train("Pick a train (by number) to attach a wagon:")
    select_wagon("A list of available wagons to attach:")

    if !input_wagon.attached
      if input_train.attach_wagon?(input_wagon)
        puts "Wagon ##{input_wagon.number} was successfully attached to the train ##{input_train.number}."
      else
        puts "An error occured. Wagon wasn't attached to the train. Check the wagon type."
      end
    else
      puts "This wagon is already attached."
    end
  end
  
  def detach_wagons
    select_train("Pick a train (by number) to detach a wagon:")
    
    if input_train.wagons.size > 0
      loop do
        puts "Choose a wagon to detach:"
        input_train.wagons.each do |w|
          puts "Wagon ##{w.number}"
        end
        input_wagon_number = gets.chomp
        break if input_wagon_number != 0 && input_train.wagons.any? { |w| w.number == input_wagon_number }
      end
      
      if input_train.detach_wagon?(input_wagon)
        puts "Wagon ##{input_wagon.number} was successfully detached from the train ##{input_train.number}."
      else
        puts "An error occured. Wagon wasn't detached from the train."
      end
        
    else
      puts "There are no wagons attached to this train."
    end
  end
  
  def move_to_station
    select_train("What train would you like to move?")

    if !input_train.route?
      puts "Assign a route to this train first."
      return
    end
    
    input_station = nil
    loop do
      puts "To which station?"
      list_stations
      input_station = gets.chomp
      input_station = stations.detect { |s| s.name == input_station }
      break if input_station != nil
      if input_station == nil
        puts "There are no stations with this name, please enter another one."
      end
    end
    
    # ???
    if input_train.move_to_station?(input_station)
      puts "Train ##{input_train} successfully moved to #{input_station} station."
    else
      puts "An error occured!"
    end
  end
  
  def list_stations_and_trains
    puts "List of all stations and trains on them:"
    stations.each do |s|
      puts s.name
      if s.trains.size > 0
        puts "Trains on this station:"
        s.trains.each { |t| puts "Train ##{t.number} (#{t.type})" }
      else
        puts "There are currently no trains on this station."
      end
      puts "---------------------------------"
    end
  end
  
  def list_stations
    if stations.size > 0
      stations.each do |s|
        puts s.name
      end
    else
      puts "There are currently no stations."
    end
  end
  
  def list_trains(type="all")
    case type
      when "all"
        if passenger_trains.size > 0
          passenger_trains.each do |t|
            puts "Passenger train ##{t.number}"
            list_wagons_attached(t)
          end
        else
          puts "There are currently no passenger trains."
        end
        if cargo_trains.size > 0
          cargo_trains.each do |t|
            puts "Cargo train ##{t.number}"
            list_wagons_attached(t)
          end
        else
          puts "There are currently no cargo trains."
        end
      when "passenger"
        if passenger_trains.size > 0
          passenger_trains.each do |t|
            puts "Passenger train ##{t.number}"
            list_wagons_attached(t)
          end
        else
          puts "There are currently no passenger trains."
        end
      when "cargo"
        if cargo_trains.size > 0
          cargo_trains.each do |t|
            puts "Cargo train ##{t.number}"
            list_wagons_attached(t)
          end
        else
          puts "There are currently no cargo trains."
        end
    end
  end
  
  def list_wagons_attached(train)
    if train.wagons.size > 0
      wagons_numbers = train.wagons.map { |w| "##{w.number}" }
      print " - Wagons attached: "
      print wagons_numbers.join(", ")
      puts "."
    else
      puts " - No wagons attached"
    end
  end
    
  def list_wagons(type="all")
    case type
      when "all"
        if passenger_wagons.size > 0
          passenger_wagons.each do |w|
            puts "Passenger wagon ##{w.number}"
          end
        else
          puts "There are currently no passenger wagons."
        end
        if cargo_wagons.size > 0
          cargo_wagons.each do |w|
            puts "Cargo wagon ##{w.number}"
          end
        else
          puts "There are currently no cargo wagons."
        end
      when "passenger"
        if passenger_wagons.size > 0
          passenger_wagons.each do |w|
            puts "Passenger wagon ##{w.number}"
          end
        else
          puts "There are currently no passenger wagons."
        end
      when "cargo"
        if cargo_wagons.size > 0
          cargo_wagons.each do |w|
            puts "Cargo wagon ##{w.number}"
          end
        else
          puts "There are currently no cargo wagons."
        end
    end
  end
  
  def list_routes
    if routes.size > 0
      routes.each do |r|
        puts "Route ##{r.number}"
      end
    else
      puts "There are currently no routes."
    end
  end
  
  def select_train(message)
    self.input_train = nil
    loop do
      puts message
      list_trains
      input_train_number = gets.chomp
      self.input_train = trains.detect { |t| t.number == input_train_number }
      break if input_train != nil
      if input_train == nil
        puts "There are no trains with this number, please enter another one."
      end
    end
  end
  
  def select_route(message)
    self.input_route = nil
    loop do
      puts message
      list_routes
      input_route_number = gets.chomp
      self.input_route = routes.detect { |r| r.number == input_route_number }
      break if input_route != nil
      if input_route == nil
        puts "There are no routes with this number, please enter another one."
      end
    end
  end
  
  def select_wagon(message)
    self.input_wagon = nil
    loop do
      puts message
      if input_train.class == PassengerTrain
        list_wagons("passenger")
      elsif input_train.class == CargoTrain
        list_wagons("cargo")
      end
      input_wagon_number = gets.chomp
      self.input_wagon = wagons.detect { |w| w.number == input_wagon_number }
      break if input_wagon != nil
      if input_wagon == nil
        puts "There are no wagons with this number, please enter another one."
      end
    end
  end
  
end