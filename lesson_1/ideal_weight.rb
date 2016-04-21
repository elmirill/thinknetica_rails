puts "What's your name?"
user_name = gets.chomp
puts "Hey #{user_name}, what's your height?"
user_height = gets.chomp.to_i

user_optimal_weight = user_height - 110

if user_optimal_weight < 0
  puts "#{user_name}, your weight is already optimal."
else
  puts "#{user_name}, your optimal weight is #{user_optimal_weight}."
end