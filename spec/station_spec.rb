require 'rspec'
require 'station.rb'
require 'pry'
require 'pg'

DB = PG.connect({:dbname => 'train_system'})

describe 'Station' do
  it 'will initialize with a name and location' do
    test_station = Station.new({'name' => 'Epicodus', 'location' => '123 Main St'})
    expect(test_station).to be_an_instance_of Station
  end
end
