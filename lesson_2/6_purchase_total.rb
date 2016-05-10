products_list = {}

loop do
  puts "Enter the product name:"
  product_name = gets.chomp
  break if product_name == "stop"
  puts "Enter the product price (per one):"
  product_price = gets.chomp.to_f
  puts "Enter the product quantity:"
  product_quantity = gets.chomp.to_f
  
  products_list[product_name.to_sym] = { price: product_price, quantity: product_quantity }
end

def calculate_products_total(products_list)
  products_total_list = []
  super_total = 0
  products_list.each do |product_name, product_stats|
    product_total = product_stats[:price] * product_stats[:quantity]
    puts "Total for #{product_name}: #{product_total} golds."
    super_total += product_total
  end
  
  puts "Total for all products: #{super_total} golds."
end

puts products_list
puts calculate_products_total(products_list)