# frozen_string_literal: true

### Create and array with numbers with step by 5
result_array = []
(10..100).each {|i| result_array.push(i) if (i % 5).zero? }

#second variant
for i in 10..100 do
  if (i % 5).zero?
    result_array.push(i)
  end
end
puts result_array

#third variant
10.upto(100) {|i| result_array.push(i) if (i % 5).zero? }
puts result_array
