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
  products_list.each do |product_name, product_stats|
    product_total = product_stats[:price] * product_stats[:quantity]
    puts "Total for #{product_name}: #{product_total} golds."
    products_total_list << product_total
  end
  
  super_total = products_total_list.inject(0) { |sum, p| sum + p }
  puts "Total for all products: #{super_total} golds."
end

puts products_list
puts calculate_products_total(products_list)