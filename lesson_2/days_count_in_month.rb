### Сделать хеш, содержащий месяцы и количество дней в месяце. В цикле выводить те месяцы, у которых количество дней ровно 30
require 'date'

months = Hash.new

(1..12).each do |month|
  date = Date.new 2020, month, -1
  months[date.strftime("%B")] = date.day
end

puts 'Months with days = 30:'
months.each { |month, days| puts month if days == 30 }