puts "Hey, what's your triangle's first side? (cm)"
a = gets.chomp.to_f
puts "And what's your triangle's second side? (cm)"
b = gets.chomp.to_f
puts "What's about third side? (cm)"
c = gets.chomp.to_f

def is_isosceles?(a, b, c)
  a == b || b == c || a == c
end

def is_rectangular?(a, b, c)
  a ** 2 + b ** 2 == c ** 2 || a ** 2 + c ** 2 == b ** 2 || c ** 2 + b ** 2 == a ** 2
end

def is_equilateral?(a, b, c)
  a == b && b == c
end

if is_equilateral?(a, b, c)
  puts "The triangle with sides of #{a}, #{b} and #{c} is equilateral."
elsif is_isosceles?(a, b, c) && is_rectangular?(a, b, c)
  puts "The triangle with sides of #{a}, #{b} and #{c} is isosceles and rectangular."
elsif is_isosceles?(a, b, c)
  puts "The triangle with sides of #{a}, #{b} and #{c} is isosceles but not rectangular."
elsif is_rectangular?(a, b, c)
  puts "The triangle with sides of #{a}, #{b} and #{c} is rectangular."
else
  puts "The triangle with sides of #{a}, #{b} and #{c} is not regular."
end