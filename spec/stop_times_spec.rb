require 'rspec_helper'

describe 'Times' do
  before do
    @test_station = Station.new({'name' => 'Epicodus', 'location' => '123 Main St'})
    @test_station.save
    @test_line = Line.new({'name' => 'Red Line'})
    @test_line.save
    @test_line.add_to_line(@test_station)
    @test_times = Times.new({'stop_id' => @test_line.join_id, 'times' => ['9:00 am', '10:00 am', '11:00 am']})
  end

  it 'should instantiate a Times class.' do
    expect(@test_times).to be_an_instance_of Times
  end

  it 'will return the attributes of a Times class' do
    expect(@test_times.stop_id).to eq @test_line.join_id
    expect(@test_times.times).to eq ['9:00 am', '10:00 am', '11:00 am']
  end

  it 'will save the info in the Times class instance to the Times table.' do
    expect(Times.all).to eq []
    @test_times.save
    expect(Times.all).to eq [@test_times]
  end

  it 'will return all the times for a given station and line.' do
    @test_times.save
    expect(@test_times.get_times(@test_station, @test_line)).to eq ['9:00 am', '10:00 am', '11:00 am']
  end
end
