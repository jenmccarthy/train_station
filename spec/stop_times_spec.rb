require 'rspec_helper'

describe 'Times' do

  it 'should instantiate a Times class.' do
    test_station = Station.new({'name' => 'Epicodus', 'location' => '123 Main St'})
    test_station.save
    test_line = Line.new({'name' => 'Red Line'})
    test_line.save
    test_line.add_to_line(test_station)
    test_times = Times.new({'stop_id' => test_line.join_id, 'times' => ['9:00', '10:00', '11:00']})
    expect(test_times).to be_an_instance_of Times
  end
end
