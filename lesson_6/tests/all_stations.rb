require_relative '../../lesson_4/station'

station1 = Station.new('station1')
station2 = Station.new('station2')

if station1.instance_of?(Station) && station2.instance_of?(Station)
  puts "Objects are created succesfully"
else
  puts "Error. Station Objects didn't create"
end

if Station.all.length == 2 && Station.all[0] == station1
  puts "Station class stores all created objects"
else
  puts "Error. Station class does'nt store created objects"
end

count_of_station_before = station2.class.all.length
station3 = Station.new('station3')
if station2.class.all.length === 3 && count_of_station_before === 2
  puts "Station class stores all created objects correctly"
else
  puts "Error. Station class count is wrong"
end