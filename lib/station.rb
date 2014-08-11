class Station

  attr_reader(:name, :location, :id)

  def initialize(attributes)
    @name = attributes['name']
    @location = attributes['location']
    @id = attributes['id'].to_i
    # @join_id = nil
  end

  def self.all
    stations = []
    results = DB.exec("SELECT * FROM stations;")
    results.each do |result|
      current_station = Station.new(result)
      stations << current_station
    end
  stations
  end

  def save
    results = DB.exec("INSERT INTO stations (name, location) VALUES ('#{@name}', '#{@location}') RETURNING id;")
    @id = results.first['id'].to_i
  end

  def ==(other_station)
    @name == other_station.name && @location == other_station.location && @id == other_station.id
  end

  def edit_name(input_name)
    @name = input_name
    results = DB.exec("UPDATE stations SET name = '#{@name}' WHERE id = '#{self.id}';")
  end

  def edit_location(input_location)
    results = DB.exec("UPDATE stations SET location = '#{input_location}' WHERE id = '#{self.id}';")
    @location = input_location
  end

  def delete
    DB.exec("DELETE FROM stations WHERE id = '#{self.id}';")
  end

  def list_lines
    lines = []
    results = DB.exec("SELECT * FROM lines_stations WHERE station_id = #{@id};")
    results.each do |result|
      line_id = result['line_id'].to_i
      line_rows = DB.exec("SELECT * FROM lines WHERE id = #{line_id};")
      line_rows.each do |line_row|
        lines << Line.new(line_row)
      end
    end
    lines
  end
end
