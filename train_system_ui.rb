require './lib/station.rb'
require './lib/line.rb'
require './lib/stop_times.rb'
require 'pg'

DB = PG.connect({:dbname => 'train_system'})

def main_menu
  loop do
    puts "Press [a] to add a station"
    puts "Press [x] to exit"
    menu_choice = gets.chomp
    if menu_choice == 'a'
      add_station
    elsif menu_choice == 'x'
      puts "Goodbye!"
      exit
    else
      puts "That is not a valid input, please choose again"
    end
  end

end

def add_station
  puts "Enter the station name:"
  name = gets.chomp
  puts "Enter a location for this station:"
  location = gets.chomp
  new_station = Station.new({'name' => name, 'location' => location})
  new_station.save
  puts "Station Created!"
  main_menu
end

main_menu
