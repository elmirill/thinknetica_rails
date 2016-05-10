puts "Enter the date (dd.mm.yyyy):"
user_input = gets.chomp.split(".")

day = user_input[0].to_i
month = user_input[1].to_i
year = user_input[2].to_i

def leap_year?(year)
  year % 400 == 0 || year % 4 == 0 && year % 100 != 0
end

def calculate_day_index(day, month, year)
  feb = leap_year?(year) ? 29 : 28
  months_list = [31, feb, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
  months_list.first(month - 1).inject(0) { |sum, month| sum + month } + day
end
  
puts "#{day}.#{month} is a #{calculate_day_index(day, month, year)}'s day of #{year}."