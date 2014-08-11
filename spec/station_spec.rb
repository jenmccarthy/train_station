require 'rspec'
require 'station.rb'
require 'line.rb'
require 'pry'
require 'pg'

DB = PG.connect({:dbname => 'train_system'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM stations *;")
  end
end

describe 'Station' do


  it 'will initialize with a name and location' do
    test_station = Station.new({'name' => 'Epicodus', 'location' => '123 Main St'})
    expect(test_station).to be_an_instance_of Station
  end

  it 'will return the values of name and location when asked.' do
    test_station = Station.new({'name' => 'Epicodus', 'location' => '123 Main St'})
    expect(test_station.name).to eq 'Epicodus'
    expect(test_station.location).to eq '123 Main St'
  end

  it 'will return all instances of Station class' do
    expect(Station.all).to eq []
  end

  it 'will save the current Station instance to the database.' do
    test_station = Station.new({'name' => 'Epicodus', 'location' => '123 Main St'})
    test_station.save
    expect(Station.all).to eq [test_station]
  end

  it 'will save a new name for the current Station to the object and the database.' do
    test_station = Station.new({'name' => 'Epicodus', 'location' => '123 Main St'})
    test_station.save
    test_station.edit_name('New_Epicodus')
    expect(Station.all).to eq [test_station]
    expect(test_station.name).to eq 'New_Epicodus'
  end

  it 'will save a new location for the current Station to the object and the database.' do
    test_station = Station.new({'name' => 'Epicodus', 'location' => '123 Main St'})
    test_station.save
    test_station.edit_location('555 Broadway St')
    expect(Station.all).to eq [test_station]
    expect(test_station.location).to eq '555 Broadway St'
  end

  it 'will delete this station from the table' do
    test_station = Station.new({'name' => 'Epicodus', 'location' => '123 Main St'})
    test_station.save
    test_station.delete
    expect(Station.all).to eq []
  end

  it 'will list all train lines which use the current station.' do
    test_station = Station.new({'name' => 'Epicodus', 'location' => '123 Main St'})
    test_station.save
    test_line = Line.new({'name' => 'Red Line'})
    test_line.save
    test_line.add_to_line(test_station)
    expect(test_station.list_lines).to eq [test_line]
  end
end
