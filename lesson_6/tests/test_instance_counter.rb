require_relative '../../lesson_4/station'
# require_relative '../instance_counter'

station1 = Station.new('station1')
station2 = Station.new('station2')

if Station.ancestors.include? InstanceCounter
   puts "Class Station includes `InstanceCounter` module"
else 
  puts "Error. Class Station doesn't include `InstanceCounter` module" 
  p Station.ancestors
end

if Station.methods.include? :instances
   puts "Class Station includes `instances` method from module"
else 
  puts "Error. Class Station doesn't include `instances` method from module"
end

if Station.instances == 2
   puts "Class Station returns correct amount of created instances"
else 
  puts "Error. Class Station doesn't returns correct amount of created instances"
  puts "ER - 2; AR - " + Station.instances.to_s
end
