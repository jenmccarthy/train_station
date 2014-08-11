require 'rspec'
require 'station.rb'
require 'line.rb'
require 'pry'
require 'pg'

DB = PG.connect({:dbname => 'train_system'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM lines *;")
  end
end

describe 'Line' do

  it 'will initialize an instance of Line class.' do
    test_line = Line.new({'name' => 'Red Line'})
    expect(test_line).to be_an_instance_of Line
  end

  it 'will return the attributes of Line class' do
    test_line = Line.new({'name' => 'Red Line'})
    expect(test_line.name).to eq 'Red Line'
  end

  it 'will start with no Lines' do
    expect(Line.all).to eq []
  end

  it 'will save a Line to the database.' do
    test_line = Line.new({'name' => 'Red Line'})
    test_line.save
    expect(Line.all).to eq [test_line]
  end

  it 'will edit the name of an instance of Line class object and in the database' do
    test_line = Line.new({'name' => 'Red Line'})
    test_line.save
    test_line.edit_name('Pink Line')
    expect(Line.all).to eq [test_line]
    expect(test_line.name).to eq 'Pink Line'
  end

  it 'will delete this station from the database' do
    test_line = Line.new({'name' => 'Red Line'})
    test_line.save
    expect(Line.all).to eq [test_line]
    test_line.delete
    expect(Line.all).to eq []
  end

end
