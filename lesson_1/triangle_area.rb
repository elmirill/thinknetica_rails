puts "Hey, what's your triangle's base? (cm)"
triangle_base = gets.chomp.to_i
puts "And what's your triangle's height? (cm)"
triangle_height = gets.chomp.to_i

triangle_area = triangle_base * triangle_height

puts "Here you go, area of your triangle is #{triangle_area} square centimeters."