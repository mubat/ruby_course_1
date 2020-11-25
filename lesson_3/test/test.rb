require_relative '../Station.rb'
require_relative '../Route.rb'
require_relative '../Train.rb'

station_start = Station.new('station_start')
station_end = Station.new('station_end')

route = Route.new(station_start, station_end)

print 'stations: '
if(route.way_stations.kind_of?(Array)) 
  puts route.way_stations == [station_start, station_end] ? "[] Expected station list" : "[E] Generated station list has not expected order"
else 
  puts "[E] No stations found" 
end

puts "Start station: " + route.start_station.name
puts "End station: " + route.end_station.name

train = Train.new('001', 't1', 1)
puts "Carrieges before: " + train.carriage_amount.to_s
train.add_carriage
puts "Carrieges after: " + train.carriage_amount.to_s
train.remove_carriage
puts "Carrieges after: " + train.carriage_amount.to_s

train.register_route(route)


station_1 = Station.new('station_1')
route.add_way_station(station_1)
print 'stations: '
if(route.way_stations.kind_of?(Array)) 
  puts route.way_stations == [station_start, station_1, station_end] ? "[] Expected station list" : "[E] Generated station list has not expected order"
else 
  puts "[E] No stations found" 
end

puts 'Next station after start: ' + train.get_next_station.name
puts 'Current station: ' + train.current_station.name + ', route\'s start station: ' + route.start_station.name
puts 'Previous station after start: ' + (train.get_previous_station.nil? ? 'nil' : train.get_previous_station.name)

station_start.send_train(train)
puts train.current_station == station_1 ? "[] Correct next station in route " : "[E] Train should be on `station_1`. Current: " + train.current_station.name
station_1.send_train(train)
puts train.current_station == station_end ? "[] Correct next station in route " : "[E] Train should be on `station_end`. Current: " + train.current_station.name

station_end.send_train(train)
puts train.current_station == station_end ? "[] Correct next station in route " : "[E] Train should be on `station_end`. Current: " + train.current_station.name