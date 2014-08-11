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

end
