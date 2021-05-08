require_relative '../../lesson_4/trains/cargo_train'
require_relative '../../lesson_4/trains/passenger_train'

if Train.method_defined?('validate')
  puts "Class Train has method `validate`"
else
  puts "Error. Class CargoTrain hasn't method `validate`"
end

if Train.method_defined?('valid?')
  puts "Class Train has method `valid?`"
else
  puts "Error. Class CargoTrain hasn't method `valid?`"
end

begin
  Train.new('station1', 'type1')
  puts "Error. Train shouldn't be created with wrong number"
rescue StandardError => e
  puts "Train with wrong number doesn't create: #{e.message}"
end

begin
  Train.new(111)
  puts "Error. Train shouldn't be created without type"
rescue StandardError => e
  puts "Train without a type doesn't create: #{e.message}"
end

begin
  Train.new(111, 1)
  puts "Error. Train shouldn't be created with wrong type"
rescue StandardError => e
  puts "Train with wrong type doesn't create: #{e.message}"
end

begin
  Train.new('aa111', 'type1')
  puts "Train with correct values creates successfully"
rescue StandardError => e
  puts "Error. Train doesn't create with correct values: #{e.message}"
end

train = Train.new('ввф23', 'type2')
if train.valid?
  puts "Created Train with correct values validates successfully"
else
  puts "Error. Created Train with correct values returns wrong valid status. [ER] true [AR] false"
end

train.number = 'йцук'
if !train.valid?
  puts "Train with incorrect number not valid"
else
  puts "Error. Train with incorrect number shouldn't be valid. [ER] false [AR] true"
end
train.number = '223'

## validate name format
train_check_number_format = Train.new('fed-12', 'type2')

if train_check_number_format.valid?
  puts "Train with correct number validates successfully"
else
  puts "Error. Train with correct number should be valid. [ER] true [AR] false"
end


train_check_number_format.number = 'f-2'
if !train_check_number_format.valid?
  puts "Train with incorrect number not valid"
else
  puts "Error. Train with incorrect number returns wrong valid status. [ER] false [AR] true"
end


train_check_number_format.number = 'fedЫЯ'
if train_check_number_format.valid?
  puts "Train with correct number validates successfully"
else
  puts "Error. Train with correct number should be valid. [ER] true [AR] false"
end
