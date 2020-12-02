require_relative 'station'

class Controller
  
  def initialize
    @stations = []
    @actions = [
      {'label' => "Добавить станцию", 'action' => :add_station},
      {'label' => "Список всех станций", 'action' => :print_stations},
    ]
  end

  def print_menu
    puts "Меню:"
    i = 0
    @actions.each do |menu_item|
      i += 1
      puts "\t#{i}. #{menu_item['label']}"
    end
  end

  def has_action?(index)
    !@actions[index-1].nil?
  end

  def call(index)
    method(@actions[index-1]['action']).call
  end

  def add_station
    printf "Добавление новой станции.\n\tВведите название станции: " 
    @stations.push(Station.new(gets.chomp))
  end

  def print_stations
    i = 0
    puts "Список зарегистрированных станций:"
    @stations.each { |station| i += 1; puts "\t#{i}. #{station.name}"}
  end

end