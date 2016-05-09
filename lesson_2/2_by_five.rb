by_five = Array.new

(10..100).step(5) { |num| by_five << num.to_i }

puts by_five