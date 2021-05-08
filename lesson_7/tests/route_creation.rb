require_relative "../../lesson_4/route"
require_relative "../../lesson_4/trains/cargo_train"

if Route.method_defined?("validate")
  puts "Class Route has method `validate`"
else
  puts "Error. Class CargoRoute hasn't method `validate`"
end

if Route.method_defined?("valid?")
  puts "Class Route has method `valid?`"
else
  puts "Error. Class CargoRoute hasn't method `valid?`"
end

station_start = Station.new("123")
station_end = Station.new("123")
train1 = CargoTrain.new("113")

begin
  Route.new(station_start, nil)
  puts "Error. Route shouldn't be created without end station"
rescue StandardError => e
  puts "Route without end station doesn't create"
end

begin
  Route.new(nil, station_end)
  puts "Error. Route shouldn't be created without start station"
rescue StandardError => e
  puts "Route without start station doesn't create"
end

begin
  Route.new(station_start, train1)
  puts "Error. Route shouldn't be created with incorrect end station"
rescue StandardError => e
  puts "Route with incorrect end station doesn't create"
end

begin
  Route.new(train1, station_end)
  puts "Error. Route shouldn't be created with incorrect start station"
rescue StandardError => e
  puts "Route with incorrect start station doesn't create"
end

begin
  Route.new(train1, station_end)
  puts "Error. Route shouldn't be created without start station"
rescue StandardError => e
  puts "Route without start station doesn't create"
end

route = Route.new(station_start, station_end)
if route.valid?
  puts "Created Route with correct values validates successfully"
else
  puts "Error. Created Route with correct values returns wrong valid status. [ER] true [AR] false"
end

station_middle = Station.new("Middle Station")
route.add_way_station(station_middle)
if route.valid?
  puts "Route with more than 2 stations validates successfully"
else
  puts "Error. Route with more than 2 stations returns wrong valid status. [ER] true [AR] false"
end
