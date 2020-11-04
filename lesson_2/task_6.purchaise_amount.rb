### Сумма покупок
# Пользователь вводит поочередно название товара, цену за единицу и кол-во 
# купленного товара (может быть нецелым числом). Пользователь может ввести 
# произвольное кол-во товаров до тех пор, пока не введет "стоп" в качестве 
# названия товара. На основе введенных данных требуетеся:
# Заполнить и вывести на экран хеш, ключами которого являются названия товаров,
# а значением - вложенный хеш, содержащий цену за единицу товара и кол-во
# купленного товара. Также вывести итоговую сумму за каждый товар.
# Вычислить и вывести на экран итоговую сумму всех покупок в "корзине".

basket = Hash.new
total_amount = 0.0
loop do 

  print "Введите название товара: "
  product_name = gets.chomp

  if product_name.downcase == 'стоп'
    break
  end

  basket[product_name] = Hash.new
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