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
    @input_capacity = nil
    @input_seats = nil
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
      puts "8. Take a seat/capacity in train"
      puts "9. Move trains to the station"
      puts "10. List stations and trains on them"
      puts "11. List all the trains and wagons attached"
      puts "12. Exit"
      puts "---------------------------------"

      input_top = gets.chomp.to_i
      break if input_top == 12

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
        take_seat_capacity
      when 9
        move_to_station
      when 10
        list_all_stations_and_trains
      when 11
        list_trains
      end
    end
  end

  private

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
  attr_accessor :input_capacity
  attr_accessor :input_seats

  def create_station
    input_station_name = nil
    loop do
      puts "Enter the station's name:"
      input_station_name = gets.chomp
      break if input_station_name != "" &&
               !stations.any? { |s| s.name == input_station_name }
      if stations.any? { |s| s.name == input_station_name }
        puts "Station with this name is already exist. Pick another name."
      end
    end

    s = Station.new(input_station_name)

    stations << s
    puts "A new station \"#{input_station_name}\" has been created."
  end

  def create_train
    input_train_number = nil

    loop do
      puts "Enter the train's number:"
      input_train_number = gets.chomp
      break if input_train_number != "0" && input_train_number != "" &&
               !trains.any? { |t| t.number == input_train_number }
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
          passenger_trains << p
          trains << p
          puts "A new passenger train ##{input_train_number} has been created."
          break
        when 2
          c = CargoTrain.new(input_train_number)
          cargo_trains << c
          trains << c
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
      break if input_route_number != "0" && input_route_number != "" &&
               !routes.any? { |r| r.number == input_route_number }
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

    r = Route.new(number: input_route_number, stations: input_base_stations)

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

      break unless input_intermediate_stations.include?(nil)
      if input_intermediate_stations.include?(nil)
        puts "An error occured. Perhaps you misspelled one or more of the stations."
      end
    end

    if input_intermediate_stations != ["exit"]
      if r.add_intermediates?(input_intermediate_stations)
        puts "#{input_intermediate_stations.join(', ')} stations added to the route."
      else
        puts "An error occured. Intermediate stations weren't added to the route."
      end
    end

    routes << r
    puts "Route ##{r.number} has been created (#{r.list_stations_names})."
  end

  def assign_route
    select_train "Pick a train by number:"
    select_route "Pick a route by number"

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
      break if input_wagon_number != "0" && input_wagon_number != "" &&
               !wagons.any? { |w| w.number == input_wagon_number }
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

      begin
        puts "Enter the number of seats"
        input_seats = gets.chomp.to_i
        pw = PassengerWagon.new(number: input_wagon_number, seats: input_seats)
      rescue RuntimeError => e
        puts e.message
        retry
      end

      passenger_wagons << pw
      wagons << pw
      puts "A new passenger wagon ##{input_wagon_number} with #{input_seats} seats was created."
    when 2

      begin
        puts "Enter the wagon's capacity"
        input_capacity = gets.chomp.to_f
        cw = CargoWagon.new(number: input_wagon_number, capacity: input_capacity)
      rescue RuntimeError => e
        puts e.message
        retry
      end

      cargo_wagons << cw
      wagons << cw
      puts "A new cargo wagon ##{input_wagon_number} with #{input_capacity} capacity was created."
    end
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

    if input_train.wagons.any?
      loop do
        puts "Choose a wagon to detach:"
        input_train.wagons.each do |w|
          puts "Wagon ##{w.number}"
        end
        input_wagon_number = gets.chomp
        break if input_wagon_number != "0" &&
                 input_wagon_number != "" &&
                 input_train.wagons.any? { |w| w.number == input_wagon_number }
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

  def take_seat_capacity
    select_wagon("Which wagon?")
    if input_wagon.is_a? PassengerWagon

      loop do
        puts "Enter how many seats do you want to take. Currently there are #{input_wagon.empty_seats} empty and #{input_wagon.taken_seats} taken seats."
        self.input_seats = gets.chomp.to_i
        break if input_seats.nonzero? && input_seats <= input_wagon.empty_seats
      end

      if input_wagon.take_seats?(input_seats)
        puts "Seats are taken. Currently there are #{input_wagon.empty_seats} empty and #{input_wagon.taken_seats} taken seats."
      else
        puts "An error occured, seata were NOT taken. Currently there are #{input_wagon.empty_seats} empty and #{input_wagon.taken_seats} taken seats."
      end

    elsif input_wagon.is_a? CargoWagon

      loop do
        puts "Enter the capacity to take. Currently there is #{input_wagon.empty_capacity} available."
        self.input_capacity = gets.chomp.to_f
        break if input_capacity.nonzero? && input_capacity <= input_wagon.empty_capacity
      end

      if input_wagon.take_capacity?(input_capacity)
        puts "Capacity of #{input_capacity} is taken. Currently there is #{input_wagon.empty_capacity} empty and #{input_wagon.taken_capacity} taken capacity."
      else
        puts "An error occured, capacity was NOT taken. Currently there is #{input_wagon.empty_capacity} empty and #{input_wagon.taken_capacity} taken capacity."
      end

    end
  end

  def move_to_station
    select_train("What train would you like to move?")

    unless input_train.route?
      puts "Assign a route to this train first."
      return
    end

    input_station = nil
    loop do
      puts "To which station?"
      list_stations
      input_station = gets.chomp
      input_station = stations.detect { |s| s.name == input_station }
      break unless input_station.nil?
      if input_station.nil?
        puts "There are no stations with this name, please enter another one."
      end
    end

    if input_train.move_to_station?(input_station)
      puts "Train ##{input_train} successfully moved to #{input_station} station."
    else
      puts "An error occured!"
    end
  end

  def list_all_stations_and_trains
    puts "List of all stations and trains on them:"
    stations.each do |s|
      puts "#{s.name}:"
      list_trains_on_station(s)
    end
  end

  def list_trains_on_station(station)
    if !station.trains.empty?
      station.fetch_trains do |t|
        puts "Train ##{t.number}, #{t.type}, #{t.wagons.count} wagons:"
        list_wagons_attached(t)
      end
    else
      puts "There are no trains on this station."
    end
    puts "---------------------------------"
  end

  def list_wagons_attached(train)
    if !train.wagons.empty?
      train.fetch_wagons do |w|
        if w.is_a? PassengerWagon
          puts " - Wagon ##{w.number}, empty seats: #{w.empty_seats}, taken seats: #{w.taken_seats}"
        elsif w.is_a? CargoWagon
          puts " - Wagon ##{w.number}, empty capacity: #{w.empty_capacity}, taken capacity: #{w.taken_capacity}"
        end
      end
    else
      puts " - There are no wagons attached."
    end
  end

  def list_stations
    if stations.any?
      stations.each do |s|
        puts s.name
      end
    else
      puts "There are currently no stations."
    end
  end

  def list_trains(type = "all")
    case type
    when "all"
      list_passenger_trains
      list_cargo_trains
    when "passenger"
      list_passenger_trains
    when "cargo"
      list_cargo_trains
    end
  end

  def list_passenger_trains
    if !passenger_trains.empty?
      passenger_trains.each do |t|
        puts "Passenger train ##{t.number}, #{t.wagons.count} wagons:"
        list_wagons_attached(t)
      end
    else
      puts "There are currently no passenger trains."
    end
  end

  def list_cargo_trains
    if cargo_trains.any?
      cargo_trains.each do |t|
        puts "Cargo train ##{t.number}, #{t.wagons.count} wagons:"
        list_wagons_attached(t)
      end
    else
      puts "There are currently no cargo trains."
    end
  end

  def list_wagons
    if passenger_wagons.any?
      passenger_wagons.each { |w| puts "Passenger wagon ##{w.number}" }
    else
      puts "There are currently no passenger wagons."
    end
    if cargo_wagons.any?
      cargo_wagons.each { |w| puts "Cargo wagon ##{w.number}" }
    else
      puts "There are currently no cargo wagons."
    end
  end

  def list_routes
    if routes.any?
      routes.each { |r| puts "Route ##{r.number}" }
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
      break unless input_train.nil?
      if input_train.nil?
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
      break unless input_route.nil?
      if input_route.nil?
        puts "There are no routes with this number, please enter another one."
      end
    end
  end

  def select_wagon(message)
    self.input_wagon = nil
    loop do
      puts message
      list_wagons
      input_wagon_number = gets.chomp
      self.input_wagon = wagons.detect { |w| w.number == input_wagon_number }
      break unless input_wagon.nil?
      if input_wagon.nil?
        puts "There are no wagons with this number, please enter another one."
      end
    end
  end
end
