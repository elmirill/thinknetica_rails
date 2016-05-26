require_relative 'station.rb'
require_relative 'route.rb'
require_relative 'train.rb'
require_relative 'passenger_train.rb'
require_relative 'cargo_train.rb'
require_relative 'wagon.rb'
require_relative 'passenger_wagon.rb'
require_relative 'cargo_wagon.rb'
#require_relative 'app.rb'

loop do
  
  puts "What would you like to do?"
  puts "---------------------------------"
  puts "1. Create a station"
  puts "2. Create a train"
  puts "3. Attach wagons"
  puts "4. Detach wagons"
  puts "5. Move trains to the station"
  puts "6. List stations and trains on them"
  puts "7. Exit"
  puts "---------------------------------"

  input_top = gets.chomp.to_i
  break if input_top == 7

  case input_top
    when 1
      input_station_name = nil
      loop do
        puts "Enter the station's name:"
        input_station_name = gets.chomp
        break if input_station_name != ""
      end
      Station.new(input_station_name)
    puts "A new station \"#{input_station_name}\" has been created."
    when 2
      input_train_number = nil
    
      loop do
        puts "Enter the train's number:"
        input_train_number = gets.chomp.to_i
        break if input_train_number != "0"
      end

      puts "Would it be a passenger or a cargo train?"
      puts "---------------------------------"
      puts "1. A passenger train"
      puts "2. A cargo train"
      puts "---------------------------------"

      input_train_type = gets.chomp.to_i

      case input_train_type
        when 1
          PassengerTrain.new(input_train_number)
        puts "A new passenger train ##{input_train_number} has been created."
        when 2
          CargoTrain.new(input_train_number)
          puts "A new cargo train ##{input_train_number} has been created."
      end
    when 3
    # Start wagons attaching dialogue
    when 4
    # Start wagons detaching dialogue
    when 5
    input_train_move = nil
    input_station_move = nil
    
    loop do
      puts "What train would you like to move?"
      input_train_move = gets.chomp
      break if input_train_move != ""
    end
    
    loop do
      puts "To which station?"
      input_station_move = gets.chomp
      break if input_station_move != ""
    end
    
    if !PassengerTrain.where_number_is(input_train_move).nil? && !Station.where_name_is(input_station_move).nil?
      PassengerTrain.where_number_is(input_train_move).move_to_station(Station.where_name_is(input_station_move))
    elsif !CargoTrain.where_number_is(input_train_move).nil? && !Station.where_name_is(input_station_move).nil?
      CargoTrain.where_number_is(input_train_move).move_to_station(Station.where_name_is(input_station_move))
    else
      puts "An error occured! Check the train's number and the station's name."
    end
    when 6
    puts "List of all stations and trains on them:"
    Station.all.each do |s|
      puts s.name
      if s.trains.size > 0
        puts "Trains on this station:"
        s.trains.each { |t| puts "Train ##{t.number}" }
      else
        puts "There are currently no trains on this station."
      end
      puts "---------------------------------"
    end
  end
  
end