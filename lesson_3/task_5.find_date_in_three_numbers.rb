# frozen_string_literal: true
### Get serial number of the date by the date

def is_leap?(year)
  year % 4 == 0 && year % 100 != 0 && year % 400 == 0
end

print "Введите год: "
year = gets.chomp.to_i
print "Введите месяц: "
month = gets.chomp.to_i
print "Введите день: "
day = gets.chomp.to_i

days_in_month = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
days_in_year = day

month.times do |current_month|
  days_in_year += days_in_month[current_month]
  if month == 2 && is_leap(year)
    days_in_year += 1
  end
end

puts "В #{year} насчитывается #{days_in_year} дней."
