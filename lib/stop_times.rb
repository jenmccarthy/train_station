require 'Chronic'

class Times

  attr_reader :stop_id, :times, :ids

  def initialize(attributes)
    @stop_id = attributes['stop_id'].to_i
    @times = attributes['times']
    @ids = []
    if attributes['ids'] != nil
      @ids = attributes['ids']
    end
  end

  def self.all
    selfs = []
    stop_ids = []
    current_times = []
    current_ids = []
    results = DB.exec("SELECT * FROM times;")
    results.each do |result|
      if !stop_ids.include? result['stop_id'].to_i
        stop_ids << result['stop_id'].to_i
      end
    end

    stop_ids.each do |stop_id|
      results = DB.exec("SELECT * FROM times WHERE stop_id = #{stop_id};")
      results.each do |result|
        current_times << result['time']
        current_ids << result['id'].to_i
      end
      selfs << Times.new({'stop_id' => stop_id, 'times' => current_times, 'ids' => current_ids})
    end
    selfs
  end

  def save
    self.times.each do |time|
      results = DB.exec("INSERT INTO times (stop_id, time) VALUES (#{@stop_id}, '#{time}') RETURNING id;")
      @ids << results.first['id'].to_i
    end
  end

  def ==(another_time)
    @times == another_time.times && @stop_id == another_time.stop_id && @ids == another_time.ids
  end

  def self.get_times(input_station, input_line)
    stop_id = nil
    times = []

    results = DB.exec("SELECT * FROM lines_stations WHERE station_id = #{input_station.id} and line_id = #{input_line.id}")
    stop_id = results.first['id']

    results = DB.exec("SELECT * FROM times WHERE stop_id = #{stop_id};")
    results.each do |result|
      times << result['time']
    end
    times
  end

  def get_station_times(line)
    output_stations_with_times = {}
    stations = line.list_stations
    stations.each do |station|
      times = Times.get_times(station, line)
      output_stations_with_times[station.id] = times
    end
    output_stations_with_times
  end

  def self.get_all_next_times(user_station, user_time)
    output_lines_with_times = {}
    lines = user_station.list_lines
    lines.each do |line|
      times = Times.get_times(user_station, line)
      times.each do |time|
        if Chronic.parse(user_time) < Chronic.parse(time)
          output_lines_with_times[line.id] = time
          break
        end
      end
    end
    output_lines_with_times
  end

end
