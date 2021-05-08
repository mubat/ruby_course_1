### Amount of purchaises

basket = {}
total_amount = 0.0
loop do

  print "Введите название товара: "
  product_name = gets.chomp

  if product_name.downcase == 'стоп'
    break
  end

  basket[product_name] = {}
  print "Введите цену: "
  basket[product_name]['product_price'] = gets.chomp.to_f.abs
  print "Введите количество: "
  basket[product_name]['product_count'] = gets.chomp.to_i.abs

  total_amount += basket[product_name]['product_price'] * basket[product_name]['product_count']
end


puts "В корзине лежит следующее"
basket.each do |product_name, product_data|
  puts " * #{product_name} - #{product_data['product_count']} шт. по цене #{product_data['product_price']} тугриков за штуку"
end
puts "В итоге получилось #{total_amount.round(2)} тугриков за всё"
