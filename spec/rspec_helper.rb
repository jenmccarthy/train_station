require 'rspec'
require 'station.rb'
require 'line.rb'
require 'stop_times.rb'
require 'pry'
require 'pg'

DB = PG.connect({:dbname => 'train_system'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM stations *;")
    DB.exec("DELETE FROM lines *;")
    DB.exec("DELETE FROM lines_stations *;")
    DB.exec("DELETE FROM times *;")
  end
end
