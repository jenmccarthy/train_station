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

  it 'will return the values of name and location when asked.' do
    test_station = Station.new({'name' => 'Epicodus', 'location' => '123 Main St'})
    expect(test_station.name).to eq 'Epicodus'
    expect(test_station.location).to eq '123 Main St'
  end

  it 'will return all instances of Station class' do
    expect(Station.all).to eq []
  end
end
