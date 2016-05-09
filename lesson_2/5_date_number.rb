puts "Enter the date (dd.mm.yyyy):"
user_input = gets.chomp.split(".")

day = user_input[0].to_i
month = user_input[1].to_i
year = user_input[2].to_i

def leap_year?(year)
  year % 400 == 0 || year % 4 == 0 && year % 100 != 0
end

def calculate_multiple_months(months, month, day)
  months.first(month - 1).inject(0) { |sum, month| sum + month } + day
end

regular_months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
leap_months = [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

if month == 1
  number = day
elsif leap_year?(year)
  number = calculate_multiple_months(leap_months, month, day)
else
  number = calculate_multiple_months(regular_months, month, day)
end
  
puts "#{day}.#{month} is a #{number}'s day of #{year}."