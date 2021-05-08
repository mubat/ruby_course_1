# frozen_string_literal: true

### Create and array with numbers with step by 5
result_array = []
(10..100).each {|i| result_array.push(i) if (i % 5).zero? }

#second variant
for i in 10..100 do
  result_array.push(i) if (i % 5).zero?
end
puts result_array

#third variant
10.upto(100) {|i| result_array.push(i) if (i % 5).zero? }
puts result_array
