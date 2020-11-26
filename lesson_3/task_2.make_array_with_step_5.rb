### Заполнить массив числами от 10 до 100 с шагом 5
result_array = []
(10..100).each {|i| result_array.push(i) if i % 5 == 0 }

#second variant
for i in 10..100 do 
  if i % 5 == 0
    result_array.push(i)
  end
end
puts result_array

#third variant
10.upto(100) {|i| result_array.push(i) if i % 5 == 0 }
puts result_array