# frozen_string_literal: true

require_relative "../../lesson_4/trains/cargo_train"
require_relative "../../lesson_4/trains/passenger_train"

train1 = CargoTrain.new("train1")
train2 = PassengerTrain.new("train2")

if train2.instance_of? PassengerTrain
  puts "PassengerTrain created successfully"
else
  puts "Error. Can't create instance of PassengerTrain"
end

if PassengerTrain.find("train1") == train1
  puts "Train2 found by number correctly."
else
  puts "Error. Can't find train2 by number"
end

if CargoTrain.find("another_train").nil?
  puts "Result has correct value for unknown train number"
else
  puts "Error. Incorrect result for unknow train number"
end
