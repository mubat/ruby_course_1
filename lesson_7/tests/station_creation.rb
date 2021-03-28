require_relative '../../lesson_4/station'
require_relative '../../lesson_4/trains/cargo_train'

if Station.method_defined?('validate')
  puts "Class Station has method `validate`"
else 
  puts "Error. Class CargoStation hasn't method `validate`"
end

if Station.method_defined?('valid?')
  puts "Class Station has method `valid?`"
else 
  puts "Error. Class CargoStation hasn't method `valid?`"
end

train1 = CargoTrain.new('113')
train2 = CargoTrain.new('114')

begin
  Station.new(111)
  puts "Error. Station shouldn't be created with number as name" 
rescue StandardError => e  
  puts "Station number as name doesn't create" 
end

begin
  Station.new(nil)
  puts "Error. Station shouldn't be created without name" 
rescue StandardError => e  
  puts "Station without name doesn't create" 
end

begin
  Station.new('name')
  puts "Station with correct name created successfully" 
rescue StandardError => e  
  puts "Error. Station with correct name should be created. Error: #{e.message}" 
end




station = Station.new('station1 station')
if station.valid?
  puts "Created Station with correct values validates successfully" 
else
  puts "Error. Created Station with correct values returns wrong valid status. [ER] true [AR] false"
end

station2 = Station.new('station2 station')
train = CargoTrain.new('123')
station2.take_train(train)
if station2.valid?
  puts "Station with added Train validates successfully" 
else 
  puts "Error. Station with added Train shouldn't has errors" 
end
  

station2 = Station.new('station2 station')
station2.take_train('123 train')
if !station2.valid?
  puts "Station with incorrect Train validates successfully" 
else 
  puts "Error. Station with incorrect Train should has errors" 
end
  
