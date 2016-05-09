goods_list = {}

while true do
  puts "Enter the good's name:"
  goods_name = gets.chomp
  break if goods_name == "stop"
  puts "Enter the goods price (per one):"
  goods_price = gets.chomp.to_f
  puts "Enter the good's quantity:"
  goods_quantity = gets.chomp.to_f
  
  goods_list[goods_name.to_sym] = { price: goods_price, quantity: goods_quantity }
end

def calculate_goods_total(goods_list)
  goods_list.each do |g_name, g_stats|
    puts "Total for #{g_name}: #{g_stats[:price] * g_stats[:quantity]} golds."
  end
  
  # To prevent returning the hash second time
  return
end

def calculate_super_total(goods_list)
  g_total_list = []
  goods_list.each do |g_name, g_stats|
    g_total = g_stats[:price] * g_stats[:quantity]
    g_total_list << g_total
  end
  super_total = g_total_list.inject(0) { |sum, g| sum + g }
  puts "Total for all goods: #{super_total} golds."
end

puts goods_list
puts calculate_goods_total(goods_list)
puts calculate_super_total(goods_list)