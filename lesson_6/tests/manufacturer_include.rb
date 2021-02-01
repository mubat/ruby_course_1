require_relative '../../lesson_4/trains/cargo_train'
require_relative '../../lesson_6/manufacturer'

if CargoTrain.ancestors.include? Manufacturer
   puts "Class CargoTrain includes `Manufacturer` module"
else 
  puts "Error. Class CargoTrain doesn't include `Manufacturer` module" 
end

if CargoTrain.method_defined?('manufacturerName=')
  puts "Class CargoTrain has method `manufacturerName=`"
else 
  puts "Error. Class CargoTrain hasn't method `manufacturerName=`"
end

cargo_train = CargoTrain.new('1')
cargo_train.manufacturerName = 'test_manufacturer'
if cargo_train.manufacturerName === 'test_manufacturer'
  puts "Instance of CargoTrain can set and get manufacturer name"
else 
  puts "Error. Instance of CargoTrain doesn't can set and get manufacturer name" 
end

