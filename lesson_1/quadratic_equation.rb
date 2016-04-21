puts "You have an quadratic equation of the type ax^2 + bx + c = 0"
puts "Enter the a coefficient:"
a = gets.chomp.to_f
puts "Enter the b coefficient:"
b = gets.chomp.to_f
puts "Enter the c coefficient:"
c = gets.chomp.to_f

d = b ** 2 - 4 * a * c

if d < 0
  puts "There're no roots of the equation #{a}x^2 + #{b}x + #{c} = 0. The discriminant is #{d}."
elsif d == 0
  x = -b / (a * 2)
  puts "There's a single root of the equation #{a}x^2 + #{b}x + #{c} = 0: x = #{x}. The discriminant is #{d}."
else
  d_root = Math.sqrt(d)
  x1 = (-b + d_root) / (a * 2)
  x2 = (-b - d_root) / (a * 2)
  puts "There're two roots of the equation #{a}x^2 + #{b}x + #{c} = 0: x1 = #{x1}, x2 = #{x2}. The discriminant is #{d}."
end
