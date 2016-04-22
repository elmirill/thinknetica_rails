puts "Hey, what's your triangle's base? (cm)"
triangle_base = gets.chomp.to_f
puts "And what's your triangle's height? (cm)"
triangle_height = gets.chomp.to_f

triangle_area = triangle_base * triangle_height / 2

puts "Here you go, area of your triangle is #{triangle_area} square centimeters."