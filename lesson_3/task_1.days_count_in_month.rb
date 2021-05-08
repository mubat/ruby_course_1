# frozen_string_literal: true
### Create hash with amount of the days in the month. Print month with days = 30
require "date"

months = {}

(1..12).each do |month|
  date = Date.new 2020, month, -1
  months[date.strftime("%B")] = date.day
end

puts "Months with days = 30:"
months.each { |month, days| puts month if days == 30 }
