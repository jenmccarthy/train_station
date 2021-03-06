require 'rspec_helper'

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

  it 'will delete all instances of a station from join table' do
    test_station = Station.new({'name' => 'Epicodus', 'location' => '123 Main St'})
    test_station.save
    test_line = Line.new({'name' => 'Red Line'})
    test_line.save
    test_line.add_to_line(test_station)
    expect(Station.all).to eq [test_station]
    expect(test_line.list_stations).to eq [test_station]
    test_station.delete
    expect(Station.all).to eq []
    expect(test_line.list_stations).to eq []
    expect(test_line.get_pairs).to eq []
  end

  it 'will return all pairs of station id and line ids.' do
    test_station = Station.new({'name' => 'Epicodus', 'location' => '123 Main St'})
    test_station.save
    test_line = Line.new({'name' => 'Red Line'})
    test_line.save
    test_line.add_to_line(test_station)
    expect(test_line.get_pairs).to eq [[test_line.join_id, test_line.id, test_station.id]]
  end
end
